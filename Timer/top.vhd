library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           pulso : in  STD_LOGIC;
           saida : out  STD_LOGIC_VECTOR (6 downto 0));
end top;

architecture Behavioral of top is

	component fd is
		 Port ( clock : in  STD_LOGIC;
				  pulso : in  STD_LOGIC;
				  reset : in  STD_LOGIC;
				  enableCont : in  STD_LOGIC;
				  enableReg : in  STD_LOGIC;
				  saida : out  STD_LOGIC_VECTOR (6 downto 0));
	end component;
	
	component unidControle is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           pulso : in  STD_LOGIC;
           enCont : out  STD_LOGIC;
           enReg : out  STD_LOGIC);
	end component;

	signal enabCont : std_logic;
	signal enabReg : std_logic;

begin

	unidContr : unidControle port map(clock, reset, pulso, enabCont, enabReg);
	fluxoDados: fd port map(clock, pulso, reset, enabCont, enabReg, saida);

end Behavioral;

