library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity tb_lms_wrapper is
end entity;

architecture sim of tb_lms_wrapper is

    -- Wishbone signals (use std_logic)
    signal clk      : std_logic := '0';
    signal rst      : std_logic := '1';
    signal wb_adr_i : std_logic_vector(31 downto 0) := (others => '0');
    signal wb_dat_i : std_logic_vector(15 downto 0) := (others => '0');
    signal wb_dat_o : std_logic_vector(15 downto 0);
    signal wb_we_i  : std_logic := '0';
    signal wb_stb_i : std_logic := '0';
    signal wb_cyc_i : std_logic := '0';
    signal wb_ack_o : std_logic;
    signal irq_o    : std_logic;

    -- Training data arrays (signed Q4.12)
    type data_array is array (natural range <>) of signed(15 downto 0);
    signal x_data : data_array(0 to 99);
    signal d_data : data_array(0 to 99);

    -- File handle for CSV (declared in architecture)
    file csv_file : text open write_mode is "lms_output.csv";

    -- Scaling factor for Q4.12 (used only for display in VHDL if desired)
    constant SF : real := 1.0 / 4096.0;

begin

    -- Instantiate the VHDL wrapper that binds to the Verilog wb_lms
    dut: entity work.lms_wrapper(rtl)
        port map (
            clk      => clk,
            rst      => rst,
            wb_adr_i => wb_adr_i,
            wb_dat_i => wb_dat_i,
            wb_dat_o => wb_dat_o,
            wb_we_i  => wb_we_i,
            wb_stb_i => wb_stb_i,
            wb_cyc_i => wb_cyc_i,
            wb_ack_o => wb_ack_o,
            irq_o    => irq_o
        );

    -- Clock generation: 10 ns period
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
    end process;

    -- WB write helper (procedure)
    procedure wb_write(addr : in std_logic_vector(31 downto 0);
                       data : in std_logic_vector(15 downto 0)) is
    begin
        -- present the bus signals, wait one rising edge for the DUT to sample
        wb_adr_i <= addr;
        wb_dat_i <= data;
        wb_we_i  <= '1';
        wb_stb_i <= '1';
        wb_cyc_i <= '1';
        wait until rising_edge(clk);
        -- wait for ack from DUT (with timeout safeguard)
        wait until wb_ack_o = '1';
        -- deassert
        wb_we_i  <= '0';
        wb_stb_i <= '0';
        wb_cyc_i <= '0';
        wait until rising_edge(clk);
    end procedure;

    -- WB read helper (procedure)
    procedure wb_read(addr : in std_logic_vector(31 downto 0);
                      data : out std_logic_vector(15 downto 0)) is
    begin
        wb_adr_i <= addr;
        wb_we_i  <= '0';
        wb_stb_i <= '1';
        wb_cyc_i <= '1';
        wait until rising_edge(clk);
        wait until wb_ack_o = '1';
        data := wb_dat_o;
        wb_stb_i <= '0';
        wb_cyc_i <= '0';
        wait until rising_edge(clk);
    end procedure;

    -- Main sim process: load files, train, then filter and log CSV
    sim_proc : process
        -- local variables for reading files and for CSV lines
        file file_in_x : text open read_mode is "x_input.txt";
        file file_in_d : text open read_mode is "d_input.txt";
        variable in_line : line;
        variable sv : std_logic_vector(15 downto 0);
        variable i : integer;
        variable csv_line : line;
        variable y_read, err_read, w0_read, w1_read, w2_read, w3_read : std_logic_vector(15 downto 0);
    begin
        -- reset sequence
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for 20 ns;

        -- -------------------------
        -- Read training files (assumes each line is a 16-bit binary string)
        -- -------------------------
        for i in 0 to 99 loop
            if endfile(file_in_x) then
                report "End of x_input.txt reached early at index " & integer'image(i) severity warning;
                exit;
            end if;
            readline(file_in_x, in_line);
            read(in_line, sv);  -- read 16-bit binary into std_logic_vector
            x_data(i) <= signed(sv);

            if endfile(file_in_d) then
                report "End of d_input.txt reached early at index " & integer'image(i) severity warning;
                exit;
            end if;
            readline(file_in_d, in_line);
            read(in_line, sv);
            d_data(i) <= signed(sv);
        end loop;

        -- -------------------------
        -- Open CSV header
        -- -------------------------
        write(csv_line, string'("time,x_in,y_out,d_in,err,w0,w1,w2,w3"));
        writeline(csv_file, csv_line);

        -- -------------------------
        -- Training phase: enable mode_train = 1
        -- Address map assumed:
        -- 0x00000000 : x_in (write)
        -- 0x00000004 : d_in (write)
        -- 0x00000008 : mode_train (write LSB)
        -- 0x0000000C : y_out (read)
        -- 0x00000010 : err   (read)
        -- 0x00000014 : w0    (read)
        -- 0x00000018 : w1    (read)
        -- 0x0000001C : w2    (read)
        -- 0x00000020 : w3    (read)
        -- -------------------------
        wb_write(x"00000008", x"0001");  -- set mode_train = 1

        for i in 0 to 99 loop
            -- write input and desired
            wb_write(x"00000000", std_logic_vector(x_data(i)));
            wb_write(x"00000004", std_logic_vector(d_data(i)));

            -- give DUT one cycle to process, then read outputs
            wait for 10 ns;

            wb_read(x"0000000C", y_read);
            wb_read(x"00000010", err_read);
            wb_read(x"00000014", w0_read);
            wb_read(x"00000018", w1_read);
            wb_read(x"0000001C", w2_read);
            wb_read(x"00000020", w3_read);

            -- Log CSV: time (ns) and decimal integer fields
            write(csv_line, string'("" & integer'image(integer(now / 1 ns))));
            write(csv_line, string("," & integer'image(to_integer(x_data(i)))));
            write(csv_line, string("," & integer'image(to_integer(signed(y_read)))));
            write(csv_line, string("," & integer'image(to_integer(d_data(i)))));
            write(csv_line, string("," & integer'image(to_integer(signed(err_read)))));
            write(csv_line, string("," & integer'image(to_integer(signed(w0_read)))));
            write(csv_line, string("," & integer'image(to_integer(signed(w1_read)))));
            write(csv_line, string("," & integer'image(to_integer(signed(w2_read)))));
            write(csv_line, string("," & integer'image(to_integer(signed(w3_read)))));
            writeline(csv_file, csv_line);
        end loop;

        -- -------------------------
        -- Filter phase: disable training, replay inputs and log outputs
        -- -------------------------
        wb_write(x"00000008", x"00000000");  -- mode_train = 0

        for i in 0 to 99 loop
            wb_write(x"00000000", std_logic_vector(x_data(i)));
            wb_write(x"00000004", x"00000000"); -- d_in unused

            wait for 10 ns;

            wb_read(x"0000000C", y_read);
            wb_read(x"00000010", err_read);
            wb_read(x"00000014", w0_read);
            wb_read(x"00000018", w1_read);
            wb_read(x"0000001C", w2_read);
            wb_read(x"00000020", w3_read);

            write(csv_line, string'("" & integer'image(integer(now / 1 ns))));
            write(csv_line, string("," & integer'image(to_integer(x_data(i)))));
            write(csv_line, string("," & integer'image(to_integer(signed(y_read)))));
            write(csv_line, string("," & integer'image(to_integer(d_data(i)))));
            write(csv_line, string("," & integer'image(to_integer(signed(err_read)))));
            write(csv_line, string("," & integer'image(to_integer(signed(w0_read)))));
            write(csv_line, string("," & integer'image(to_integer(signed(w1_read)))));
            write(csv_line, string("," & integer'image(to_integer(signed(w2_read)))));
            write(csv_line, string("," & integer'image(to_integer(signed(w3_read)))));
            writeline(csv_file, csv_line);
        end loop;

        -- finish simulation
        wait for 20 ns;
        wait;
    end process sim_proc;

end architecture sim;

