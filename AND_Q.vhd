library ieee;
use ieee.std_logic_1164.all;

entity AND_Q is
	generic(g_bits:integer:=4);
	port(
	input0:in std_logic_vector(g_bits-1 downto 0);
	input1:in std_logic_vector(g_bits-1 downto 0);
	output:out std_logic_vector(g_bits-1 downto 0));
	end AND_Q;
	
Architecture A of AND_Q is
begin
	process(input0,input1)
	begin
		for i in g_bits-1 downto 0 loop
			output(i)<=input0(i) and input1(i);
			end loop;
		end process;
	end A;