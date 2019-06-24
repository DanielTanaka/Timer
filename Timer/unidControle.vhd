library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity unidControle is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           start : in  STD_LOGIC;
			  final_cont : in STD_LOGIC;
           enCont : out  STD_LOGIC);
end unidControle;

architecture Behavioral of unidControle is

	type tipo_estado is (inicial, contagem, pause, final); 
	signal estado   : tipo_estado; 

begin

	process (clock, reset, estado, start, final_cont)
	begin
	
	if reset = '1' then
		estado <= inicial;
		
	elsif (clock'event and clock = '1') then
		case estado is
			when inicial =>
				if start = '1' then
					estado <= contagem;
				end if;
				
			when contagem =>
				if start = '1' then
					estado <= pause;
				else
					estado <= contagem;
				end if;
				if final_cont = '1' then
					estado <= final;
				end if;
				
			when pause =>
				if start = '0' then
					estado <= pause;
				else
					estado <= contagem;
				end if;
				
			when final =>
				estado <= final;
		end case;
	end if;
	
	end process;
	
	with estado select enCont <=
		'1' when contagem,
		'0' when others;
		
end Behavioral;

