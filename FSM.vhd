-- Quartus Prime VHDL Template
-- Four-State Moore State Machine

-- A Moore machine's outputs are dependent only on the current state.
-- The output is written only when the state changes.  (State
-- transitions are synchronous.)

library ieee;
use ieee.std_logic_1164.all;

entity FSM is

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
	); -- defino todas las entradas y salidas de la máquina de estados

end entity;

architecture rtl of FSM is

	-- Build an enumerated type for the state machine
	type state_type is (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10);

	-- Register to hold the current state
	signal state   : state_type;

begin

	-- Logic to advance to the next state
	process (clk, reset)
	begin
		if reset = '0' then
			state <= s0;
		elsif (rising_edge(clk)) then
			case state is
				when s0=>
					if start = '1' then
						state <= s1;
					else
						state <= s0;
					end if;
				when s1=>
					state <= s2;
				when s2=>
					state <= s3;
				when s3 =>
					state <= s4;
				when s4 =>
					state <= s5;
				when s5 =>
					state <= s6;
				when s6=>
					if Fin_Compuertas='1' then
						state <= s3;
					else
						state <= s7;
					end if;
				when s7=>
					state <= s8;
				when s8=>
					if E='1' then
						state <= s9;
					else
						state <= s10;
					end if;
				when s9=>
					if Mas_estados='0' then
						state <= s1;
					else
						state <= s0;
					end if;
				when s10=>
					if Mas_estados='0' then
						state <= s1;
					else
						state <= s0;
					end if;
			end case;
		end if;
	end process;

	-- Output depends solely on the current state
	process (state)
	begin
		case state is
			when s0 =>
				--Borrar Contadores
				R_Com<='0';
				R_Sup<='0';
				--Cargar valor de medición
				W_med<='1';
				--Borrar FF_C
				R_C<='0';
				--Borrar R3
				W_R3<='0';
				R_R3<='0';
				--Demás señales con un valor que no altere
				C_MUX_R1<='0';
				C_MUX_R2<="00";
				W_R1<='0';
				R_R1<='1';
				W_R2<='0';
				R_R2<='1';
				W_C<='0';
				C_MUX0<='0';
				C_MUX1<='0';
				Up_Com<='0';
				Up_Sup<='0';
				W_E<='0';
				Finish<='1';
			when s1 =>
				--Cargar máscara 1 en R1
				C_MUX_R1<='1';
				W_R1<='1';
				R_R1<='1';
				--Cargar Estado en R2
				C_MUX_R2<="01";
				W_R2<='1';
				R_R2<='1';
				--Demás señales con un valor que no altere
				W_C<='0';
				R_C<='1';
				C_MUX0<='0';
				C_MUX1<='0';
				Up_Com<='0';
				Up_Sup<='0';
				R_Com<='1';
				R_Sup<='1';
				W_med<='0';
				W_E<='0';
				W_R3<='0';
				R_R3<='1';
				Finish<='0';
			when s2 =>
				--Incrementar Contador de Compuertas
				Up_Com<='1';
				R_Com<='1';
				--Demás señales con un valor que no altere
				C_MUX_R1<='0';
				C_MUX_R2<="00";
				W_R1<='0';
				R_R1<='1';
				W_R2<='0';
				R_R2<='1';
				C_MUX1<='0';
				W_C<='0';
				R_C<='1';
				C_MUX0<='0';
				Up_Sup<='0';
				R_Sup<='1';
				W_med<='0';
				W_E<='0';
				W_R3<='0';
				R_R3<='1';
				Finish<='0';
			when s3 =>
				--Cargar en FF_C la condición de Control
				C_MUX1<='1';
				W_C<='1';
				R_C<='1';
				--Cargar máscara 2 en R1
				C_MUX_R1<='1';
				W_R1<='1';
				R_R1<='1';
				--Demás señales en un valor que no altere
				C_MUX_R2<="00";
				W_R2<='0';
				R_R2<='1';
				C_MUX0<='0';
				Up_Com<='0';
				Up_Sup<='0';
				R_Com<='1';
				R_Sup<='1';
				W_med<='0';
				W_E<='0';
				W_R3<='0';
				R_R3<='1';
				Finish<='0';
			when s4 =>
				--Incrementar Contador de Compuertas
				Up_Com<='1';
				R_Com<='1';
				--Cargar en R1 la ubicación del Qubit objetivo
				C_MUX0<='1';
				C_MUX_R1<='0';
				W_R1<='1';
				R_R1<='1';
				--Demás señales en un valor que no altere
				C_MUX_R2<="00";
				W_R2<='0';
				R_R2<='1';
				W_C<='0';
				R_C<='1';
				C_MUX1<='0';
				Up_Sup<='0';
				R_Sup<='1';
				W_med<='0';
				W_E<='0';
				W_R3<='0';
				R_R3<='1';
				Finish<='0';
			when s5 =>
				--Cargar en R2 el nuevo estado
				C_MUX_R2<="10";
				W_R2<='1';
				R_R2<='1';
				--Cargar máscara 1 en R1
				C_MUX_R1<='1';
				W_R1<='1';
				R_R1<='1';
				--Demás señales en un valor que no altere
				W_C<='0';
				R_C<='1';
				C_MUX0<='0';
				C_MUX1<='0';
				Up_Com<='0';
				Up_Sup<='0';
				R_Com<='1';
				R_Sup<='1';
				W_med<='0';
				W_E<='0';
				W_R3<='0';
				R_R3<='1';
				Finish<='0';
			when s6 =>
				--Incrementar Contador de Compuertas
				Up_Com<='1';
				R_Com<='1';
				--Demás señales en un valor que no altere
				C_MUX_R1<='0';
				C_MUX_R2<="00";
				W_R1<='0';
				R_R1<='1';
				W_R2<='0';
				R_R2<='1';
				W_C<='0';
				R_C<='1';
				C_MUX0<='0';
				C_MUX1<='0';
				Up_Sup<='0';
				R_Sup<='1';
				W_med<='0';
				W_E<='0';
				W_R3<='0';
				R_R3<='1';
				Finish<='0';
			when s7 =>
				--Cargar en R1 la máscara de medición
				C_MUX_R1<='1';
				W_R1<='1';
				R_R1<='1';
				--Cargar en R3 el estado actual
				W_R3<='1';
				R_R3<='1';
				--Demás señales en un valor que no altere
				C_MUX_R2<="00";
				W_R2<='0';
				R_R2<='1';
				W_C<='0';
				R_C<='1';
				C_MUX0<='0';
				C_MUX1<='0';
				Up_Com<='0';
				Up_Sup<='0';
				R_Com<='1';
				R_Sup<='1';
				W_med<='0';
				W_E<='0';
				Finish<='0';
			when s8 =>
				--Cargar en R1 el estado de los Qubits que serán medidos
				C_MUX0<='0';
				C_MUX_R1<='0';
				W_R1<='1';
				R_R1<='1';
				--Cargar en R2 el valor de la medición
				C_MUX_R2<="00";
				W_R2<='1';
				R_R2<='1';
				--Borrar Contador de Compuertas
				Up_Com<='0';
				R_Com<='0';
				--Demás señales en valores que no altere
				W_C<='0';
				R_C<='1';
				C_MUX1<='0';
				Up_Sup<='0';
				R_Sup<='1';
				W_med<='0';
				W_E<='0';
				W_R3<='0';
				R_R3<='1';
				Finish<='0';
			when s9 =>
				--Almacenar estado
				W_E<='1';
				--Aumentar contador de superposicion
				Up_Sup<='1';
				R_Sup<='1';
				--Demás señales en un valor que no altere
				C_MUX_R1<='0';
				C_MUX_R2<="00";
				W_R1<='0';
				R_R1<='1';
				W_R2<='0';
				R_R2<='1';
				W_C<='0';
				R_C<='1';
				C_MUX0<='0';
				C_MUX1<='0';
				Up_Com<='0';
				R_Com<='1';
				W_med<='0';
				W_R3<='0';
				R_R3<='1';
				Finish<='0';
			when s10 =>
				--Aumentar contador de superposicion
				Up_Sup<='1';
				R_Sup<='1';
				--Demás señales en un valor que no altere
				W_E<='0';
				C_MUX_R1<='0';
				C_MUX_R2<="00";
				W_R1<='0';
				R_R1<='1';
				W_R2<='0';
				R_R2<='1';
				W_C<='0';
				R_C<='1';
				C_MUX0<='0';
				C_MUX1<='0';
				Up_Com<='0';
				R_Com<='1';
				W_med<='0';
				W_R3<='0';
				R_R3<='1';
				Finish<='0';
		end case;
	end process;

end rtl;
