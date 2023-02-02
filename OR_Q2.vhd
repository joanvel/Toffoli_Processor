library ieee;
use ieee.std_logic_1164.all;

entity OR_Q2 is
	generic(g_bits:integer:=4);
	port(
	input:in std_logic_vector(g_bits-1 downto 0);
	output:out std_logic);
	end OR_Q2;
	
Architecture O of OR_Q2 is
begin
	process(input)
	variable sign:std_logic;
	begin
		sign:='0';
		for i in g_bits-1 downto 0 loop
			sign:=sign or input(i);
		end loop;
		output<=sign;
		end process;
	end O;