library ieee;
use ieee.std_logic_1164.all;

entity Data_Path is
	generic(Qubits:integer:=4;
				H_Gates:integer:=2);
	port(Clk:in std_logic;
			C_MUX_R1:in std_logic;
			C_MUX_R2:in std_logic_vector(1 downto 0);
			Write_R1:in std_logic;
			R_R1:in std_logic;
			Write_R2:in std_logic;
			R_R2:in std_logic;
			Write_R3: in std_logic;
			R_R3: in std_logic;
			Write_C:in std_logic;
			R_C:in std_logic;
			C_MUX0:in std_logic;
			C_MUX1:in std_logic;
			Count_Compuertas:in std_logic_vector(7 downto 0);
			Count_Estado_Superposicion:in std_logic_vector(H_Gates-1 downto 0);
			Qubits_Trabajo:in std_logic_vector(Qubits-H_GAtes-1 downto 0);
			Medicion:in std_logic_vector(Qubits-1 downto 0);
			E:out std_logic;
			Estado:out std_logic_vector(Qubits-1 downto 0);
			Fin_Compuertas:out std_logic
			--;Compuerta: out std_logic_vector(Qubits-1 downto 0)
			);
	end Data_Path;
	
Architecture DP of Data_Path is
component Unidad_Logica
	generic(g_bits_UL:integer:=Qubits);
	port(control0,control1:in std_logic;
	DATA_R1:in std_logic_vector(g_bits_UL-1 downto 0);
	DATA_R2:in std_logic_vector(g_bits_UL-1 downto 0);
	C_E:in std_logic_vector(g_bits_UL-1 downto 0);
	ANDQ,XORQ,ANDQ2:out std_logic_vector(g_bits_UL-1 downto 0));
	end component;
component Register_Q
	generic(g_bits:integer:=Qubits);
	port(Clk: in std_logic;
	W:in std_logic;
	Reset: in std_logic;
	DataIn:in std_logic_vector(g_bits-1 downto 0);
	DataOut:out std_logic_vector(g_bits-1 downto 0));
	end component;
component MUX_2
	generic(g_bits:integer:=Qubits);
	port(control:in std_logic;
	input0:in std_logic_vector(g_bits-1 downto 0);
	input1:in std_logic_vector(g_bits-1 downto 0);
	output:out std_logic_vector(g_bits-1 downto 0));
	end component;
component MUX_3
	generic(g_bits:integer:=Qubits);
	port(control:in std_logic_vector(1 downto 0);
	input0:in std_logic_vector(g_bits-1 downto 0);
	input1:in std_logic_vector(g_bits-1 downto 0);
	input2:in std_logic_vector(g_bits-1 downto 0);
	output:out std_logic_vector(g_bits-1 downto 0));
	end component;
component Mem
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		q		: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
	);
end component;
component Contador_Superposicion
	generic(g_bits:Natural:=H_Gates);
	port(Clk,up,reset:in std_logic; Count:out std_logic_vector(g_bits downto 0));
	end component;
component Contador_Compuertas
	generic(g_bits:Natural:=8);
	port(Clk,up,reset:in std_logic; Count:out std_logic_vector(g_bits-1 downto 0));
	end component;
component OR_Q2
	generic(g_bits:integer:=Qubits);
	port(
	input:in std_logic_vector(g_bits-1 downto 0);
	output:out std_logic);
	end component;
	
signal input0_MUX_R1,input1_MUX_R1:std_logic_vector(Qubits-1 downto 0);
signal control_MUX_R1:std_logic;
signal output_MUX_R1:std_logic_vector(Qubits-1 downto 0);
signal input0_MUX_R2,input1_MUX_R2,input2_MUX_R2:std_logic_vector(Qubits-1 downto 0);
signal control_MUX_R2:std_logic_vector(1 downto 0);
signal output_MUX_R2:std_logic_vector(Qubits-1 downto 0);
signal NOT_Clk:std_logic;
signal W_R1:std_logic;
signal reset_R1:std_logic;
signal DataOut_R1:std_logic_vector(Qubits-1 downto 0);
signal W_R2:std_logic;
signal reset_R2:std_logic;
signal DataOut_R2:std_logic_vector(Qubits-1 downto 0);
signal Control_AND0:std_logic;
signal Control_AND1:std_logic;
signal C: std_logic_vector(Qubits-1 downto 0);
signal ANDQ,XORQ,ANDQ2:std_logic_vector(Qubits-1 downto 0);
signal W_FF_C:std_logic;
signal reset_FF_C:std_logic;
signal ADDR:std_logic_vector(7 downto 0);
signal Out_MEM:std_logic_vector(15 downto 0);
signal input_ORQ2:std_logic_vector(Qubits-1 downto 0);
signal output_ORQ2:std_logic;
begin
	NOT_Clk<=Not(Clk);
	MUX_R1	:MUX_2 			port map (control_MUX_R1,input0_MUX_R1	,input1_MUX_R1	,output_MUX_R1);
	MUX_R2	:MUX_3 			port map (Control_MUX_R2,input0_MUX_R2	,input1_MUX_R2	,input2_MUX_R2 ,output_MUX_R2	);
	R1			:Register_Q		port map (Clk			,W_R1				,reset_R1		,output_MUX_R1	,DataOut_R1		);
	R2			:Register_Q		port map (Clk			,W_R2				,reset_R2		,output_MUX_R2	,DataOut_R2		);
	UL			:Unidad_Logica	port map (Control_AND0,Control_AND1,DataOut_R1,DataOut_R2,C,ANDQ,XORQ,ANDQ2);
	FF_C		:Register_Q		port map (Clk			,W_FF_C			,reset_FF_C		,ANDQ2			,C					);
	--FF_E		:Register_Q		port map (NOT_Clk			,W_FF_E			,reset_FF_E		,ANDQ2			,E					);
	M_COM		:Mem				port map (ADDR,Not_Clk,Out_MEM);
	Fin_Com	:OR_Q2			port map (input_ORQ2,output_ORQ2);
	R3			:Register_Q		port map (Clk			,Write_R3				,R_R3			,DataOut_R2	,Estado		);
	
	control_MUX_R1<=C_MUX_R1;
	input0_MUX_R1<=ANDQ;
	input1_MUX_R1<=Out_MEM(Qubits-1 downto 0);
	control_MUX_R2<=C_MUX_R2;
	input0_MUX_R2<=Medicion;
	input1_MUX_R2<=Count_Estado_Superposicion & Qubits_Trabajo;
	input2_MUX_R2<=XORQ;
	W_R1<=Write_R1;
	reset_R1<=R_R1;
	W_R2<=Write_R2;
	reset_R2<=R_R2;
	Control_AND0<=C_MUX0;
	Control_AND1<=C_MUX1;
	W_FF_C<=Write_C;
	reset_FF_C<=R_C;
	ADDR<=Count_Compuertas;
	input_ORQ2<=DataOut_R1;
	Fin_Compuertas<=output_ORQ2;
	E<=ANDQ2(0);
	--Compuerta<=Out_MEM;
	end DP;