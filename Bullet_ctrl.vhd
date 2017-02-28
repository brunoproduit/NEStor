----------------------------------------------------------------------------------
-- Company: HEIA-FR
-- Engineer: Joachim Burket & Bruno Produit
--
-- Create Date: 09:12:14 04/08/2016
-- Design Name:
-- Module Name: Bullet_ctrl - Behavioral
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

ENTITY bullet_ctrl IS
	PORT (
		button_shoot_i, shot_b0_i, shot_b1_i, shot_b2_i, game_clk_i, rst_i : IN STD_LOGIC;
		-- fin du jeu
		end_game_i : IN STD_LOGIC;
		shoot_b0_o, shoot_b1_o, shoot_b2_o : OUT STD_LOGIC
	);
END bullet_ctrl;

ARCHITECTURE Behavioral OF bullet_ctrl IS

	TYPE etat IS (depart, impulsion, attendre);
	SIGNAL etat_present, etat_futur : etat;

BEGIN

    ----------------------------------------------
    -- En sortie, une impulsion d'un coup de clock
    -- est envoyee si l'etat est impulsion
    ----------------------------------------------
	sortie : PROCESS (game_clk_i, rst_i)
	BEGIN
		IF (rst_i = '1') THEN
			shoot_b0_o <= '0';
			shoot_b1_o <= '0';
			shoot_b2_o <= '0';
		ELSIF rising_edge(game_clk_i) THEN
			-- impulsion d'un coup de clock sur shoot_o
			IF (etat_present = impulsion) THEN
				IF shot_b0_i = '0' THEN
					shoot_b0_o <= '1';
					shoot_b1_o <= '0';
					shoot_b2_o <= '0';
				ELSIF shot_b1_i = '0' THEN
					shoot_b0_o <= '0';
					shoot_b1_o <= '1';
					shoot_b2_o <= '0';
				ELSIF shot_b2_i = '0' THEN
					shoot_b0_o <= '0';
					shoot_b1_o <= '0';
					shoot_b2_o <= '1';
				ELSE
					shoot_b0_o <= '0';
					shoot_b1_o <= '0';
					shoot_b2_o <= '0';
				END IF;
			ELSE
				shoot_b0_o <= '0';
				shoot_b1_o <= '0';
				shoot_b2_o <= '0';
			END IF;
		END IF;
	END PROCESS;
    ----------------------------------------------
    
    
    ----------------------------------------------
    -- registre du monoflop
    ----------------------------------------------
	registre : PROCESS(game_clk_i, rst_i)
	BEGIN
		IF rst_i = '1' THEN
			etat_present <= depart;
		ELSIF rising_edge(game_clk_i) THEN
			etat_present <= etat_futur;
		END IF;
	END PROCESS registre;
    ----------------------------------------------
    
    ----------------------------------------------
    -- Combinatoire d'entree
    ----------------------------------------------
	combinatoire_entree : PROCESS(etat_present, button_shoot_i)
	BEGIN
		CASE etat_present IS
			WHEN depart => 
				IF button_shoot_i = '0' THEN
					etat_futur <= depart;
				ELSE
					etat_futur <= impulsion;
				END IF;
			WHEN impulsion => 
				IF button_shoot_i = '0' THEN
					etat_futur <= depart;
				ELSE
					etat_futur <= attendre;
				END IF;
			WHEN attendre => 
				IF button_shoot_i = '0' THEN
					etat_futur <= depart;
				ELSE
					etat_futur <= attendre;
				END IF;
			WHEN OTHERS => 
				etat_futur <= depart;
		END CASE;
	END PROCESS combinatoire_entree;
    ----------------------------------------------
    
END Behavioral;
