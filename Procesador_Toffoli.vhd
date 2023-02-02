library ieee;
use ieee.std_logic_1164.all;

entity Procesador_Toffoli is
	generic(g_Qubits:integer:=4;g_H_Gates:integer:=2);
	port(
	clk:in std_logic;
	Qubits_Trabajo:in std_logic_vector(g_Qubits-g_H_Gates-1 downto 0);
	medicion:in std_logic_vector(g_Qubits-1 downto 0);
	start:in std_logic;
	reset:in std_logic;
	o_full:out std_logic;
	i_rd_en:in std_logic;
	o_empty:out std_logic;
	state:out std_logic_vector(g_Qubits-1 downto 0);
	Finish:out std_logic
	);
end Procesador_Toffoli;


Architecture rtl of Procesador_Toffoli is

	component Data_Path
		generic(Qubits:integer:=g_Qubits;
				H_Gates:integer:=g_H_Gates);
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
			);
	end component;
	
	component FSM
		port(
			Clk:in std_logic;
			reset:in std_logic;
			start:in std_logic;
			Fin_Compuertas:in std_logic;
			E:in std_logic;
			Mas_estados:in std_logic;
			C_MUX_R1:out std_logic;
			C_MUX_R2:out std_logic_vector(1 downto 0);
			W_R1:out std_logic;
			R_R1:out std_logic;
			W_R2:out std_logic;
			R_R2:out std_logic;
			W_C:out std_logic;
			R_C:out std_logic;
			C_MUX0:out std_logic;
			C_MUX1:out std_logic;
			Up_Com:out std_logic;
			Up_Sup:out std_logic;
			R_Com:out std_logic;
			R_Sup:out std_logic;
			W_med:out std_logic;
			W_E:out std_logic;
			W_R3:out std_logic;
			R_R3:out std_logic;
			Finish:out std_logic
		);
	end component;
	
	component Contador_Superposicion
		generic(g_bits:Natural:=g_H_Gates);
		port(Clk,up,reset:in std_logic; Count:out std_logic_vector(g_bits-1 downto 0));
	end component;
	
	component Contador_Compuertas
		generic(g_bits:Natural:=8);
		port(Clk,up,reset:in std_logic; Count:out std_logic_vector(g_bits-1 downto 0));
	end component;
	component Memory_FIFO
		generic(
			g_width : Natural :=g_Qubits;g_depth : integer :=32
			);
		port (
			i_rst_sync 	: in std_logic;
			i_clk			: in std_logic;
	
			-- FIFO Write Interface
	
			i_wr_en		: in 	std_logic;
			i_wr_data	: in 	std_logic_vector(g_width-1 downto 0);
			o_full		: out	std_logic;
	
			-- FIFO Read Interface
	
			i_rd_en		: in 	std_logic;
			o_rd_data	: out	std_logic_vector(g_width-1 downto 0);
			o_empty		: out std_logic
			);
	end component;
	component OR_Q2
		generic(g_bits:integer:=g_H_Gates);
		port(
				input:in std_logic_vector(g_bits-1 downto 0)
				;output:out std_logic);
		end component;
	
	signal Not_Clk:std_logic;
	signal C_MUX_R1:std_logic;
	signal C_MUX_R2:std_logic_vector(1 downto 0);
	signal W_R1:std_logic;
	signal R_R1:std_logic;
	signal W_R2:std_logic;
	signal R_R2:std_logic;
	signal W_R3:std_logic;
	signal R_R3:std_logic;
	signal W_C:std_logic;
	signal R_C:std_logic;
	signal C_MUX0:std_logic;
	signal C_MUX1:std_logic;
	signal Count_Compuertas:std_logic_vector(7 downto 0);
	signal Count_Estado_Superposicion:std_logic_vector(g_H_Gates-1 downto 0);
	signal E:std_logic;
	signal Estado:std_logic_vector(g_Qubits-1 downto 0);
	signal Fin_Compuertas:std_logic;
	signal Up_Com:std_logic;
	signal Up_Sup:std_logic;
	signal R_Com:std_logic;
	signal R_Sup:std_logic;
	signal W_med:std_logic;
	signal W_E:std_logic;
	signal m_states:std_logic;
	signal Not_m_states:std_logic;
	begin
	Not_m_states<=not(m_states);
	Not_Clk<=Not(Clk);
	DP:	Data_Path					port map (Not_Clk							,C_MUX_R1		,C_MUX_R2,W_R1,R_R1
														,W_R2								,R_R2				,W_R3		,R_R3,W_C
														,R_C								,C_MUX0			,C_MUX1	,Count_Compuertas
														,Count_Estado_Superposicion(g_H_Gates-1 downto 0),Qubits_Trabajo,medicion,E
														,Estado							,Fin_Compuertas);
										
										
	FM:	FSM							port map (Clk,reset	,start	,Fin_Compuertas,E			,Not_m_states
														,C_MUX_R1	,C_MUX_R2,W_R1				,R_R1		,W_R2
														,R_R2			,W_C		,R_C				,C_MUX0	,C_MUX1
														,Up_Com		,Up_Sup	,R_Com			,R_Sup	,W_med
														,W_E			,W_R3		,R_R3,Finish);
														
													
	Com:	Contador_Compuertas		port map	(Not_Clk		,Up_Com	,R_Com			,Count_Compuertas);
	
	
	Sup:	Contador_Superposicion	port map	(Not_Clk		,Up_Sup	,R_Sup			,Count_Estado_Superposicion);
	
	
	FIFO:	Memory_FIFO					port map	(reset,Not_Clk,W_E,Estado,o_full,i_rd_en,state,o_empty);
	m_s:	OR_Q2						port map (Count_Estado_Superposicion,m_states);
	--UP_COMPU<=UP_COM;
	--Count<=Count_Compuertas;
	
end rtl;