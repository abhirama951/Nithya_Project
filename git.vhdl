library ieee;
use ieee.std_logic_1164.all;

library work;

package git is
    constant GIT_HASH : std_ulogic_vector(55 downto 0) := x"684a776274c0c2";
    constant GIT_DIRTY : std_ulogic := '1';
end git;
