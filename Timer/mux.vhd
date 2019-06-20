library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity display is
    port(
        clock     : in  std_logic;
		  entrada3  : in  std_logic_vector(6 downto 0);
		  entrada2  : in  std_logic_vector(6 downto 0);
		  entrada1  : in  std_logic_vector(6 downto 0);
		  entrada0  : in  std_logic_vector(6 downto 0);
        sevenseg  : out std_logic_vector(6 downto 0);
        anodes  	: out std_logic_vector(3 downto 0));
end display;

architecture Behavioral of display is
    signal prescaler: std_logic_vector(16 downto 0) := "11000011010100000";
    signal prescaler_counter: std_logic_vector(16 downto 0);
    signal counter: std_logic_vector(1 downto 0);
    signal r_anodes: std_logic_vector(3 downto 0);
begin

	-- Redutor de Clock
	countClock: process(clock, counter)
   begin
		if clock'event and clock = '1' then
			prescaler_counter <= prescaler_counter + 1;
				
			if(prescaler_counter = prescaler) then
				counter <= counter + 1;
				prescaler_counter <= (others => '0');
			end if;
		end if;
	end process;

    -- Multiplexacao dos Displays
	multiplex: process(counter)
   begin
		-- Selecao dos anodos
			case counter(1 downto 0) is
				when "00" => r_anodes <= "1110"; -- AN 0
				when "01" => r_anodes <= "1101"; -- AN 1
				when "10" => r_anodes <= "1011"; -- AN 2
            when "11" => r_anodes <= "0111"; -- AN 3

            when others => r_anodes <= "1111"; -- nothing
			end case;

		-- Atribui as entradas aos displays
			case r_anodes is
				when "1110" => 
					sevenseg <= entrada0;

				when "1101" => 
					sevenseg <= entrada1;

				when "1011" => 
					sevenseg <= entrada2;

            when "0111" => 
					sevenseg <= entrada3;

            when others => 
					sevenseg <= "1000000"; -- 0
        end case;

	end process;

	anodes <= r_anodes;
end Behavioral;