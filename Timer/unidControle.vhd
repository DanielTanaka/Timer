library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity unidControle is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           pulso : in  STD_LOGIC;
           enCont : out  STD_LOGIC;
           enReg : out  STD_LOGIC);
end unidControle;

architecture Behavioral of unidControle is

	type tipo_estado is (inicial, contagem, carrega);
	signal estado   : tipo_estado; 

begin

	process (clock, reset, estado, pulso)
	begin
	
	if reset = '1' then
		estado <= inicial;
		
	elsif (clock'event and clock = '1') then
		case estado is
			when inicial =>
				if pulso = '1' then
					estado <= contagem;
				else
					estado <= inicial;
				end if;
				
			when contagem =>
				if pulso = '0' then
					estado <= carrega;
				else
					estado <= contagem;
				end if;
			
			when carrega =>
				estado <= inicial;
		end case;
	end if;
	
	end process;
	
	with estado select enCont <=
		'1' when contagem,
		'0' when others;
		
	with estado select enReg <=
		'1' when carrega,
		'0' when others;

end Behavioral;

