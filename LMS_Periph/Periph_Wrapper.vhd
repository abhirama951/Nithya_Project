library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lms_wrapper is
    port (
        clk      : in  std_ulogic;
        rst      : in  std_ulogic;
        wb_adr_i : in  std_ulogic_vector(31 downto 0);
        wb_dat_i : in  std_ulogic_vector(15 downto 0);
        wb_dat_o : out std_ulogic_vector(15 downto 0);
        wb_we_i  : in  std_ulogic;
        wb_stb_i : in  std_ulogic;
        wb_cyc_i : in  std_ulogic;
        wb_ack_o : out std_ulogic;
        irq_o    : out std_ulogic
    );
end entity lms_wrapper;

architecture rtl of lms_wrapper is

    -- Component declaration for your Verilog wb_lms
    component wb_lms
        port (
            Clk      : in  std_logic;
            Rst      : in  std_logic;
            wb_cyc_i : in  std_logic;
            wb_stb_i : in  std_logic;
            wb_we_i  : in  std_logic;
            wb_adr_i : in  std_logic_vector(31 downto 0);
            wb_dat_i : in  std_logic_vector(15 downto 0);
            wb_dat_o : out std_logic_vector(15 downto 0);
            wb_ack_o : out std_logic;
            irq_o    : out std_logic
        );
    end component;

    signal wb_dat_o_s : std_logic_vector(15 downto 0);
    signal wb_ack_s   : std_logic;
    signal irq_s      : std_logic;

begin

    -- Instantiate the Verilog LMS WB peripheral
    lms_inst : wb_lms
        port map (
            Clk      => std_logic(clk),
            Rst      => std_logic(rst),
            wb_cyc_i => std_logic(wb_cyc_i),
            wb_stb_i => std_logic(wb_stb_i),
            wb_we_i  => std_logic(wb_we_i),
            wb_adr_i => std_logic_vector(wb_adr_i),
            wb_dat_i => std_logic_vector(wb_dat_i),
            wb_dat_o => wb_dat_o_s,
            wb_ack_o => wb_ack_s,
            irq_o    => irq_s
        );

    -- Map outputs
    wb_dat_o <= std_ulogic_vector(wb_dat_o_s);
    wb_ack_o <= wb_ack_s;
    irq_o    <= irq_s;

end architecture rtl;

-- Configuration to indicate this is a Verilog entity
configuration lms_wrapper_cfg of lms_wrapper is
    for rtl
        for lms_inst : wb_lms
            use entity work.wb_lms(verilog);
        end for;
    end for;
end configuration lms_wrapper_cfg;

