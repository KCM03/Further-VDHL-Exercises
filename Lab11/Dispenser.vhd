----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.01.2024 16:40:13
-- Design Name: 
-- Module Name: Dispenser - Behavioral
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

entity Dispenser is
generic(
frq :integer := 500_000);
Port(
temp : in  integer;
heater,pump_in,pump_out :out std_logic;
LEDs : out std_logic_vector(3 downto 0);
DISP,LVL,CLK : IN std_logic);
end Dispenser;

architecture Behavioral of Dispenser is
type state is (
ready,
dispense,
reset,
fill,
warming0,
warming1
 );
 
 signal position : state;
 signal FSM_CLK  : std_logic :='0';

begin
process(clk)
variable count : integer range 0 to frq := 0; 
begin
if rising_edge(clk) then
if (count>= frq) then
fsm_clk <= not fsm_clk;
count := 0;
else 
count := count + 1;
end if;
end if;
end process;

process(fsm_clk)

begin
if(rising_edge(fsm_clk)) then

case (position) is
--------------------------------
when ready =>

LEDs <= "0010";
heater <= '0';
pump_in <= '0';
pump_out <= '0';
if (disp = '1' and temp >=80) then
position <= dispense;
end if;
-----------------------------------

when dispense =>

LEDs <= "0001";
heater <= '0';
pump_in <= '0';
pump_out <= '1';
if lvl = '0' then
position <= fill;
elsif (disp = '0') then
position <= warming1;
end if;
-----------------------------------
when reset =>

LEDs <= "1111";
heater <= '0';
pump_in <= '0';
pump_out <= '0';
if (lvl = '0') then
position <= fill;
else 
position <= warming1;
end if;
-----------------------------------
when fill =>
LEDs <= "1000";
heater <= '0';
pump_in <= '1';
pump_out <= '0';
if (lvl = '1') then
position <= warming1;
end if;
------------------------------------
when warming0 =>
LEDs <= "0000";
heater <= '1';
pump_in <= '0';
pump_out <= '0';
if (temp <85) then
position <= warming1;
else
position <= ready;
end if;

-----------------------------------
when warming1 =>
LEDs <= "0100";
heater <= '1';
pump_in <= '0';
pump_out <= '0';
if (temp >= 85) then
position <= ready;
else
position <= warming0;
end if;
-----------------------------------
end case;
end if;
end process;
end Behavioral;


