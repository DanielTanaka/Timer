library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity divclock is
    port (
		  clock     : in  std_logic;
		  clear		: in  std_logic;
		  enable		: in  std_logic;
        clock_div : out std_logic
    );
end divclock;

architecture exemplo of divclock is
	signal IQ	: unsigned(24 downto 0); --Para fazer a soma
	signal pivo	: std_logic;
begin
	
	process (clock, clear, enable, IQ, pivo)
	begin
	
	if clear = '1' then
		IQ   <= (others => '0'); --Preenche o array IQ de 25 posiçoes com zeros, se o Clear == 1
		pivo <= '0';	

	elsif clock'event and clock = '1' then --Verif. se o clock está em borda de subida
		if enable = '1' then
			IQ <= IQ + 1; --Incremento do IQ. Contador
			
			if IQ = 25000000 then --Contagem demora 0.5 seg. Cada onda dura 0.5s devido freq da placa de 50MHz
				pivo <= not(pivo); --Resetar o PIVO
				IQ   <= (others => '0'); --Resetar o array com zeros
			end if;
		end if;
	end if;
	 
	clock_div <= pivo; --Onda quadrada de período 1 (um) Hz
	end process;
	
end exemplo;