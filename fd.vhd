library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fd is
    Port ( clock : in  STD_LOGIC;
           pulso : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           enableCont : in  STD_LOGIC;
           enableReg : in  STD_LOGIC;
           saida : out  STD_LOGIC_VECTOR (6 downto 0));
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
	
	component registrador is
		 Port ( clock : in  STD_LOGIC;
				  enable : in  STD_LOGIC;
				  clear : in  STD_LOGIC;
				  D : in  STD_LOGIC_VECTOR (3 downto 0);
				  Q : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;	

	signal clockdiv : std_logic;
	signal rco : std_logic;
	signal cont : std_logic_vector(3 downto 0);
	signal sair : std_logic_vector(3 downto 0);

begin

	div: divclock port map(clock, reset, enableCont, clockdiv);
	contad : contador port map(clockdiv, reset, enableCont, cont, rco);
	registra : registrador port map(clock, enableReg, reset, cont, sair);
	hexa : hex7seg port map(sair, saida);

end arquitetura;

