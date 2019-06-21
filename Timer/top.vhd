library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           start : in  STD_LOGIC;
           saida : out  STD_LOGIC_VECTOR (6 downto 0);
			  anodes : out  STD_LOGIC_VECTOR (3 downto 0));
end top;

architecture Behavioral of top is

	component fd is
	  Port (clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           enableCont : in  STD_LOGIC;
			  final_count : out STD_LOGIC;
           saida : out  STD_LOGIC_VECTOR (6 downto 0);
			  anodes : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;
	
	component unidControle is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           start : in  STD_LOGIC;
			  final_cont : in STD_LOGIC;
           enCont : out  STD_LOGIC);
	end component;

	signal enabCont : std_logic;
	signal final : std_logic;

begin

	unidContr : unidControle port map(clock, reset, start, final, enabCont);
	fluxoDados: fd port map(clock, reset, enabCont, final, saida, anodes);

end Behavioral;

