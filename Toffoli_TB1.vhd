library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity Toffoli_TB is
generic(g_Qubits:integer:=4;g_H_Gates:integer:=2);
end Toffoli_TB;

architecture TB of Toffoli_TB is

	component Procesador_Toffoli
		generic(g_Qubits:integer:=g_Qubits;g_H_Gates:integer:=g_H_Gates);
		port
		(Clk				:in std_logic
		;Qubits_Trabajo:in std_logic_vector(g_Qubits-g_H_Gates-1 downto 0)
		;medicion		:in std_logic_vector(g_Qubits-1 downto 0)
		;start			:in std_logic
		;reset			:in std_logic
		;o_full			:out std_logic
		;i_rd_en			:in std_logic
		;o_empty			:out std_logic
		;state			:out std_logic_vector(g_Qubits-1 downto 0)
		;Finish			:out std_logic
		);
	end component;
		signal Clk				:std_logic;
		signal Qubits_Trabajo:std_logic_vector(g_Qubits-g_H_Gates-1 downto 0);
		signal medicion		:std_logic_vector(g_Qubits-1 downto 0);
		signal start			:std_logic;
		signal reset			:std_logic;
		signal o_full			:std_logic;
		signal i_rd_en			:std_logic;
		signal o_empty			:std_logic;
		signal state			:std_logic_vector(g_Qubits-1 downto 0);
		signal finish			:std_logic;
	constant Time_Period: time:= 5 ns;
	begin
	--Señales constantes:Qubits de trabajo, medición
		Qubits_Trabajo<=std_logic_vector(to_unsigned(0,g_Qubits-g_H_Gates));
		medicion<=std_logic_vector(to_unsigned(0,g_Qubits));
	--Señal de reloj:
		process
			begin
				Clk<='0';
				wait for Time_period;
				Clk<='1';
				wait for Time_Period;
		end process;
	--señal start
		process
			begin
				start<='0';
				wait for Time_Period;
				start<='1';
				wait for Time_period;
				start<='0';
				wait;
		end process;
	--Señal reset;
		process
			begin
				reset<='0';
				wait for Time_period;
				reset<='1';
				wait;
		end process;
	--Señal i_rd_en
		process
			begin
				if o_empty = '0' and finish = '1' then
					i_rd_en<='1';
					wait for 2*Time_period;
				else
					i_rd_en<='0';
					wait for 2*Time_period;
				end if;
		end process;
		A: Procesador_Toffoli port map (Clk,Qubits_Trabajo,medicion,start,reset,o_full,i_rd_en,o_empty,state,finish);
	end TB;
