library ieee;
use ieee.std_logic_1164.all;

entity OR_Q is
	generic(g_bits:integer:=4);
	port(
	input0:in std_logic_vector(g_bits-1 downto 0);
	input1:in std_logic_vector(g_bits-1 downto 0);
	output:out std_logic_vector(g_bits-1 downto 0));
	end OR_Q;
	
Architecture O of OR_Q is
begin
	process(input0,input1)
	begin
		for i in g_bits-1 downto 0 loop
			output(i)<=input0(i) or input1(i);
			end loop;
		end process;
	end O;