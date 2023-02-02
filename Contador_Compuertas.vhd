library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

--Diseño del Contador de la dirección de las compuertas tipo Toffoli

entity Contador_Compuertas is
	generic(g_bits:Natural:=10);
	port(Clk,up,reset:in std_logic; Count:out std_logic_vector(g_bits-1 downto 0));
	--El tamaño del contador debe ser mayor a Log2(<Cantidad Compuertas Toffoli*2+2>)
end Contador_Compuertas;

Architecture Contador of Contador_Compuertas is
--signal cuenta: std_logic_vector(g_bits-1 downto 0);
begin
	process(Clk,reset,UP)
		variable Cuenta:integer:=0;
		begin
			if reset= '0' then
				cuenta := 0;
			else 
				if (rising_edge(Clk) and Up='1') then
					cuenta := cuenta + 1;
			end if;
		end if;
		Count<=std_logic_vector(to_unsigned(cuenta,g_bits));
		end process;
	end Contador;