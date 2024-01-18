----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.01.2024 18:55:52
-- Design Name: 
-- Module Name: PIPO - Behavioral
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

entity PIPO is
generic(N : integer:=4);

port(
D   : in  std_logic_vector(N-1 downto 0);
clk : in std_logic;
Q   : out std_logic_vector(N-1 downto 0));
end PIPO;

architecture Behavioral of PIPO is

begin

FLOP_GEN: for I in N-1 downto 0 generate

FLOP_ELEM:  ENTITY work.Dtype
port map(D=>D(I),Q=>Q(I),CLK=>CLK);
end generate;
end Behavioral;
