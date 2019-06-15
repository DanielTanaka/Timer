library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;	

entity contador92 is
    Port ( clock : in  STD_LOGIC;
           clear : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           RCOin : in  STD_LOGIC;
           RCOout : out  STD_LOGIC;
           Q : out  STD_LOGIC_VECTOR (3 downto 0));
end contador92;

architecture Behavioral of contador92 is -- segundo contador9
	SIGNAL R : unsigned(3 downto 0);
begin
	process(clock, clear, enable, R)
	begin
		if clear = '1' then
			R <= (others => '9'); -- INICIA COM 9 CABASSO
			RCOout <= '0'; 
		elsif clock'event and clock = '1' then
			if enable = '1' then
				R <= R - 1;
				
				if R = 0 then
					RCOout <= '1';
					R <= 9;
				 
				
				else
					RCO <= '0';
					
				end if;	
			end if;
		end if;
	end process;
	Q <= std_logic_vector(R);
end Behavioral;