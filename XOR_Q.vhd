library ieee;
use ieee.std_logic_1164.all;

entity XOR_Q is
	generic(g_bits:integer:=4);
	port(
	input0:in std_logic_vector(g_bits-1 downto 0);
	input1:in std_logic_vector(g_bits-1 downto 0);
	output:out std_logic_vector(g_bits-1 downto 0));
	end XOR_Q;
	
Architecture X of XOR_Q is
begin
	process(input0,input1)
	begin
		for i in g_bits-1 downto 0 loop
			output(i)<=input0(i) XOR input1(i);
			end loop;
		end process;
	end X;