library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity registrador is
    Port ( clock : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           clear : in  STD_LOGIC;
           D : in  STD_LOGIC_VECTOR (3 downto 0);
           Q : out  STD_LOGIC_VECTOR (3 downto 0));
end registrador;

architecture Behavioral of registrador is

begin

	process(clock, clear, enable)
	begin

		if clear = '1' then
			Q(3) <= '0';
			Q(2) <= '0';
			Q(1) <= '0';
			Q(0) <= '0';
			
		elsif clock'event and clock = '1' then
			if enable = '1' then
				Q(3) <= D(3);
				Q(2) <= D(2);
				Q(1) <= D(1);
				Q(0) <= D(0);
			end if;
		end if;	
	end process;


end Behavioral;

