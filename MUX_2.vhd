library ieee;
use ieee.std_logic_1164.all;

entity MUX_2 is
	generic(g_bits:integer:=4);
	port(control:in std_logic;
	input0:in std_logic_vector(g_bits-1 downto 0);
	input1:in std_logic_vector(g_bits-1 downto 0);
	output:out std_logic_vector(g_bits-1 downto 0));
	end MUX_2;
	
Architecture MUX of MUX_2 is
begin
	process(control,input0,input1)
	begin
		case control is
			when '0'=>
				output<=input0;
			when '1'=>
				output<=input1;
			when others=>
				NULL;
			end case;
		end process;
	end MUX;