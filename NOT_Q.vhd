library ieee;
use ieee.std_logic_1164.all;

entity NOT_Q is
	generic(g_bits:integer:=4);
	port(
	input:in std_logic_vector(g_bits-1 downto 0);
	output:out std_logic_vector(g_bits-1 downto 0));
	end NOT_Q;
	
Architecture N of NOT_Q is
begin
	process(input)
	begin
		for i in g_bits-1 downto 0 loop
			output(i)<=not(input(i));
			end loop;
		end process;
	end N;