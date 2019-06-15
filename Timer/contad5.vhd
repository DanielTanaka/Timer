library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity contadorcinco is
    Port ( clock : in  STD_LOGIC;
           clear : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           Q : out  STD_LOGIC_VECTOR (3 downto 0);
           RCO : out  STD_LOGIC);
end contadorcinco;

architecture Behavioral of contadorcinco is -- contador5 inicial
	SIGNAL R : unsigned(3 downto 0);
begin
	process(clock, clear, enable, R)
	begin
		if clear = '1' then
			R <= "0101"; 
		elsif clock'event and clock = '1' then
			if enable = '1' then
				if R = 0 then
					R <= "0101";
				else
					R <= R - 1;
				end if;
			end if;
		end if;
	end process;
	
	with R select RCO <= 
		'1' when "0000",
		'0' when others;
	Q <= std_logic_vector(R);
end Behavioral;
