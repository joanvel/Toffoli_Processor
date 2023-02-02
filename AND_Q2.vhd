library ieee;
use ieee.std_logic_1164.all;

entity AND_Q2 is
	generic(g_bits:integer:=5);
	port(
	input:in std_logic_vector(g_bits-1 downto 0);
	output:out std_logic_vector(g_bits-1 downto 0));
	end AND_Q2;
	
Architecture A of AND_Q2 is
begin
	process(input)
	variable var: std_logic;
	begin
	var:='1';
		for i in g_bits-1 downto 0 loop
			var := var and input(i);
			end loop;
		output<= (others=>var);
		end process;
	end A;