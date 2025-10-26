-- ============================================================================
--  Microwatt SoC (Modified)
--  Integrated with LMS Adaptive Filter Peripheral (lms_wrapper)
-- ============================================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity soc is
    port (
        clk        : in  std_logic;
        rst        : in  std_logic;

        -- UART
        uart_txd   : out std_logic;
        uart_rxd   : in  std_logic;

        -- GPIO
        gpio_out   : out std_logic_vector(31 downto 0);
        gpio_in    : in  std_logic_vector(31 downto 0)
    );
end entity soc;

architecture rtl of soc is

    --------------------------------------------------------------------------
    -- Wishbone master (from CPU)
    --------------------------------------------------------------------------
    signal wb_clk       : std_logic;
    signal wb_rst       : std_logic;
    signal wb_adr       : std_logic_vector(31 downto 0);
    signal wb_dat_mosi  : std_logic_vector(31 downto 0);
    signal wb_dat_miso  : std_logic_vector(31 downto 0);
    signal wb_we        : std_logic;
    signal wb_stb       : std_logic;
    signal wb_cyc       : std_logic;
    signal wb_ack       : std_logic;

    --------------------------------------------------------------------------
    -- LMS Peripheral signals
    --------------------------------------------------------------------------
    signal lms_wb_dat_i : std_logic_vector(15 downto 0);
    signal lms_wb_dat_o : std_logic_vector(15 downto 0);
    signal lms_wb_ack   : std_logic;
    signal lms_irq      : std_logic;

    --------------------------------------------------------------------------
    -- Peripheral select signals
    --------------------------------------------------------------------------
    signal sel_uart : std_logic;
    signal sel_gpio : std_logic;
    signal sel_lms  : std_logic;

begin

    --------------------------------------------------------------------------
    -- Clock & Reset
    --------------------------------------------------------------------------
    wb_clk <= clk;
    wb_rst <= rst;

    --------------------------------------------------------------------------
    -- Address decoding
    --   0xC0001000 -> UART
    --   0xC0002000 -> GPIO
    --   0xC0009000 -> LMS Peripheral
    --------------------------------------------------------------------------
    sel_uart <= '1' when (wb_adr(31 downto 12) = x"C0001") else '0';
    sel_gpio <= '1' when (wb_adr(31 downto 12) = x"C0002") else '0';
    sel_lms  <= '1' when (wb_adr(31 downto 12) = x"C0009") else '0';

    --------------------------------------------------------------------------
    -- LMS Wrapper Instantiation
    --------------------------------------------------------------------------
    lms_inst : entity work.lms_wrapper
        port map (
            clk      => wb_clk,
            rst      => wb_rst,
            wb_adr_i => std_ulogic_vector(wb_adr),
            wb_dat_i => std_ulogic_vector(wb_dat_mosi(15 downto 0)),
            wb_dat_o => lms_wb_dat_o,
            wb_we_i  => wb_we,
            wb_stb_i => wb_stb and sel_lms,
            wb_cyc_i => wb_cyc and sel_lms,
            wb_ack_o => lms_wb_ack,
            irq_o    => lms_irq
        );

    --------------------------------------------------------------------------
    -- Simple peripheral mux (read data + ack)
    --------------------------------------------------------------------------
    process(sel_uart, sel_gpio, sel_lms,
            wb_dat_miso, lms_wb_dat_o,
            wb_ack, lms_wb_ack)
    begin
        wb_dat_miso <= (others => '0');
        wb_ack <= '0';

        if sel_uart = '1' then
            -- UART path (not shown)
            wb_ack <= '1';
        elsif sel_gpio = '1' then
            -- GPIO path (not shown)
            wb_ack <= '1';
        elsif sel_lms = '1' then
            wb_dat_miso(15 downto 0) <= std_logic_vector(lms_wb_dat_o);
            wb_ack <= lms_wb_ack;
        end if;
    end process;

    --------------------------------------------------------------------------
    -- IRQ wiring (example)
    -- LMS IRQ connected to system IRQ line 5
    --------------------------------------------------------------------------
    -- irq_lines(5) <= lms_irq; -- uncomment if irq vector exists

    --------------------------------------------------------------------------
    -- Example dummy UART & GPIO (replace with actual modules)
    --------------------------------------------------------------------------
    uart_txd <= '1';
    gpio_out <= (others => '0');

end architecture rtl;
