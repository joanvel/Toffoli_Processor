library ieee;
use ieee.std_logic_1164.all;

entity Register_Q is
	generic(g_bits:integer:=4);
	port(Clk: in std_logic;
	W:in std_logic;
	Reset: in std_logic;
	DataIn:in std_logic_vector(g_bits-1 downto 0);
	DataOut:out std_logic_vector(g_bits-1 downto 0));
	end Register_Q;
	
Architecture REG of Register_Q is
begin
	process(Clk,Reset)
	begin
	if reset='0' then
		DataOut<= (others=>'0');
	else
		if rising_edge(Clk) and W='1' then
			DataOut<=DataIn;
		else
			NULL;
		end if;
	end if;
		end process;
	end REG;