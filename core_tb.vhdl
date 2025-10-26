library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity core_tb is
	end entity core_tb;

architecture sim of core_tb is

	    -- Clock and reset
	    signal clk       : std_logic := '0';
	        signal rst       : std_logic := '1';
		    signal irq_out   : std_logic_vector(15 downto 0);

		        -- Clock period
		        constant CLK_PERIOD : time := 20 ns;  -- 50 MHz

begin

	    ----------------------------------------------------------------------
	    -- Clock generation
	    ----------------------------------------------------------------------
	    clk_process : process
		        begin
				        while true loop
						            clk <= '0';
							                wait for CLK_PERIOD/2;
									            clk <= '1';
										                wait for CLK_PERIOD/2;
												        end loop;
													    end process;

													        ----------------------------------------------------------------------
													        -- Reset generation
													        ----------------------------------------------------------------------
													        rst_process : process
															    begin
																            rst <= '1';
																	            wait for 100 ns;
																		            rst <= '0';
																			            wait;
																				        end process;

																					    ----------------------------------------------------------------------
																					    -- Instantiate SoC with LMS wrapper
																					    ----------------------------------------------------------------------
																					    uut : entity work.soc(rtl)
																					            port map (
																						                clk     => clk,
																								            rst     => rst,
																									                irq_out => irq_out
																											        );

end architecture sim;

