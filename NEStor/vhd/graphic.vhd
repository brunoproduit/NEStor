----------------------------------------------------------------------------------
-- Company: HEIA-FR
-- Engineer: Joachim Burcket, Bruno Produit
--
-- Create Date: 09:45:34 02/26/2016
-- Design Name:
-- Module Name: graphic - Behavioral
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
ENTITY graphic IS
	PORT (
		game_clk_i                  : IN STD_LOGIC;
		rst_i                       : IN STD_LOGIC;

		--VGA
		hcount_i                    : IN STD_LOGIC_VECTOR (10 DOWNTO 0); -- de 0 a 1056 coordonees du pixel horizontale
		vcount_i                    : IN STD_LOGIC_VECTOR (9 DOWNTO 0); -- de 0 a 628 coordonees du pixel verticales;
		blank_i                     : IN STD_LOGIC;
		-- Player 0
		posX_p0_i                   : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		posY_p0_i                   : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		orient_p0_i                 : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
		hp_p0_i                     : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
 
		-- Player 0 gagne
		end_p0_i                    : IN STD_LOGIC;
		-- Balles player 0
		posX_b0_p0_i                : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		posY_b0_p0_i                : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		posX_b1_p0_i                : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		posY_b1_p0_i                : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		posX_b2_p0_i                : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		posY_b2_p0_i                : IN STD_LOGIC_VECTOR (7 DOWNTO 0);

		shot_b0_p0_i                : IN STD_LOGIC; -- 1 si la balle est tire, 0 sinon
		shot_b1_p0_i                : IN STD_LOGIC;
		shot_b2_p0_i                : IN STD_LOGIC;
		-- Player 1
		posX_p1_i                   : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		posY_p1_i                   : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		orient_p1_i                 : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
		hp_p1_i                     : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
 

		-- Player 1 gagne
		end_p1_i                    : IN STD_LOGIC;
 
		--blink
		blink_i                     : IN STD_LOGIC;

		-- Balles player 1
		posX_b0_p1_i                : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		posY_b0_p1_i                : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		posX_b1_p1_i                : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		posY_b1_p1_i                : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		posX_b2_p1_i                : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		posY_b2_p1_i                : IN STD_LOGIC_VECTOR (7 DOWNTO 0);

		shot_b0_p1_i                : IN STD_LOGIC; -- 1 si la balle est tire, 0 sinon
		shot_b1_p1_i                : IN STD_LOGIC;
		shot_b2_p1_i                : IN STD_LOGIC;
 
		-- fin du jeu
		end_game_i                  : IN STD_LOGIC;

		---- RAMs ----
		-- draw map
		mur_sprite_data_i           : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- data in a l'adresse demande de la ram
		sol_sprite_data_i           : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- data in a l'adresse demande de la ram
 
		mur_sprite_addr_o           : OUT STD_LOGIC_VECTOR(10 DOWNTO 0); -- adresse out pour lire dans la ram
		sol_sprite_addr_o           : OUT STD_LOGIC_VECTOR(10 DOWNTO 0); -- adresse out pour lire dans la ram
 
		grudu_text_data_i           : IN std_logic_vector(0 DOWNTO 0);
		grudu_text_addr_o           : OUT std_logic_vector(10 DOWNTO 0);
 
		nestor_text_data_i          : IN std_logic_vector(0 DOWNTO 0);
		nestor_text_addr_o          : OUT std_logic_vector(10 DOWNTO 0);
 
		end_game_screen1_data_i     : IN std_logic_vector(0 DOWNTO 0);
		end_game_screen1_addr_o     : OUT std_logic_vector(16 DOWNTO 0);
		end_game_screen0_data_i     : IN std_logic_vector(0 DOWNTO 0);
		end_game_screen0_addr_o     : OUT std_logic_vector(16 DOWNTO 0);
 
		-- perso
		grudu_up_sprite_data_i      : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		grudu_left_sprite_data_i    : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		grudu_down_sprite_data_i    : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		grudu_right_sprite_data_i   : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		nestor_up_sprite_data_i     : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		nestor_left_sprite_data_i   : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		nestor_down_sprite_data_i   : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		nestor_right_sprite_data_i  : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
 
		grudu_up_sprite_addr_o      : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		grudu_left_sprite_addr_o    : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		grudu_down_sprite_addr_o    : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		grudu_right_sprite_addr_o   : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		nestor_up_sprite_addr_o     : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		nestor_left_sprite_addr_o   : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		nestor_down_sprite_addr_o   : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		nestor_right_sprite_addr_o  : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
 
		--RGB
		Red_o                       : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
		Green_o                     : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
		Blue_o                      : OUT STD_LOGIC_VECTOR (1 DOWNTO 0)
	);
END graphic;

ARCHITECTURE Behavioral OF graphic IS
 
	-- =============================================================================
	-- SIGNAUX
	-- ============================================================================= 
 
	-----------------------------------------
	-- Temp addresses for the RAMs
	-----------------------------------------
	SIGNAL map_addr_temp_s          : INTEGER RANGE 0 TO 1600; -- permet de stocker l'adresse calcule pour la lecture dans les RAM de la map
	SIGNAL nestor_addr_temp_s       : INTEGER RANGE 0 TO 1023; -- permet de stocker l'adresse calcule pour la lecture dans les RAM des personnages
    SIGNAL grudu_addr_temp_s        : INTEGER RANGE 0 TO 1023; -- permet de stocker l'adresse calcule pour la lecture dans les RAM des personnages
    SIGNAL end_game_addr_temp_s     : INTEGER RANGE 0 TO (END_GAME_RAM_SIZE_c - 1);
	SIGNAL nestor_text_addr_temp_s  : INTEGER RANGE 0 TO (NESTOR_TEXT_RAM_SIZE_c - 1);
	SIGNAL grudu_text_addr_temp_s   : INTEGER RANGE 0 TO (GRUDU_TEXT_RAM_SIZE_c - 1);
 
	-----------------------------------------
	-- Signaux pour savoir s'il faut afficher
	-- un objet à l'écran
	-----------------------------------------
	-- bullets
	SIGNAL affich_b0_p0_s : std_logic;
	SIGNAL affich_b1_p0_s : std_logic;
	SIGNAL affich_b2_p0_s : std_logic;
	SIGNAL affich_b0_p1_s : std_logic;
	SIGNAL affich_b1_p1_s : std_logic;
	SIGNAL affich_b2_p1_s : std_logic;
 
	-- map
	SIGNAL affich_mur_sol_s : std_logic; -- permet de savoir lorsqu'il faut afficher un mur ou le sol
 
	-- personnages
	SIGNAL affich_nestor_s, affich_grudu_s : std_logic_vector(3 DOWNTO 0); -- permet de savoir quand il faut afficher le personnage, et dans quelle direction
 
	-- end game
	SIGNAL affich_end_screen1_game_s : STD_LOGIC;
	SIGNAL affich_end_screen0_game_s : STD_LOGIC;
 
	-- baniere haut de l'ecran
	SIGNAL affich_nestor_text_s : STD_LOGIC; -- savoir quand il faut afficher le text nestor
	SIGNAL affich_nestor_hp_s   : STD_LOGIC_VECTOR(7 DOWNTO 0); -- savoir quand il faut afficher les barres de vie
 
	SIGNAL affich_grudu_text_s  : STD_LOGIC;
	SIGNAL affich_grudu_hp_s    : STD_LOGIC_VECTOR(7 DOWNTO 0);
	-----------------------------------------
	-- Signaux pour l'écran
	-----------------------------------------
	-- signal de la couleur en sortie sur l'écran
	SIGNAL color_s          : std_logic_vector(7 DOWNTO 0);
 
	-- signaux relatifs au composant VGA
	SIGNAL hcount_s         : INTEGER RANGE 0 TO HMAX_c;
	SIGNAL vcount_s         : INTEGER RANGE 0 TO VMAX_c;
	SIGNAL hcount_div40_s   : INTEGER RANGE 0 TO 19;
	SIGNAL vcount_div40_s   : INTEGER RANGE 0 TO 14;
 
 
	-----------------------------------------
	-- Signaux de positions
	-----------------------------------------
	-- position des joueurs
	SIGNAL posX_p0_s    : INTEGER RANGE 0 TO (HLINES_C - 1);
	SIGNAL posY_p0_s    : INTEGER RANGE 0 TO (VLINES_C - 1);
	SIGNAL posX_p1_s    : INTEGER RANGE 0 TO (HLINES_C - 1);
	SIGNAL posY_p1_s    : INTEGER RANGE 0 TO (VLINES_C - 1);
 
	-- position des balles du joueur 0
	SIGNAL posX_b0_p0_s : INTEGER RANGE 0 TO (HLINES_C - 1);
	SIGNAL posY_b0_p0_s : INTEGER RANGE 0 TO (VLINES_C - 1);
	SIGNAL posX_b1_p0_s : INTEGER RANGE 0 TO (HLINES_C - 1);
	SIGNAL posY_b1_p0_s : INTEGER RANGE 0 TO (VLINES_C - 1);
	SIGNAL posX_b2_p0_s : INTEGER RANGE 0 TO (HLINES_C - 1);
	SIGNAL posY_b2_p0_s : INTEGER RANGE 0 TO (VLINES_C - 1);
 
	-- position des balles du joueur 1
	SIGNAL posX_b0_p1_s : INTEGER RANGE 0 TO (HLINES_C - 1);
	SIGNAL posY_b0_p1_s : INTEGER RANGE 0 TO (VLINES_C - 1);
	SIGNAL posX_b1_p1_s : INTEGER RANGE 0 TO (HLINES_C - 1);
	SIGNAL posY_b1_p1_s : INTEGER RANGE 0 TO (VLINES_C - 1);
	SIGNAL posX_b2_p1_s : INTEGER RANGE 0 TO (HLINES_C - 1);
	SIGNAL posY_b2_p1_s : INTEGER RANGE 0 TO (VLINES_C - 1);
 
 
	-----------------------------------------
	-- Autres signaux
	-----------------------------------------
 
	---- signaux pour lire une seule fois par balle dans la Distributed RAM de la balle ----
	-- player0
	SIGNAL bullet0_p0_sprite_data_s : std_logic_vector(7 DOWNTO 0);
	SIGNAL bullet1_p0_sprite_data_s : std_logic_vector(7 DOWNTO 0);
	SIGNAL bullet2_p0_sprite_data_s : std_logic_vector(7 DOWNTO 0);
	-- player1
	SIGNAL bullet0_p1_sprite_data_s : std_logic_vector(7 DOWNTO 0);
	SIGNAL bullet1_p1_sprite_data_s : std_logic_vector(7 DOWNTO 0);
	SIGNAL bullet2_p1_sprite_data_s : std_logic_vector(7 DOWNTO 0);
 
	---- signaux pour la vie des joueurs ----
	SIGNAL hp_p0_s, hp_p1_s         : INTEGER RANGE 0 TO HP_PLAYER0_c;
 
BEGIN
	-- =============================================================================
	-- ASSIGNATION DES ENTREES SUR LES SIGNAUX
	-- ============================================================================= 
	------ VGA ------ 
	-- Tronquage de hcount pour qu'il aille de 0 a 799
	hcount_s <= to_integer(unsigned(hcount_i)) WHEN (to_integer(unsigned(hcount_i)) < (HLINES_C - 1)) ELSE (HLINES_C - 1);
	-- Tronquage de vcount pour qu'il aille de 0 a 599
	vcount_s <= to_integer(unsigned(vcount_i)) WHEN (to_integer(unsigned(vcount_i)) < (VLINES_C - 1)) ELSE (VLINES_C - 1);
 
	-- hcount et vcount pour l'affichage de la carte (savoir quand mur ou sol)
	hcount_div40_s <= hcount_s / 40;
	vcount_div40_s <= vcount_s / 40;
 
	------ Position des joueurs ------
	-- la map des collisions est divise par un facteur COLLI_MAP_DIV_c, il faut donc corriger avant l'affichage
	-- player0
	posX_p0_s <= to_integer(unsigned(posX_p0_i)) * COLLI_MAP_DIV_c; 
	posY_p0_s <= to_integer(unsigned(posY_p0_i)) * COLLI_MAP_DIV_c;
	-- player1
	posX_p1_s <= to_integer(unsigned(posX_p1_i)) * COLLI_MAP_DIV_c;
	posY_p1_s <= to_integer(unsigned(posY_p1_i)) * COLLI_MAP_DIV_c;

	------ Points de vie des joueurs ------
	hp_p0_s <= to_integer(unsigned(hp_p0_i));
	hp_p1_s <= to_integer(unsigned(hp_p1_i));
	------ Position des balles ------
	-- player0
	posX_b0_p0_s <= to_integer(unsigned(posX_b0_p0_i)) * COLLI_MAP_DIV_c;
	posY_b0_p0_s <= to_integer(unsigned(posY_b0_p0_i)) * COLLI_MAP_DIV_c;
	posX_b1_p0_s <= to_integer(unsigned(posX_b1_p0_i)) * COLLI_MAP_DIV_c;
	posY_b1_p0_s <= to_integer(unsigned(posY_b1_p0_i)) * COLLI_MAP_DIV_c;
	posX_b2_p0_s <= to_integer(unsigned(posX_b2_p0_i)) * COLLI_MAP_DIV_c;
	posY_b2_p0_s <= to_integer(unsigned(posY_b2_p0_i)) * COLLI_MAP_DIV_c;
	-- player1
	posX_b0_p1_s <= to_integer(unsigned(posX_b0_p1_i)) * COLLI_MAP_DIV_c;
	posY_b0_p1_s <= to_integer(unsigned(posY_b0_p1_i)) * COLLI_MAP_DIV_c;
	posX_b1_p1_s <= to_integer(unsigned(posX_b1_p1_i)) * COLLI_MAP_DIV_c;
	posY_b1_p1_s <= to_integer(unsigned(posY_b1_p1_i)) * COLLI_MAP_DIV_c;
	posX_b2_p1_s <= to_integer(unsigned(posX_b2_p1_i)) * COLLI_MAP_DIV_c;
	posY_b2_p1_s <= to_integer(unsigned(posY_b2_p1_i)) * COLLI_MAP_DIV_c;
 
 

	-- lecture de la sprite de la balle stockée dans local.vhd
	-- p0
	bullet0_p0_sprite_data_s <= BULLET_SPRITE_C((hcount_s - posX_b0_p0_s), (vcount_s - posY_b0_p0_s));
	bullet1_p0_sprite_data_s <= BULLET_SPRITE_C((hcount_s - posX_b1_p0_s), (vcount_s - posY_b1_p0_s));
	bullet2_p0_sprite_data_s <= BULLET_SPRITE_C((hcount_s - posX_b2_p0_s), (vcount_s - posY_b2_p0_s));
	-- p1
	bullet0_p1_sprite_data_s <= BULLET_SPRITE_C((hcount_s - posX_b0_p1_s), (vcount_s - posY_b0_p1_s)); 
	bullet1_p1_sprite_data_s <= BULLET_SPRITE_C((hcount_s - posX_b1_p1_s), (vcount_s - posY_b1_p1_s));
	bullet2_p1_sprite_data_s <= BULLET_SPRITE_C((hcount_s - posX_b2_p1_s), (vcount_s - posY_b2_p1_s));

	-- =============================================================================
	-- Calcul des adreses des RAMs + mise à jour du signal d'affichage sur l'écran
	-- =============================================================================

	-- savoir quand on doit afficher le sol ou le mur en lisant dans la carte 20x15
	affich_mur_sol_s <= affich(hcount_div40_s, vcount_div40_s);

	-- calcul de l'adresse pour lire dans le bloc de RAM du mur et du sol
	map_addr_temp_s <= ((hcount_s MOD 40) + ((vcount_s MOD 40) * 40));
 
	------ Personnages ------
 
	-------------------------------------------------
	-- process pour savoir quelle orientation de nestor
	-- on doit afficher et si on doit l'afficher + calcul 
	-- de l'adresse pour lire dans la RAM
	-------------------------------------------------
	nestor_addr_calc : PROCESS(hcount_s, vcount_s, orient_p0_i, posX_p0_s, posY_p0_s)
 
	BEGIN
		-- si le pixel courant est dans le personnage nestor
		IF (((vcount_s > posY_p0_s) AND (vcount_s < (posY_p0_s + 32))) AND ((hcount_s > posX_p0_s) AND (hcount_s < (posX_p0_s + 32)))) THEN
 
			nestor_addr_temp_s <= (hcount_s - posX_p0_s) + ((vcount_s - posY_p0_s) * 32); -- calcul de l'adresse pour lire dans la RAM du personnage
 
			CASE orient_p0_i IS
				WHEN "00" => --up
					affich_nestor_s <= "1000"; -- afficher nestor up

				WHEN "01" => --left
					affich_nestor_s <= "0100"; -- afficher nestor left

				WHEN "10" => --down
					affich_nestor_s <= "0010"; -- afficher nestor down

				WHEN "11" => --right
					affich_nestor_s <= "0001"; -- afficher nestor right

				WHEN OTHERS => 
					NULL; -- afficher derniere orientation de nestor
			END CASE;
		ELSE
			affich_nestor_s <= "0000"; -- pas afficher nestor
			nestor_addr_temp_s <= 0; -- adress de la ram mise 0
		END IF;
	END PROCESS;
	-------------------------------------------------

	-------------------------------------------------
	-- process pour savoir quelle orientation de grudu
	-- on doit afficher et si on doit l'afficher + calcul 
	-- de l'adresse pour lire dans la RAM
	-------------------------------------------------
	grudu_addr_calc : PROCESS(hcount_s, vcount_s, orient_p1_i, posX_p1_s, posY_p1_s)
 
	BEGIN
		-- si le pixel courant est dans le personnage grudu
		IF (((vcount_s > posY_p1_s) AND (vcount_s < (posY_p1_s + 32))) AND ((hcount_s > posX_p1_s) AND (hcount_s < (posX_p1_s + 32)))) THEN
 
			grudu_addr_temp_s <= (hcount_s - posX_p1_s) + ((vcount_s - posY_p1_s) * 32); -- calcul de l'adresse pour lire dans la RAM
 
			CASE orient_p1_i IS 
				WHEN "00" => --up
					affich_grudu_s <= "1000"; -- afficher grudu up

				WHEN "01" => --left
					affich_grudu_s <= "0100"; -- afficher grudu left$

				WHEN "10" => --down
					affich_grudu_s <= "0010"; -- afficher grudu down

				WHEN "11" => --right
					affich_grudu_s <= "0001"; -- afficher grudu right

				WHEN OTHERS => 
					NULL; -- afficher derniere position de grudu
 
			END CASE;
		ELSE
			affich_grudu_s <= "0000"; -- pas afficher grudu
			grudu_addr_temp_s <= 0; -- adresse mise 0
		END IF;
	END PROCESS;
	-------------------------------------------------
	
    
    
    ------ Balles ------
    
	-------------------------------------------------
	-- Balle du joueur0
	-------------------------------------------------
	b0_p0_affich : PROCESS(hcount_s, vcount_s, posX_b0_p0_s, posY_b0_p0_s, shot_b0_p0_i)
	BEGIN
		affich_b0_p0_s <= '0';
		IF shot_b0_p0_i = '1' THEN
			IF (((vcount_s > posY_b0_p0_s) AND (vcount_s < (posY_b0_p0_s + BULLET_SIZE_C))) AND
			 ((hcount_s > posX_b0_p0_s) AND (hcount_s < (posX_b0_p0_s + BULLET_SIZE_C)))) THEN 
				affich_b0_p0_s <= '1';
			END IF;
		END IF;
	END PROCESS;
	-------------------------------------------------
 
	-------------------------------------------------
	-- Balle du joueur0
	-------------------------------------------------
	b1_p0_affich : PROCESS(hcount_s, vcount_s, posX_b1_p0_s, posY_b1_p0_s, shot_b1_p0_i)
	BEGIN
		affich_b1_p0_s <= '0';
		IF shot_b1_p0_i = '1' THEN
			IF (((vcount_s > posY_b1_p0_s) AND (vcount_s < (posY_b1_p0_s + BULLET_SIZE_C))) AND
			 ((hcount_s > posX_b1_p0_s) AND (hcount_s < (posX_b1_p0_s + BULLET_SIZE_C)))) THEN 
				affich_b1_p0_s <= '1';
			END IF;
		END IF;
	END PROCESS;
	-------------------------------------------------
 
	-------------------------------------------------
	-- Balle du joueur0
	-------------------------------------------------
	b2_p0_affich : PROCESS(hcount_s, vcount_s, posX_b2_p0_s, posY_b2_p0_s, shot_b2_p0_i)
	BEGIN
		affich_b2_p0_s <= '0';
		IF shot_b2_p0_i = '1' THEN
			IF (((vcount_s > posY_b2_p0_s) AND (vcount_s < (posY_b2_p0_s + BULLET_SIZE_C))) AND
			 ((hcount_s > posX_b2_p0_s) AND (hcount_s < (posX_b2_p0_s + BULLET_SIZE_C)))) THEN 
				affich_b2_p0_s <= '1';
			END IF;
		END IF;
	END PROCESS;
	-------------------------------------------------
 
	-------------------------------------------------
	-- Balle du joueur1
	-------------------------------------------------
	b0_p1_affich : PROCESS(hcount_s, vcount_s, posX_b0_p1_s, posY_b0_p1_s, shot_b0_p1_i)
	BEGIN
		affich_b0_p1_s <= '0';
		IF shot_b0_p1_i = '1' THEN
			IF (((vcount_s > posY_b0_p1_s) AND (vcount_s < (posY_b0_p1_s + BULLET_SIZE_C))) AND
			 ((hcount_s > posX_b0_p1_s) AND (hcount_s < (posX_b0_p1_s + BULLET_SIZE_C)))) THEN 
				affich_b0_p1_s <= '1';
			END IF;
		END IF;
	END PROCESS;
	-------------------------------------------------
 
	-------------------------------------------------
	-- Balle du joueur1
	-------------------------------------------------
	b1_p1_affich : PROCESS(hcount_s, vcount_s, posX_b1_p1_s, posY_b1_p1_s, shot_b1_p1_i)
	BEGIN
		affich_b1_p1_s <= '0';
		IF shot_b1_p1_i = '1' THEN
			IF (((vcount_s > posY_b1_p1_s) AND (vcount_s < (posY_b1_p1_s + BULLET_SIZE_C))) AND
			 ((hcount_s > posX_b1_p1_s) AND (hcount_s < (posX_b1_p1_s + BULLET_SIZE_C)))) THEN 
				affich_b1_p1_s <= '1';
			END IF;
		END IF;
	END PROCESS;
	-------------------------------------------------
 
	-------------------------------------------------
	-- Balle du joueur1
	-------------------------------------------------
	b2_p1_affich : PROCESS(hcount_s, vcount_s, posX_b2_p1_s, posY_b2_p1_s, shot_b2_p1_i)
	BEGIN
		affich_b2_p1_s <= '0';
		IF shot_b2_p1_i = '1' THEN
			IF (((vcount_s > posY_b2_p1_s) AND (vcount_s < (posY_b2_p1_s + BULLET_SIZE_C))) AND
			 ((hcount_s > posX_b2_p1_s) AND (hcount_s < (posX_b2_p1_s + BULLET_SIZE_C)))) THEN 
				affich_b2_p1_s <= '1';
			END IF;
		END IF;
	END PROCESS;
	-------------------------------------------------
 
 
 
	------ banière haut de l'écran ------ 
 
	-------------------------------------------------
	-- Text nestor en haut de l'écran
	-------------------------------------------------
	nestor_text_addr_calc : PROCESS(hcount_s, vcount_s)
	BEGIN
		affich_nestor_text_s <= '0';
		IF ((hcount_s > POSX_TEXT_NESTOR_c) AND (hcount_s < (POSX_TEXT_NESTOR_c + SIZEX_TEXT_NESTOR_c)))
		 AND ((vcount_s > POSY_TEXT_NESTOR_c) AND (vcount_s < (POSY_TEXT_NESTOR_c + SIZEY_TEXT_NESTOR_c))) THEN
			affich_nestor_text_s <= '1';
			nestor_text_addr_temp_s <= (hcount_s - POSX_TEXT_NESTOR_c) + ((vcount_s - POSY_TEXT_NESTOR_c) * SIZEX_TEXT_NESTOR_c);
		ELSE
			nestor_text_addr_temp_s <= 0;
		END IF;
	END PROCESS;
	-------------------------------------------------
 
	-------------------------------------------------
	-- Barre de vie de nestor en haut de l'écran
	-------------------------------------------------
	nestor_hp_affich : PROCESS(hcount_s, vcount_s)
	BEGIN
		-- de base
		affich_nestor_hp_s <= "00000000";

		-- gestion des barres de vie
		-- curseur vertical se trouve dans la banière
		IF ((vcount_s > POSY_HP_NESTOR_c) AND (vcount_s < (POSY_HP_NESTOR_c + SIZEY_HP_NESTOR_c))) THEN
			-- curseur horizontal dans pt de vie 1
			IF ((hcount_s > POSX_HP_NESTOR_c) AND (hcount_s < (POSX_HP_NESTOR_c + SIZEX_ONE_HP_BAR_c))) THEN
				affich_nestor_hp_s <= "10000000";
			END IF;
			-- curseur horizontal dans pt de vie 2
			IF ((hcount_s >= (POSX_HP_NESTOR_c + SIZEX_ONE_HP_BAR_c)) AND (hcount_s < (POSX_HP_NESTOR_c + (2 * SIZEX_ONE_HP_BAR_c)))) THEN
				affich_nestor_hp_s <= "01000000";
			END IF;
			-- curseur horizontal dans pt de vie 3
			IF ((hcount_s >= (POSX_HP_NESTOR_c + (2 * SIZEX_ONE_HP_BAR_c))) AND (hcount_s < (POSX_HP_NESTOR_c + (3 * SIZEX_ONE_HP_BAR_c)))) THEN
				affich_nestor_hp_s <= "00100000";
			END IF;
			-- curseur horizontal dans pt de vie 4
			IF ((hcount_s >= (POSX_HP_NESTOR_c + (3 * SIZEX_ONE_HP_BAR_c))) AND (hcount_s < (POSX_HP_NESTOR_c + (4 * SIZEX_ONE_HP_BAR_c)))) THEN
				affich_nestor_hp_s <= "00010000";
			END IF;
			-- curseur horizontal dans pt de vie 5
			IF ((hcount_s >= (POSX_HP_NESTOR_c + (4 * SIZEX_ONE_HP_BAR_c))) AND (hcount_s < (POSX_HP_NESTOR_c + (5 * SIZEX_ONE_HP_BAR_c)))) THEN
				affich_nestor_hp_s <= "00001000";
			END IF;
			-- curseur horizontal dans pt de vie 6
			IF ((hcount_s >= (POSX_HP_NESTOR_c + (5 * SIZEX_ONE_HP_BAR_c))) AND (hcount_s < (POSX_HP_NESTOR_c + (6 * SIZEX_ONE_HP_BAR_c)))) THEN
				affich_nestor_hp_s <= "00000100";
			END IF;
			-- curseur horizontal dans pt de vie 7
			IF ((hcount_s >= (POSX_HP_NESTOR_c + (6 * SIZEX_ONE_HP_BAR_c))) AND (hcount_s < (POSX_HP_NESTOR_c + (7 * SIZEX_ONE_HP_BAR_c)))) THEN
				affich_nestor_hp_s <= "00000010";
			END IF;
			-- curseur horizontal dans pt de vie 8
			IF ((hcount_s >= (POSX_HP_NESTOR_c + (7 * SIZEX_ONE_HP_BAR_c))) AND (hcount_s < (POSX_HP_NESTOR_c + (8 * SIZEX_ONE_HP_BAR_c)))) THEN
				affich_nestor_hp_s <= "00000001";
			END IF;
		END IF;
	END PROCESS;
	-------------------------------------------------
 
	-------------------------------------------------
	-- Text grudu en haut de l'écran
	-------------------------------------------------
	grudu_text_addr_calc : PROCESS(hcount_s, vcount_s)
	BEGIN
		affich_grudu_text_s <= '0';
		IF (hcount_s > POSX_TEXT_GRUDU_c) AND (hcount_s < (POSX_TEXT_GRUDU_c + SIZEX_TEXT_GRUDU_c))
		 AND (vcount_s > POSY_TEXT_GRUDU_c) AND (vcount_s < (POSY_TEXT_GRUDU_c + SIZEY_TEXT_GRUDU_c)) THEN
			affich_grudu_text_s <= '1';
			grudu_text_addr_temp_s <= (hcount_s - POSX_TEXT_GRUDU_c) + ((vcount_s - POSY_TEXT_GRUDU_c) * SIZEX_TEXT_GRUDU_c);
		ELSE
			grudu_text_addr_temp_s <= 0;
		END IF;
	END PROCESS;
	-------------------------------------------------
 
 
	-------------------------------------------------
	-- Barre de vie de grudu en haut de l'écran
	-------------------------------------------------
	grudu_hp_affich : PROCESS(hcount_s, vcount_s)
	BEGIN
		-- de base
		affich_grudu_hp_s <= "00000000";
 
		-- gestion des barres de vie
		-- curseur vertical se trouve dans la banière
		IF ((vcount_s > POSY_HP_GRUDU_c) AND (vcount_s < (POSY_HP_GRUDU_c + SIZEY_HP_GRUDU_c))) THEN
			-- curseur horizontal dans pt de vie 1
			IF ((hcount_s > POSX_HP_GRUDU_c) AND (hcount_s < (POSX_HP_GRUDU_c + SIZEX_ONE_HP_BAR_c))) THEN
				affich_grudu_hp_s <= "10000000";
			END IF;
			-- curseur horizontal dans pt de vie 2
			IF ((hcount_s >= (POSX_HP_GRUDU_c + SIZEX_ONE_HP_BAR_c)) AND (hcount_s < (POSX_HP_GRUDU_c + (2 * SIZEX_ONE_HP_BAR_c)))) THEN
				affich_grudu_hp_s <= "01000000";
			END IF;
			-- curseur horizontal dans pt de vie 3
			IF ((hcount_s >= (POSX_HP_GRUDU_c + (2 * SIZEX_ONE_HP_BAR_c))) AND (hcount_s < (POSX_HP_GRUDU_c + (3 * SIZEX_ONE_HP_BAR_c)))) THEN
				affich_grudu_hp_s <= "00100000";
			END IF;
			-- curseur horizontal dans pt de vie 4
			IF ((hcount_s >= (POSX_HP_GRUDU_c + (3 * SIZEX_ONE_HP_BAR_c))) AND (hcount_s < (POSX_HP_GRUDU_c + (4 * SIZEX_ONE_HP_BAR_c)))) THEN
				affich_grudu_hp_s <= "00010000";
			END IF;
			-- curseur horizontal dans pt de vie 5
			IF ((hcount_s >= (POSX_HP_GRUDU_c + (4 * SIZEX_ONE_HP_BAR_c))) AND (hcount_s < (POSX_HP_GRUDU_c + (5 * SIZEX_ONE_HP_BAR_c)))) THEN
				affich_grudu_hp_s <= "00001000";
			END IF;
			-- curseur horizontal dans pt de vie 6
			IF ((hcount_s >= (POSX_HP_GRUDU_c + (5 * SIZEX_ONE_HP_BAR_c))) AND (hcount_s < (POSX_HP_GRUDU_c + (6 * SIZEX_ONE_HP_BAR_c)))) THEN
				affich_grudu_hp_s <= "00000100";
			END IF;
			-- curseur horizontal dans pt de vie 7
			IF ((hcount_s >= (POSX_HP_GRUDU_c + (6 * SIZEX_ONE_HP_BAR_c))) AND (hcount_s < (POSX_HP_GRUDU_c + (7 * SIZEX_ONE_HP_BAR_c)))) THEN
				affich_grudu_hp_s <= "00000010";
			END IF;
			-- curseur horizontal dans pt de vie 8
			IF ((hcount_s >= (POSX_HP_GRUDU_c + (7 * SIZEX_ONE_HP_BAR_c))) AND (hcount_s < (POSX_HP_GRUDU_c + (8 * SIZEX_ONE_HP_BAR_c)))) THEN
				affich_grudu_hp_s <= "00000001";
			END IF;
		END IF;
	END PROCESS;
	-------------------------------------------------
 
 
	-------------------------------------------------
	-- Screen de fin de jeux
	-------------------------------------------------
	end_game_addr_calc : PROCESS(hcount_s, vcount_s, end_game_i, blink_i)
	BEGIN
		IF end_game_i = '1' THEN
			IF ((hcount_s > POSX_END_GAME_c) AND (hcount_s < (POSX_END_GAME_c + SIZEX_END_GAME_c))) AND
			 ((vcount_s > POSY_END_GAME_c) AND (vcount_s < (POSY_END_GAME_c + SIZEY_END_GAME_c))) THEN
				-- calcul de l'adresse pour lire dans la RAM
				end_game_addr_temp_s <= (hcount_s - POSX_END_GAME_c) + ((vcount_s - POSY_END_GAME_c) * SIZEX_END_GAME_c);
				-- affichage sur l'écran
				IF blink_i = '0' THEN
					affich_end_screen1_game_s <= '0';
					affich_end_screen0_game_s <= '1';
				ELSE
					affich_end_screen1_game_s <= '1';
					affich_end_screen0_game_s <= '0';
				END IF;
			ELSE
				affich_end_screen1_game_s <= '0';
				affich_end_screen0_game_s <= '0';
			END IF;
		ELSE
			affich_end_screen1_game_s <= '0';
			affich_end_screen0_game_s <= '0';
		END IF;
	END PROCESS;
	-------------------------------------------------
	-- =============================================================================
	-- AFFICHAGE SUR L'ECRAN
	-- =============================================================================
	-------------------------------------------------
	-- Process pour l'affichage sur l'écran
	draw : PROCESS (hcount_s, vcount_s)
 
 
	BEGIN
		-- AFFICHAGE MAP
		IF affich_mur_sol_s = '1' THEN -- mur
			color_s <= mur_sprite_data_i;
		ELSE -- sol
			color_s <= sol_sprite_data_i;
		END IF;
 
		-- AFFICHAGE PERSONNAGES
		--nestor
		CASE affich_nestor_s IS
			WHEN "1000" => -- up
				IF (nestor_up_sprite_data_i /= x"FF") THEN
						color_s <= nestor_up_sprite_data_i;
				END IF;
 
			WHEN "0100" => -- left
				IF (nestor_left_sprite_data_i /= x"FF") THEN
						color_s <= nestor_left_sprite_data_i;
				END IF;
 
			WHEN "0010" => -- down
				IF (nestor_down_sprite_data_i /= x"FF") THEN
						color_s <= nestor_down_sprite_data_i;
				END IF; 
			WHEN "0001" => -- right
				IF (nestor_right_sprite_data_i /= x"FF") THEN
						color_s <= nestor_right_sprite_data_i;
				END IF;

			WHEN OTHERS => NULL; -- pas afficher le personnage
		END CASE;
 
		-- grudu
		CASE affich_grudu_s IS
			WHEN "1000" => -- up
				IF (grudu_up_sprite_data_i /= x"FF") THEN
						color_s <= grudu_up_sprite_data_i;
				END IF;
 
			WHEN "0100" => -- left
				IF (grudu_left_sprite_data_i /= x"FF") THEN
						color_s <= grudu_left_sprite_data_i;
				END IF;
 
			WHEN "0010" => -- down
				IF (grudu_down_sprite_data_i /= x"FF") THEN
						color_s <= grudu_down_sprite_data_i;
				END IF; 
			WHEN "0001" => -- right
				IF (grudu_right_sprite_data_i /= x"FF") THEN
						color_s <= grudu_right_sprite_data_i;
				END IF;

			WHEN OTHERS => NULL; -- pas afficher le personnage
		END CASE;
 
		---------------------------------
		-- AFFICHAGE BALLES
		IF affich_b0_p0_s = '1' THEN
			IF (bullet0_p0_sprite_data_s = X"FF") THEN
					color_s <= bullet0_p0_sprite_data_s;
			END IF;
		END IF;
 
		IF affich_b1_p0_s = '1' THEN
			IF (bullet1_p0_sprite_data_s = X"FF") THEN
					color_s <= bullet1_p0_sprite_data_s;
			END IF; 
		END IF;
 
		IF affich_b2_p0_s = '1' THEN
			IF (bullet2_p0_sprite_data_s = X"FF") THEN
					color_s <= bullet2_p0_sprite_data_s;
			END IF;
		END IF;
 
		IF affich_b0_p1_s = '1' THEN
			IF (bullet0_p1_sprite_data_s = X"FF") THEN
					color_s <= bullet0_p1_sprite_data_s;
			END IF; 
		END IF;
 
		IF affich_b1_p1_s = '1' THEN
			IF (bullet1_p1_sprite_data_s = X"FF") THEN
					color_s <= bullet1_p1_sprite_data_s;
			END IF; 
		END IF;
 
		IF affich_b2_p1_s = '1' THEN
			IF (bullet2_p1_sprite_data_s = X"FF") THEN
					color_s <= bullet2_p1_sprite_data_s;
			END IF;
		END IF;
 
 
		---------------------------------
		-- AFFICHAGE BANIERE SCORES
		-- nestor_text
		IF affich_nestor_text_s = '1' THEN
			IF nestor_text_data_i = "1" THEN
				color_s <= NESTOR_COLOR_c;
			END IF;
		END IF;
 
		-- Vie nestor
		CASE affich_nestor_hp_s IS
			WHEN "10000000" => 
				IF hp_p0_s >= 1 THEN
					color_s <= HP_GREEN_COLOR_c;
				ELSE
					color_s <= HP_RED_COLOR_c;
				END IF;
			WHEN "01000000" => 
				IF hp_p0_s >= 2 THEN
					color_s <= HP_GREEN_COLOR_c;
				ELSE
					color_s <= HP_RED_COLOR_c;
				END IF;
			WHEN "00100000" => 
				IF hp_p0_s >= 3 THEN
					color_s <= HP_GREEN_COLOR_c;
				ELSE
					color_s <= HP_RED_COLOR_c;
				END IF;
			WHEN "00010000" => 
				IF hp_p0_s >= 4 THEN
					color_s <= HP_GREEN_COLOR_c;
				ELSE
					color_s <= HP_RED_COLOR_c;
				END IF;
			WHEN "00001000" => 
				IF hp_p0_s >= 5 THEN
					color_s <= HP_GREEN_COLOR_c;
				ELSE
					color_s <= HP_RED_COLOR_c;
				END IF;
			WHEN "00000100" => 
				IF hp_p0_s >= 6 THEN
					color_s <= HP_GREEN_COLOR_c;
				ELSE
					color_s <= HP_RED_COLOR_c;
				END IF;
			WHEN "00000010" => 
				IF hp_p0_s >= 7 THEN
					color_s <= HP_GREEN_COLOR_c;
				ELSE
					color_s <= HP_RED_COLOR_c;
				END IF;
			WHEN "00000001" => 
				IF hp_p0_s = 8 THEN
					color_s <= HP_GREEN_COLOR_c;
				ELSE
					color_s <= HP_RED_COLOR_c;
				END IF;
			WHEN OTHERS => 
				NULL;
		END CASE;
 
 
		-- grudu_text
		IF affich_grudu_text_s = '1' THEN
			IF grudu_text_data_i = "1" THEN
				color_s <= GRUDU_COLOR_c;
			END IF;
		END IF;
 
 
		-- Vie grudu
		CASE affich_grudu_hp_s IS
			WHEN "10000000" => 
				IF hp_p1_s >= 1 THEN
					color_s <= HP_GREEN_COLOR_c;
				ELSE
					color_s <= HP_RED_COLOR_c;
				END IF;
			WHEN "01000000" => 
				IF hp_p1_s >= 2 THEN
					color_s <= HP_GREEN_COLOR_c;
				ELSE
					color_s <= HP_RED_COLOR_c;
				END IF;
			WHEN "00100000" => 
				IF hp_p1_s >= 3 THEN
					color_s <= HP_GREEN_COLOR_c;
				ELSE
					color_s <= HP_RED_COLOR_c;
				END IF;
			WHEN "00010000" => 
				IF hp_p1_s >= 4 THEN
					color_s <= HP_GREEN_COLOR_c;
				ELSE
					color_s <= HP_RED_COLOR_c;
				END IF;
			WHEN "00001000" => 
				IF hp_p1_s >= 5 THEN
					color_s <= HP_GREEN_COLOR_c;
				ELSE
					color_s <= HP_RED_COLOR_c;
				END IF;
			WHEN "00000100" => 
				IF hp_p1_s >= 6 THEN
					color_s <= HP_GREEN_COLOR_c;
				ELSE
					color_s <= HP_RED_COLOR_c;
				END IF;
			WHEN "00000010" => 
				IF hp_p1_s >= 7 THEN
					color_s <= HP_GREEN_COLOR_c;
				ELSE
					color_s <= HP_RED_COLOR_c;
				END IF;
			WHEN "00000001" => 
				IF hp_p1_s = 8 THEN
					color_s <= HP_GREEN_COLOR_c;
				ELSE
					color_s <= HP_RED_COLOR_c;
				END IF;
			WHEN OTHERS => 
				NULL;
		END CASE;
 
 
 
		---------------------------------
		-- AFFICHAGE END_SCREEN
		IF affich_end_screen0_game_s = '1' THEN
			IF end_game_screen0_data_i = "0" THEN
				IF end_p0_i = '1' THEN 
					-- p0 gagne
					color_s <= NESTOR_COLOR_c;
				ELSIF end_p1_i = '1' THEN
					-- p1 gagne
					color_s <= GRUDU_COLOR_c;
				END IF;
			END IF;
		END IF;

		IF affich_end_screen1_game_s = '1' THEN
 
			IF end_game_screen1_data_i = "0" THEN
				IF end_p0_i = '1' THEN
					-- p0 gagne
					color_s <= NESTOR_COLOR_c;
				ELSIF end_p1_i = '1' THEN
					color_s <= GRUDU_COLOR_c;
				END IF;
			END IF;
		END IF;
		-------------------------------
 
	END PROCESS;
	----------------------------------------
 
	-- =============================================================================
	-- ASSIGNATION DES SORTIES
	-- ============================================================================= 

	------ assignation des adresses RAMs calculées ------
	-- carte
	mur_sprite_addr_o <= std_logic_vector(to_unsigned(map_addr_temp_s, 11));
	sol_sprite_addr_o <= std_logic_vector(to_unsigned(map_addr_temp_s, 11));

	-- personnages
	grudu_up_sprite_addr_o <= std_logic_vector(to_unsigned(grudu_addr_temp_s, 10));
	grudu_left_sprite_addr_o <= std_logic_vector(to_unsigned(grudu_addr_temp_s, 10));
	grudu_down_sprite_addr_o <= std_logic_vector(to_unsigned(grudu_addr_temp_s, 10));
	grudu_right_sprite_addr_o <= std_logic_vector(to_unsigned(grudu_addr_temp_s, 10));
	nestor_up_sprite_addr_o <= std_logic_vector(to_unsigned(nestor_addr_temp_s, 10));
	nestor_left_sprite_addr_o <= std_logic_vector(to_unsigned(nestor_addr_temp_s, 10));
	nestor_down_sprite_addr_o <= std_logic_vector(to_unsigned(nestor_addr_temp_s, 10));
	nestor_right_sprite_addr_o <= std_logic_vector(to_unsigned(nestor_addr_temp_s, 10));
 
	-- end_screen
	end_game_screen1_addr_o <= std_logic_vector(to_unsigned(end_game_addr_temp_s, 17));
	end_game_screen0_addr_o <= std_logic_vector(to_unsigned(end_game_addr_temp_s, 17));
 
	-- text banière
	nestor_text_addr_o <= std_logic_vector(to_unsigned(nestor_text_addr_temp_s, 11));
	grudu_text_addr_o <= std_logic_vector(to_unsigned(grudu_text_addr_temp_s, 11));
 
 
	------ sorties sur l'écran ------
	red_o <= color_s(7 DOWNTO 5) WHEN blank_i = '0' ELSE "000";
	green_o <= color_s(4 DOWNTO 2) WHEN blank_i = '0' ELSE "000";
	blue_o <= color_s(1 DOWNTO 0) WHEN blank_i = '0' ELSE "00";
 
END Behavioral;
