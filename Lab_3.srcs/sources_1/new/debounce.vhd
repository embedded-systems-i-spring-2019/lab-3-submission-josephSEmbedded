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

entity debounce is
    Port( signal clk : in std_logic;
          signal btn : in std_logic;
          signal dbnc : out std_logic);
end debounce;

architecture Behavioral of debounce is

signal counter : std_logic_vector(21 downto 0) := (others => '0');
signal shift_register :  std_logic_vector(1 downto 0) := (others => '0');
signal temp_shift : std_logic;

begin

process(clk)
begin
    if(rising_edge(clk)) then
        temp_shift <= shift_register(0);
        shift_register(0) <= btn;
        shift_register(1) <= temp_shift;
        if shift_register(1) = '1' then
            counter <= std_logic_vector(unsigned(counter)+1);
            if unsigned(counter) = 2500000 then
                dbnc <= '1';
            end if;
        else 
            counter <= (others => '0');
            dbnc <= '0';
        end if;
    end if;
end process;



end Behavioral;
