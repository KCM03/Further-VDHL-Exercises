----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.01.2024 22:54:08
-- Design Name: 
-- Module Name: Dispenser_TB - Behavioral
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

entity Dispenser_TB is
--  Port ( );
end Dispenser_TB;

architecture Behavioral of Dispenser_TB is
signal temp : integer := 90;
signal heater,pump_in,pump_out : std_logic := '0';
signal LEDs : std_logic_vector(3 downto 0) := "0000";
signal DISP,LVL,CLK :  std_logic := '1';
begin

DISPENSER: ENTITY work.dispenser
PORT MAP(temp=>temp,pump_in=>pump_in,pump_out=>pump_out,LEDs=>LEDs,DISP=>DISP,LVL=>LVL,CLK=>CLK);


PROCESS
BEGIN
Disp <= '1'; wait for 1.2e9 NS;
disp<='0';TEMP <= 0; wait for 1e9 NS;
lvl<='0'; wait for 2e9 NS;
lvl<='1'; wait for 2.5e9 NS;
temp <= 90; wait for 1e9 ns;
Disp <= '1'; wait for 1e9 NS;






WAIT;
END PROCESS;



PROCESS
BEGIN
WHILE true LOOP
CLK <= '1'; WAIT FOR 1000NS;
CLK <= '0'; WAIT FOR 1000 NS;
END LOOP;
WAIT;
END PROCESS;
end Behavioral;
