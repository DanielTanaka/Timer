library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fd is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           enableCont : in  STD_LOGIC;
			  final_count : out STD_LOGIC;
           saida : out  STD_LOGIC_VECTOR (6 downto 0);
			  anodes : out  STD_LOGIC_VECTOR (3 downto 0));
end fd;

architecture arquitetura of fd is

	component divclock is
    port (
		  clock     : in  std_logic;
		  clear		: in  std_logic;
		  enable		: in  std_logic;
        clock_div : out std_logic
    );
	end component;
	
	component hex7seg is
	port (hex      : in  std_logic_vector(3 downto 0);
         display  : out std_logic_vector(6 downto 0)
          );
	end component;
	
	component contador is
    Port ( clock : in  STD_LOGIC;
           clear : in  STD_LOGIC;
           enable : in  STD_LOGIC;
			  Q       : out std_logic_vector(3 downto 0);		
			  RCO     : out std_logic									
			);
	end component;
	
	component contadorcinco is
    Port ( clock : in  STD_LOGIC;
           clear : in  STD_LOGIC;
           enable : in  STD_LOGIC;
			  Q       : out std_logic_vector(3 downto 0);		
			  RCO     : out std_logic									
			);
	end component;
	
	component display is
		 port(
			  clock     : in  std_logic;
			  entrada3  : in  std_logic_vector(6 downto 0);
			  entrada2  : in  std_logic_vector(6 downto 0);
			  entrada1  : in  std_logic_vector(6 downto 0);
			  entrada0  : in  std_logic_vector(6 downto 0);
			  sevenseg  : out std_logic_vector(6 downto 0);
			  anodes  	: out std_logic_vector(3 downto 0));
	end component;

	signal clockdiv : std_logic;
	signal expressionA : std_logic;
	signal expressionB : std_logic;
	signal expressionC : std_logic;
	signal rcoA : std_logic;
	signal rcoB : std_logic;
	signal rcoC : std_logic;
	signal rcoD : std_logic;
	signal cont1 : std_logic_vector(3 downto 0);
	signal cont2 : std_logic_vector(3 downto 0);
	signal cont3 : std_logic_vector(3 downto 0);
	signal cont4 : std_logic_vector(3 downto 0);
	signal saida1 : std_logic_vector(6 downto 0);
	signal saida2 : std_logic_vector(6 downto 0);
	signal saida3 : std_logic_vector(6 downto 0);
	signal saida4 : std_logic_vector(6 downto 0);
	
begin
	div: divclock port map(clock, reset, enableCont, clockdiv);
	
	contadA : contador port map(clockdiv, reset, enableCont, cont1, rcoA);
	expressionA <= enableCont and rcoA;
	
	contadB : contador port map(clockdiv, reset, expressionA, cont2, rcoB);
	expressionB <= enableCont and rcoA and rcoB;
	 
	contadC : contador port map(clockdiv, reset, expressionB, cont3, rcoC);
	expressionC <= enableCont and rcoA and rcoB and rcoC;
	
	contadD : contadorcinco port map(clockdiv, reset, expressionC, cont4, rcoD);
	
	hexa1 : hex7seg port map(cont1, saida1);
	hexa2 : hex7seg port map(cont2, saida2);
	hexa3 : hex7seg port map(cont3, saida3);
	hexa4 : hex7seg port map(cont4, saida4);
	
	final_count <= rcoA and rcoB and rcoC and rcoD;
	mux : display port map(clock, saida1, saida2, saida3, saida4, saida, anodes);
end arquitetura;

