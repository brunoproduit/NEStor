----------------------------------------------------------------------------------
-- Company: HEIA-FR
-- Engineer: Bruno Produit & Joachim Burket
--
-- Create Date: 17:06:54 04/06/2016
-- Design Name:
-- Module Name: player0 - Behavioral
-- Project Name:
-- Target Devices:
-- Tool versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE work.local.ALL;

ENTITY player0 IS
	PORT (
		game_clk_i             : IN STD_LOGIC;
		rst_i                  : IN STD_LOGIC;
 
		mov_p0_i               : IN STD_LOGIC_VECTOR (3 DOWNTO 0); -- 1000 = right, 0100 = down, 0010 = left, 0001 = up
 
		-- position player 1
		posX_p1_i              : IN std_logic_vector(7 DOWNTO 0);
		posY_p1_i              : IN std_logic_vector(7 DOWNTO 0);
 
		hit_i                  : IN STD_LOGIC;
 
		-- fin du jeu
		end_game_i             : IN STD_LOGIC;
 
		-- collision map
		collision_map_data0_i  : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		collision_map_addr0_o  : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
		collision_map_data1_i  : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		collision_map_addr1_o  : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
 
		posX_p0_o              : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		posY_p0_o              : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		orient_p0_o            : OUT STD_LOGIC_VECTOR (1 DOWNTO 0); -- 00 = up , 01 = left, 10 = down, 11 right
		hp_p0_o                : OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
		dead_p0_o              : OUT STD_LOGIC
	);
END player0;

ARCHITECTURE Behavioral OF player0 IS

	SIGNAL posX_p0_s            : INTEGER RANGE 0 TO (COLLI_MAP_X - 1);
	SIGNAL posY_p0_s            : INTEGER RANGE 0 TO (COLLI_MAP_Y - 1);
	SIGNAL posX_p1_s            : INTEGER RANGE 0 TO (COLLI_MAP_X - 1);
	SIGNAL posY_p1_s            : INTEGER RANGE 0 TO (COLLI_MAP_Y - 1);
	SIGNAL orient_p0_s          : STD_LOGIC_VECTOR (1 DOWNTO 0);
	SIGNAL count                : INTEGER RANGE 0 TO COUNT_MOV_PLAYER; -- compteur pour ralentir le deplacement. Constante COUNT_MOV_PLAYER
	SIGNAL posX_p1_plus_huit_s  : INTEGER RANGE 0 TO (COLLI_MAP_X - 1);
	SIGNAL posY_p1_plus_huit_s  : INTEGER RANGE 0 TO (COLLI_MAP_Y - 1);
	SIGNAL hp_p0_s              : INTEGER RANGE 0 TO 32 := HP_PLAYER0_c;
	SIGNAL map_addr_temp0_s     : INTEGER RANGE 0 TO 30000; -- permet de stocker l'adresse calcule pour la lecture dans les RAM de la map de collisions
	SIGNAL map_addr_temp1_s     : INTEGER RANGE 0 TO 30000; -- permet de stocker l'adresse calcule pour la lecture dans les RAM de la map de collisions

BEGIN
	posX_p1_s <= to_integer(unsigned(posX_p1_i));
	posY_p1_s <= to_integer(unsigned(posY_p1_i));
	----------------------------------------------
	-- Process de lecture dans la carte des
	-- collisions en fonction du deplacement
	----------------------------------------------
	read_collision_map : PROCESS(mov_p0_i, posX_p0_s, posY_p0_s, rst_i)
	BEGIN
		IF rst_i = '1' THEN
			map_addr_temp0_s <= 0;
			map_addr_temp1_s <= 0;
		ELSE
			CASE mov_p0_i IS
 
				-- deplacement en haut
				WHEN "0001" => 
 
					map_addr_temp0_s <= posX_p0_s + ((posY_p0_s - 1) * 200);
					map_addr_temp1_s <= (posX_p0_s + 8) + ((posY_p0_s - 1) * 200);
					--------------------------------------------------
 
					-- deplacement gauche
				WHEN "0010" => 
 
					map_addr_temp0_s <= (posX_p0_s - 1) + (posY_p0_s * 200);
					map_addr_temp1_s <= (posX_p0_s - 1) + ((posY_p0_s + 8) * 200);
					--------------------------------------------------
 
					-- deplacement en bas
				WHEN "0100" => 
 
					map_addr_temp0_s <= posX_p0_s + ((posY_p0_s + 9) * 200);
					map_addr_temp1_s <= (posX_p0_s + 8) + ((posY_p0_s + 9) * 200);
					--------------------------------------------------
 
					-- deplacement droite
				WHEN "1000" => 
 
					map_addr_temp0_s <= (posX_p0_s + 9) + (posY_p0_s * 200);
					map_addr_temp1_s <= (posX_p0_s + 9) + ((posY_p0_s + 8) * 200);
					--------------------------------------------------
 
				WHEN OTHERS => 
					NULL;

			END CASE;
		END IF;
	END PROCESS;
	----------------------------------------------
 
 
	-- assignation de l'adresse calcule en sortie
	collision_map_addr0_o <= std_logic_vector(to_unsigned(map_addr_temp0_s, 15));
	collision_map_addr1_o <= std_logic_vector(to_unsigned(map_addr_temp1_s, 15));
 
	----------------------------------------------
	-- Process de ralentissement du deplacement
	-- + deplacement + gestion des collisions
	----------------------------------------------
	compteur_deplacement : PROCESS (game_clk_i, rst_i)
	BEGIN
		IF (rst_i = '1') THEN
			count <= 0;
			-- position de base du joueur
			posX_p0_s <= 0;
			posY_p0_s <= 0;
		ELSIF rising_edge(game_clk_i) THEN
			IF end_game_i = '1' THEN
				posX_p0_s <= 0;
				posY_p0_s <= 0;
			ELSE
				-- compte
				IF count < COUNT_MOV_PLAYER THEN
					count <= count + 1;
					-- met a jour la position
				ELSE 
					CASE mov_p0_i IS

						-- deplacement en haut
						WHEN "0001" => 
							-- check si joueur pas tout en haut
							IF posY_p0_s > 0 THEN
								-- check si joueur en pas dessous d'un mur
								IF (collision_map_data0_i = "0" AND collision_map_data1_i = "0") THEN
									posX_p0_s <= posX_p0_s;
									posY_p0_s <= posY_p0_s - 1; 
								END IF;
							END IF;
							--------------------------------------------------
							-- deplacement a gauche
						WHEN "0010" => 
							-- check si joueur pas tout gauche
							IF posX_p0_s > 0 THEN
 
								-- check si joueur pas a droite d'un mur
								IF (collision_map_data0_i = "0" AND collision_map_data1_i = "0") THEN
									posX_p0_s <= posX_p0_s - 1;
									posY_p0_s <= posY_p0_s;
								END IF;
							END IF;
							--------------------------------------------------
 
 
							-- deplacement en bas
						WHEN "0100" => 
							-- check si joueur pas tout en bas
							IF posY_p0_s < (COLLI_MAP_Y - 8) THEN
								-- check si pas en dessus d'un joueur
								--if (((posX_p0_s < posX_p1_s) OR (posX_p0_s > posX_p1_plus_huit_s)) AND ((posX_p0_plus_huit_s < posX_p1_s) OR (posX_p0_plus_huit_s > posX_p1_plus_huit_s)))
								-- AND (posY_p0_plus_neuf_s /= posY_p1_s) then
								-- check si joueur pas en dessus d'un mur
								IF (collision_map_data0_i = "0" AND collision_map_data1_i = "0") THEN
									posX_p0_s <= posX_p0_s;
									posY_p0_s <= posY_p0_s + 1;
								END IF;
								--end if;
							END IF;
							--------------------------------------------------
 
							-- deplacement a droite
						WHEN "1000" => 
							-- check si joueur pas tout droite
							IF posX_p0_s < (COLLI_MAP_X - 8) THEN
								-- check si joueur pas a gauche d'un mur
								IF (collision_map_data0_i = "0" AND collision_map_data1_i = "0") THEN
									posX_p0_s <= posX_p0_s + 1;
									posY_p0_s <= posY_p0_s;
								END IF;
							END IF;
							--------------------------------------------------
 
 
						WHEN OTHERS => 
							NULL;

					END CASE;
 
					count <= 0;
				END IF;
			END IF;
		END IF;
	END PROCESS compteur_deplacement;
	----------------------------------------------
 
 
	----------------------------------------------
	-- process d'affectation de l'orientation
	update_orient_p : PROCESS(game_clk_i, rst_i)
	BEGIN
		IF rst_i = '1' THEN
			orient_p0_s <= "11"; -- regarde à droite de base
		ELSIF rising_edge(game_clk_i) THEN 
			IF end_game_i = '1' THEN
				orient_p0_s <= "11"; -- regarde à droite de base
			ELSE
				CASE mov_p0_i IS
					-- regarde en haut
					WHEN "0001" => 
						orient_p0_s <= "00";
						-- regarde à gauche
					WHEN "0010" => 
						orient_p0_s <= "01";
						-- regarde en bas
					WHEN "0100" => 
						orient_p0_s <= "10";
						-- regarde à droite
					WHEN "1000" => 
						orient_p0_s <= "11";
					WHEN OTHERS => 
						NULL;
				END CASE;
			END IF;
		END IF;
	END PROCESS;
	----------------------------------------------

	--------------------------------------------
	-- Process gere la vie du joueur
	--------------------------------------------
	health_points : PROCESS (game_clk_i, rst_i)
	BEGIN
		IF (rst_i = '1') THEN
			hp_p0_s <= HP_PLAYER0_c; -- max hp
		ELSIF rising_edge(game_clk_i) THEN
			IF end_game_i = '1' THEN
				hp_p0_s <= HP_PLAYER0_c;
			ELSE
				IF hit_i = '1' THEN
					hp_p0_s <= hp_p0_s - 1; --if one bullet touches the player, the player looses one portion of hp
				END IF;
			END IF;
		END IF;
	END PROCESS health_points;
	------------------------------------------
 
	-- ----------------------------------------------
	-- -- Assignation des sorties
	-- ----------------------------------------------
	posX_p0_o <= std_logic_vector(to_unsigned(posX_p0_s, 8));
	posY_p0_o <= std_logic_vector(to_unsigned(posY_p0_s, 8));
	orient_p0_o <= orient_p0_s;
	hp_p0_o <= std_logic_vector(to_unsigned(hp_p0_s, 5));
	dead_p0_o <= '1' WHEN (hp_p0_s < 1) ELSE '0';
 

END Behavioral;
