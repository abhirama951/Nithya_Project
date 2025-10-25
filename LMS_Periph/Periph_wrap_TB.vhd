library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity tb_lms_wrapper is
end entity;

architecture sim of tb_lms_wrapper is

    -- Clock and reset
    signal clk      : std_ulogic := '0';
    signal rst      : std_ulogic := '1';

    -- Wishbone signals
    signal wb_adr_i : std_ulogic_vector(31 downto 0) := (others => '0');
    signal wb_dat_i : std_ulogic_vector(15 downto 0) := (others => '0');
    signal wb_dat_o : std_ulogic_vector(15 downto 0);
    signal wb_we_i  : std_ulogic := '0';
    signal wb_stb_i : std_ulogic := '0';
    signal wb_cyc_i : std_ulogic := '0';
    signal wb_ack_o : std_ulogic;
    signal irq_o    : std_ulogic;

    -- Stimulus arrays
    type int_array is array (0 to 99) of integer;
    signal x_data : int_array := (others => 0);
    signal d_data : int_array := (others => 0);

    -- File handling
    file output_file : text open write_mode is "wb_lms_output.csv";

    constant clk_period : time := 10 ns;

begin

    -- Clock generation
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for clk_period/2;
            clk <= '1';
            wait for clk_period/2;
        end loop;
    end process;

    -- DUT instantiation
    DUT: entity work.lms_wrapper
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

    -- -----------------------------
    -- WB write procedure
    -- -----------------------------
    procedure wb_write(addr : in std_ulogic_vector(31 downto 0);
                       data : in std_ulogic_vector(15 downto 0)) is
    begin
        wb_cyc_i <= '1'; wb_stb_i <= '1'; wb_we_i <= '1';
        wb_adr_i <= addr;
        wb_dat_i <= data;
        wait until rising_edge(clk);
        wait until wb_ack_o = '1';
        wb_cyc_i <= '0'; wb_stb_i <= '0'; wb_we_i <= '0';
        wait until falling_edge(clk);
    end procedure;

    -- -----------------------------
    -- WB read procedure
    -- -----------------------------
    procedure wb_read(addr : in std_ulogic_vector(31 downto 0);
                      data_out : out std_ulogic_vector(15 downto 0)) is
    begin
        wb_cyc_i <= '1'; wb_stb_i <= '1'; wb_we_i <= '0';
        wb_adr_i <= addr;
        wait until rising_edge(clk);
        wait until wb_ack_o = '1';
        data_out <= wb_dat_o;
        wb_cyc_i <= '0'; wb_stb_i <= '0';
        wait until falling_edge(clk);
    end procedure;

    -- -----------------------------
    -- Main test process
    -- -----------------------------
    stim_proc: process
        variable line_out : line;
        variable y, e, w0, w1, w2, w3 : std_ulogic_vector(15 downto 0);
    begin
        -- Reset
        rst <= '1';
        wait for 2*clk_period;
        rst <= '0';
        wait for 2*clk_period;

        -- Write CSV header
        write(line_out, string'("time,x_in,y_out,d_in,err,w0,w1,w2,w3"));
        writeline(output_file, line_out);

        -- -----------------------------
        -- Training mode
        -- -----------------------------
        wb_write(x"08", x"0001"); -- mode_train = 1

        for i in 0 to 99 loop
            -- Set inputs
            wb_write(x"00", std_logic_vector(to_signed(x_data(i),16))); -- x_in
            wb_write(x"04", std_logic_vector(to_signed(d_data(i),16))); -- d_in

            -- Read outputs
            wb_read(x"0C", y);  -- y_out
            wb_read(x"10", e);  -- err
            wb_read(x"14", w0);
            wb_read(x"18", w1);
            wb_read(x"1C", w2);
            wb_read(x"20", w3);

            -- Log to CSV
            write(line_out, time'image(now) & "," &
                            integer'image(to_integer(signed(std_logic_vector(to_signed(x_data(i),16))))) & "," &
                            integer'image(to_integer(signed(y))) & "," &
                            integer'image(to_integer(signed(std_logic_vector(to_signed(d_data(i),16))))) & "," &
                            integer'image(to_integer(signed(e))) & "," &
                            integer'image(to_integer(signed(w0))) & "," &
                            integer'image(to_integer(signed(w1))) & "," &
                            integer'image(to_integer(signed(w2))) & "," &
                            integer'image(to_integer(signed(w3))));
            writeline(output_file, line_out);
            wait for clk_period;
        end loop;

        -- -----------------------------
        -- Filter mode
        -- -----------------------------
        wb_write(x"08", x"0000"); -- mode_train = 0

        for i in 0 to 99 loop
            wb_write(x"00", std_logic_vector(to_signed(x_data(i),16)));
            wb_write(x"04", x"0000"); -- d_in unused

            wb_read(x"0C", y);  -- y_out
            wb_read(x"10", e);  -- err
            wb_read(x"14", w0);
            wb_read(x"18", w1);
            wb_read(x"1C", w2);
            wb_read(x"20", w3);

            -- Log to CSV
            write(line_out, time'image(now) & "," &
                            integer'image(to_integer(signed(std_logic_vector(to_signed(x_data(i),16))))) & "," &
                            integer'image(to_integer(signed(y))) & "," &
                            integer'image(0) & "," &  -- d_in unused
                            integer'image(to_integer(signed(e))) & "," &
                            integer'image(to_integer(signed(w0))) & "," &
                            integer'image(to_integer(signed(w1))) & "," &
                            integer'image(to_integer(signed(w2))) & "," &
                            integer'image(to_integer(signed(w3))));
            writeline(output_file, line_out);
            wait for clk_period;
        end loop;

        wait;
    end process;

end architecture sim;

