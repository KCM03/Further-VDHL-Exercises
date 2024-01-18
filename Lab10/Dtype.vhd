library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Dtype is
Port(
D,CLK : in std_logic;
Q     : out std_logic);
end Dtype;

architecture Behavioral of Dtype is

begin

process(clk)
begin
if rising_edge(CLK) then
Q <= D;
END IF;
end process;


end Behavioral;