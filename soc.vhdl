library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity soc is
    port (
        clk      : in  std_logic;
        rst      : in  std_logic;
        irq_out  : out std_logic_vector(15 downto 0)
        -- other SoC ports like UART, GPIO, SPI can be added here
    );
end entity soc;

architecture rtl of soc is

    -- ========================================================
    -- LMS Wishbone signals
    -- ========================================================
    signal wb_dat_o_lms : std_logic_vector(15 downto 0);
    signal wb_ack_lms   : std_logic;
    signal irq_lms      : std_logic;

    signal lms_wb_adr_i : std_logic_vector(31 downto 0);
    signal lms_wb_dat_i : std_logic_vector(15 downto 0);
    signal lms_wb_dat_o : std_logic_vector(15 downto 0);
    signal lms_wb_we_i  : std_logic;
    signal lms_wb_stb_i : std_logic;
    signal lms_wb_cyc_i : std_logic;
    signal lms_wb_ack_o : std_logic;

    -- Dummy master signals for simulation
    signal sim_master_addr : std_logic_vector(31 downto 0);
    signal sim_master_data : std_logic_vector(15 downto 0);
    signal sim_master_we   : std_logic;
    signal sim_master_stb  : std_logic;
    signal sim_master_cyc  : std_logic;
    signal sim_master_ack  : std_logic;
    signal sim_master_data_out : std_logic_vector(15 downto 0);

begin

    -- ========================================================
    -- LMS Wrapper Instance
    -- ========================================================
    lms_inst : entity work.lms_wrapper(rtl)
        port map (
            clk      => clk,
            rst      => rst,
            wb_adr_i => lms_wb_adr_i,
            wb_dat_i => lms_wb_dat_i,
            wb_dat_o => wb_dat_o_lms,
            wb_we_i  => lms_wb_we_i,
            wb_stb_i => lms_wb_stb_i,
            wb_cyc_i => lms_wb_cyc_i,
            wb_ack_o => wb_ack_lms,
            irq_o    => irq_lms
        );

    -- ========================================================
    -- Connect LMS to simulation master
    -- ========================================================
    lms_wb_adr_i <= sim_master_addr;
    lms_wb_dat_i <= sim_master_data;
    lms_wb_we_i  <= sim_master_we;
    lms_wb_stb_i <= sim_master_stb;
    lms_wb_cyc_i <= sim_master_cyc;

    sim_master_ack <= wb_ack_lms;
    sim_master_data_out <= wb_dat_o_lms;

    -- connect LMS IRQ to SoC IRQ0
    irq_out(0) <= irq_lms;

    -- tie unused IRQs to 0
    irq_out(15 downto 1) <= (others => '0');

    -- ========================================================
    -- Simulation master driver (dummy)
    -- ========================================================
    process(clk, rst)
    begin
        if rst = '1' then
            sim_master_addr <= (others => '0');
            sim_master_data <= (others => '0');
            sim_master_we   <= '0';
            sim_master_stb  <= '0';
            sim_master_cyc  <= '0';
        elsif rising_edge(clk) then
            -- simple simulation pattern: read/write LMS periodically
            sim_master_addr <= x"00000000";
            sim_master_data <= x"1234";
            sim_master_we   <= '1';
            sim_master_stb  <= '1';
            sim_master_cyc  <= '1';
        end if;
    end process;

end architecture rtl;
