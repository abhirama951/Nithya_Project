library ieee;
use ieee.std_logic_1164.all;

library work;

package git is
    constant GIT_HASH : std_ulogic_vector(55 downto 0) := x"fdb7201d3928d2";
    constant GIT_DIRTY : std_ulogic := '1';
end git;
