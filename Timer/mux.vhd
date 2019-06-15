library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux is
    Port ( A : in  STD_LOGIC_VECTOR(6 downto 0);
			  B : in  STD_LOGIC_VECTOR(6 downto 0);
			  C : in  STD_LOGIC_VECTOR(6 downto 0);
			  D : in  STD_LOGIC_VECTOR(6 downto 0);
           S0 : in  STD_LOGIC;
           S1 : in  STD_LOGIC;
           Z : out  STD_LOGIC_VECTOR(6 downto 0));

end mux;

architecture Behavioral of mux is

begin
process (A,B,C,D,S0,S1) is
begin
  if (S0 ='0' and S1 = '0') then
      Z <= A;
  elsif (S0 ='1' and S1 = '0') then
      Z <= B;
  elsif (S0 ='0' and S1 = '1') then
      Z <= C;
  else
      Z <= D;
  end if;
 
end process;

end Behavioral;

