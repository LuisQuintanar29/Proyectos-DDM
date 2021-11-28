--------------------------------------------------------------------------------
--
--   FileName:         hw_image_generator.vhd
--   Dependencies:     none
--   Design Software:  Quartus II 64-bit Version 12.1 Build 177 SJ Full Version
--
--   HDL CODE IS PROVIDED "AS IS."  DIGI-KEY EXPRESSLY DISCLAIMS ANY
--   WARRANTY OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING BUT NOT
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
--   PARTICULAR PURPOSE, OR NON-INFRINGEMENT. IN NO EVENT SHALL DIGI-KEY
--   BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR CONSEQUENTIAL
--   DAMAGES, LOST PROFITS OR LOST DATA, HARM TO YOUR EQUIPMENT, COST OF
--   PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS
--   BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF),
--   ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER SIMILAR COSTS.
--
--   Version History
--   Version 1.0 05/10/2013 Scott Larson
--     Initial Public Release
--    
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY hw_image_generator IS
  GENERIC(
   pixels_y :  INTEGER := 478;   --row that first color will persist until
   pixels_x :  INTEGER := 600);  --column that first color will persist until
  PORT(
    disp_ena :  IN   STD_LOGIC;  --display enable ('1' = display time, '0' = blanking time)
    row      :  IN   INTEGER;    --row pixel coordinate
    column   :  IN   INTEGER;    --column pixel coordinate
    red      :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  --red magnitude output to DAC
    green    :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  --green magnitude output to DAC
    blue     :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0') ;
	 dipsw: in std_logic_vector(1 downto 0);
	 shoot: in std_logic;
	 reloj: in std_logic;
	 shoot_clock: in std_logic);
    
	 END hw_image_generator;

ARCHITECTURE behavior OF hw_image_generator IS
	signal x: integer range 11 to 630:=430;
	signal y: integer range 11 to 630:=320;
	signal shootX: integer range 11 to 630;
	signal shootY: integer range 11 to 630;

BEGIN
  PROCESS(disp_ena, row, column)
   
 BEGIN

 IF(disp_ena = '1') THEN        --display time
      if ((row > 5 and row <10) and (column>5 and column<635)) THEN -- superior
			   red <= (OTHERS => '1');
				green<=(OTHERS => '1');
				blue<=(OTHERS => '1');
		elsif ((row > 5 and row <475) and (column>5 and column<10)) THEN -- lateral izq
			   red <= (OTHERS => '1');
				green<=(OTHERS => '1');
				blue<=(OTHERS => '1');
		 elsif ((row > 5 and row <475) and (column>630 and column<635)) THEN -- lateral der
			   red <= (OTHERS => '1');
				green<=(OTHERS => '1');
				blue<=(OTHERS => '1');
		elsif ((row > 470 and row <475) and (column>5 and column<635)) THEN -- inferior
			   red <= (OTHERS => '1');
				green<=(OTHERS => '1');
				blue<=(OTHERS => '1');
				
				
		-- Rectangulo simila carro	

		elsif (row > x+0 and row < x+20) and (column >y and column < y+15) then  -- rectangulo pequeño 20lx15a
			red <= (others => '1');
		elsif (row > x+20 and row < x+40) and (column >y-5 and column < y+20) then -- rectangulo grande 20lx25a
			red <= (others => '1');
			
		elsif (row > shootX and row < shootX+5) and (column >shootY and column < shootY+5) then 
			red <= (others => '1');
			green <= (others => '1');
			blue <= (others => '1');
							
		else		
				red <= (OTHERS => '0');  --es el fondo
				green	<= (OTHERS => '0');
				blue <= (OTHERS => '0');
		end if;
		
		FOR I in 0 to 12 LOOP
			FOR J in 0 to 3 LOOP
				if ((row > 60+40*J and row < 80+40*J) and (column >60+40*i and column <80+40*i)) then
					red <= (OTHERS => '0');
					green<=(OTHERS => '1');
					blue<=(OTHERS => '0');
				end if;
			END LOOP;
		END LOOP;
END IF;  --del enable
  
  END PROCESS;

  
  -- Movimiento carro -480x640
  PROCESS(reloj,dipsw)
  constant naveW: integer:=10;
	begin 
		if(reloj'event and reloj ='1') then 
			if (dipsw(1) = '1' and dipsw(0)='1') then   -- der
				if(y>5+naveW and y < 630-(naveW+10) ) then
					x <= x;
					y <= y+1;
				else
					y <= 630-(naveW+10)-1;
				end if;
			elsif (dipsw(1) = '1' and dipsw(0)='0') then -- izq
				if(y>5+naveW and y < 630-(naveW+10) ) then
					x <= x;
					y <= y-1;
				else
					y <= 5+naveW+1;
				end if;
			end if;
		end if;
	end process;
	
	
	PROCESS(shoot_clock,shoot)
  
	begin 
		if(shoot_clock'event and shoot_clock ='1') then 
			if (shoot = '1') then   
				shootY <= y+5;
				shootX <= 415;
			else
				shootX <= shootX - 1;
				if(shootX < 10) then
					shootY <= y+5;
					shootX <= 415;
				end if;
			end if;
		end if;
	end process;
			
END behavior;