library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity soc is
	    port (
	            clk      : in  std_logic;
	            rst      : in  std_logic;
	            irq_out  : out std_logic_vector(15 downto 0)  -- 16 IRQ lines
		        );
end entity soc;

architecture rtl of soc is

	    ----------------------------------------------------------------------
	    -- Signals for LMS wrapper
	    ----------------------------------------------------------------------
	    signal wb_dat_o_lms : std_logic_vector(15 downto 0);
	        signal wb_ack_lms   : std_logic;
		    signal irq_lms      : std_logic;

		        -- Wishbone signals for LMS wrapper
		        signal lms_wb_adr_i : std_logic_vector(31 downto 0);
			    signal lms_wb_dat_i : std_logic_vector(15 downto 0);
			        signal lms_wb_we_i  : std_logic;
				    signal lms_wb_stb_i : std_logic;
				        signal lms_wb_cyc_i : std_logic;

begin

	    ----------------------------------------------------------------------
	    -- Instantiate LMS wrapper peripheral
	    ----------------------------------------------------------------------
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

																		        ----------------------------------------------------------------------
																		        -- Example Wishbone connection
																		        -- Replace these with your actual master signals
																		        ----------------------------------------------------------------------
																		        lms_wb_adr_i <= (others => '0');
																			    lms_wb_dat_i <= (others => '0');
																			        lms_wb_we_i  <= '0';
																				    lms_wb_stb_i <= '0';
																				        lms_wb_cyc_i <= '0';

																					    -- Connect LMS IRQ to IRQ0
																					    irq_out(0) <= irq_lms;

																					        -- Clear other IRQs for now
																					        irq_out(15 downto 1) <= (others => '0');

end architecture rtl;

