----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.01.2024 19:17:26
-- Design Name: 
-- Module Name: PIPO_TB - Behavioral
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

entity PIPO_TB is
end PIPO_TB;

architecture Behavioral of PIPO_TB is
constant N : integer:= 4;
signal D,Q : std_logic_vector(3 downto 0):="0000";
signal CLK: std_logic;

begin

FLOP: ENTITY work.PIPO 
GENERIC MAP(N=>N)
PORT MAP(D=>D,Q=>Q,CLK=>CLK);


PROCESS
BEGIN
D <= "0000";  WAIT FOR 300 NS;
D <= "1111";
WAIT;
END PROCESS;

PROCESS
BEGIN
WHILE (NOW < 50e6 NS) LOOP
CLK <= '1'; WAIT FOR 50NS;
CLK <= '0'; WAIT FOR 50NS;
END LOOP;
WAIT;
END PROCESS;
end Behavioral;
