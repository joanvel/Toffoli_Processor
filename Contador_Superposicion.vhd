library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

--Diseño del Contador de los estados en superposición--


entity Contador_Superposicion is
	generic(g_bits:Natural:=4);
	port(Clk,up,reset:in std_logic; Count:out std_logic_vector(g_bits-1 downto 0));
end Contador_Superposicion;

Architecture Contador of Contador_Superposicion is
--signal cuenta: std_logic_vector(g_bits-1 downto 0);
begin
	process(Clk,reset)
		variable Cuenta:integer:=0;
		begin
			if reset= '0' then
				cuenta := 0;
			else 
				if (rising_edge(Clk) and Up='1') then
					cuenta := cuenta + 1;
			end if;
		end if;
		Count<=std_logic_vector(To_Unsigned(cuenta,g_bits));
		end process;
	end Contador;