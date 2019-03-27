library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sender is
    Port( signal btn, clk, en, rdy, rst :  in std_logic;
          signal char : out std_logic_vector (7 downto 0);
          signal send : out std_logic
    );
end sender;

architecture fsm_sender of sender is
type state is (idle, busyA, busyB, busyC);
signal curr : state := idle;

signal i : std_logic_vector(2 downto 0) := (others => '0');
type alphanum is array (0 to 5) of std_logic_vector(7 downto 0);
signal netid : alphanum := (x"6A",x"73",x"32",x"34",x"32",x"39");

begin
process(clk)
begin
    if(rising_edge(clk)) then
        if en = '1' then
            if rst = '1' then
                char <= (others => '0');
                i <= (others => '0');
                send <= '0';
            end if;
            case curr is
                when idle =>
                    if rdy = '1' and btn = '1' and unsigned(i) < 6 then
                        char <= netid(to_integer(unsigned(i)));
                        curr <= busyA;
                    elsif rdy = '1' and btn = '1' and unsigned(i) = 6 then
                        i <= (others => '0');
                        curr <= idle;
                   end if;
                when busyA =>
                    curr <= busyB;
                when busyB =>
                    send <= '0';
                    curr <= busyC;
                when busyC =>
                    if rdy = '1' and btn = '0' then
                        curr <= idle;
                    else
                        curr <= busyC;
                    end if;
            end case;             
        end if;
    end if;
end process;
end fsm_sender;