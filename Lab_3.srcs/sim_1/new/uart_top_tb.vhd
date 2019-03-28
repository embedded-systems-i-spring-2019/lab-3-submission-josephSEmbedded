----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/28/2019 10:51:55 AM
-- Design Name: 
-- Module Name: uart_top_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uart_top_tb is
end uart_top_tb;

architecture tb of uart_top_tb is

component uart_top is 
port( TXD,clk : in std_logic;
      btn : in std_logic_vector(1 downto 0);
      RXD : out std_logic;
      CTS,RTS : out std_logic
      );
end component;
      
signal clk : std_logic := '0';
signal btn : std_logic_vector(1 downto 0) := (others => '0');
signal RXD : std_logic;
signal TXD : std_logic;

begin

uart : uart_top port map(
clk => clk,
TXD => TXD,
btn => btn,
RXD => RXD); 

-- clock process @125 MHz
process begin
clk <= '0';
wait for 4 ns;
clk <= '1';
wait for 4 ns;
end process ;

process begin
btn(1) <= '1';
wait for 200 ms;
btn(1) <= '0';
end process;



end tb;
