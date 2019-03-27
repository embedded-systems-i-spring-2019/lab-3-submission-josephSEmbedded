library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_div is
    Port( signal clock_in : in std_logic;
          signal clock_out : out std_logic);
end clock_div;

architecture Behavioral of clock_div is
signal count : std_logic_vector(10 downto 0) := (others => '0');

begin

process(clock_in)
    begin
        if rising_edge(clock_in) then
            count <= std_logic_vector(unsigned(count)+1);
            --Counts up to 1085
            if count = "10000111101" then
                clock_out <= '1';
                count <= (others => '0');
            else
                clock_out <= '0';
            end if;
        end if;
 end process;
end Behavioral;
