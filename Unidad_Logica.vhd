library ieee;
use ieee.std_logic_1164.all;

entity Unidad_Logica is
	generic(g_bits_UL:integer:=5);
	port(control0,control1:in std_logic;
	DATA_R1:in std_logic_vector(g_bits_UL-1 downto 0);
	DATA_R2:in std_logic_vector(g_bits_UL-1 downto 0);
	C_E:in std_logic_vector(g_bits_UL-1 downto 0);
	ANDQ,XORQ,ANDQ2:out std_logic_vector(g_bits_UL-1 downto 0));
	end Unidad_Logica;
	
Architecture UL of Unidad_Logica is
component XOR_Q
	generic(g_bits:integer:=g_bits_UL);
	port(
	input0:in std_logic_vector(g_bits-1 downto 0);
	input1:in std_logic_vector(g_bits-1 downto 0);
	output:out std_logic_vector(g_bits-1 downto 0));
	end component;
component OR_Q
	generic(g_bits:integer:=g_bits_UL);
	port(
	input0:in std_logic_vector(g_bits-1 downto 0);
	input1:in std_logic_vector(g_bits-1 downto 0);
	output:out std_logic_vector(g_bits-1 downto 0));
	end component;
component AND_Q
	generic(g_bits:integer:=g_bits_UL);
	port(
	input0:in std_logic_vector(g_bits-1 downto 0);
	input1:in std_logic_vector(g_bits-1 downto 0);
	output:out std_logic_vector(g_bits-1 downto 0));
	end component;
component AND_Q2
	generic(g_bits:integer:=g_bits_UL);
	port(
	input:in std_logic_vector(g_bits-1 downto 0);
	output:out std_logic_vector(g_bits-1 downto 0));
	end component;
component NOT_Q
	generic(g_bits:integer:=g_bits_UL);
	port(
	input:in std_logic_vector(g_bits-1 downto 0);
	output:out std_logic_vector(g_bits-1 downto 0));
	end component;
component MUX_2
	generic(g_bits:integer:=g_bits_UL);
	port(control: in std_logic;
	input0:in std_logic_vector(g_bits-1 downto 0);
	input1:in std_logic_vector(g_bits-1 downto 0);
	output:out std_logic_vector(g_bits-1 downto 0));
	end component;
signal ORQ,XO,AN,AN2,MU0,MU1,NO: std_logic_vector(g_bits_UL-1 downto 0);
begin
	X1:XOR_Q  port map (DATA_R1	    ,DATA_R2  ,XO );
	X2:OR_Q 	 port map (DATA_R1	    ,DATA_R2  ,ORQ);
	X3:AND_Q	 port map (DATA_R1	    ,MU0 ,AN );
	X4:MUX_2  port map (control0,DATA_R2  ,C_E ,MU0);
	X5:NOT_Q  port map (XO	    ,NO );
	X6:MUX_2  port map (control1,NO  ,ORQ ,MU1);
	X7:AND_Q2 port map (MU1		 ,AN2);
	ANDQ<=AN;
	XORQ<=XO;
	ANDQ2<=AN2;
	end UL;