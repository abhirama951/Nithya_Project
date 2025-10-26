library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity accel_wrapper is
    port (
        clk      : in  std_ulogic;
        rst      : in  std_ulogic;
        wb_adr_i : in  std_ulogic_vector(29 downto 0);  -- 30-bit addr (matches wb_io_master_out)
        wb_dat_i : in  std_ulogic_vector(31 downto 0);
        wb_dat_o : out std_ulogic_vector(31 downto 0);
        wb_we_i  : in  std_ulogic;
        wb_stb_i : in  std_ulogic;
        wb_cyc_i : in  std_ulogic;
        wb_ack_o : out std_ulogic
    );
end entity accel_wrapper;

architecture rtl of accel_wrapper is

    component accelerator
        port (
            clk   : in  std_logic;
            rst_n : in  std_logic;
            addr  : in  std_logic_vector(29 downto 0);
            wdata : in  std_logic_vector(31 downto 0);
            we    : in  std_logic;
            rdata : out std_logic_vector(31 downto 0)
        );
    end component;

    signal rdata_s : std_logic_vector(31 downto 0);
    signal ack_s   : std_logic := '0';
    signal we_s    : std_logic;

begin
    -- Write enable logic
    we_s <= wb_we_i and wb_stb_i and wb_cyc_i;

    -- Instantiate Verilog accelerator
    accel_inst : accelerator
        port map (
            clk   => std_logic(clk),
            rst_n => not std_logic(rst),
            addr  => std_logic_vector(wb_adr_i),
            wdata => std_logic_vector(wb_dat_i),
            we    => we_s,
            rdata => rdata_s
        );

    -- Read data mapping
    wb_dat_o <= std_ulogic_vector(rdata_s);

    -- Simple 1-cycle ACK generator
    process (clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                ack_s <= '0';
            elsif wb_cyc_i = '1' and wb_stb_i = '1' then
                ack_s <= '1';
            else
                ack_s <= '0';
            end if;
        end if;
    end process;

    wb_ack_o <= ack_s;

end architecture rtl;

configuration accel_wrapper_cfg of accel_wrapper is
    for rtl
        for accel_inst : accelerator
            use entity work.accelerator(verilog);
        end for;
    end for;
end configuration accel_wrapper_cfg;

