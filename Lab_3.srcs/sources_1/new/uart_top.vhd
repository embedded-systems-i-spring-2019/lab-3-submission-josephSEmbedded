----------------------------------------------------------------------------------

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity uart_top is
    Port ( signal TXD : in std_logic;
           signal btn : in std_logic_vector(1 downto 0);
           signal clk : in std_logic;
           signal RXD : out std_logic;
           signal CTS : out std_logic := '0';
           signal RTS : out std_logic := '0'
     );
end uart_top;

architecture structural of uart_top is


component debounce is
port ( clk : in std_logic;
       btn : in std_logic;
       dbnc : out std_logic
       );
end component;


component clock_div is
port ( clock_in : in std_logic;
       clock_out : out std_logic
       );
end component;

component sender is
port( btn : in std_logic;
      clk : in std_logic;
      en : in std_logic;
      rdy : in std_logic;
      rst : in std_logic;
      char : out std_logic_vector(7 downto 0);
      send : out std_logic
      );
end component;

component uart is
port( charSend : in std_logic_vector(7 downto 0);
      clk : in std_logic;
      en : in std_logic;
      rst : in std_logic;
      rx : in std_logic;
      send : in std_logic;
      ready : out std_logic;
      tx : out std_logic
      );
 end component;

--Recieves btn(0) Goes to rst in uart and rst in sender
signal dbnce1 : std_logic;
--Receives btn(1) Goes to btn in sender
signal dbnce2 : std_logic;
--Goes to en of both sender and uart
signal divided_clk : std_logic;
--Comes from char in sender and goes to charSend in uart
signal char_out : std_logic_vector(7 downto 0);
--Comes from send in sender and goes to send in uart
signal send_sig : std_logic;
--Comes from ready in uart and goes to rdy in sender
signal RUrdy : std_logic;

begin

debounce1 : debounce port map(
    clk => clk,
    btn => btn(0),
    dbnc => dbnce1
    );
 
debounce2 : debounce port map(
    clk => clk,
    btn => btn(1),
    dbnc => dbnce2
    );

clock_divider : clock_div port map(
    clock_in => clk,
    clock_out => divided_clk
    );
    
senderBlock : sender port map(
    btn => dbnce2,
    clk => clk,
    en => divided_clk,
    rdy => RUrdy,
    rst => dbnce1,
    char => char_out,
    send => send_sig
    );
    
uart_block : uart port map(
    charSend => char_out,
    clk => clk,
    en => divided_clk,
    rst => dbnce1,
    rx => TXD,
    send => send_sig,
    ready => RUrdy,
    tx => RXD
    );
end structural;