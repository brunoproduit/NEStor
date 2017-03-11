----------------------------------------------------------------------------------
-- Company: HEIA-FR
-- Engineer: Bruno Produit & Joachim Burket
--
-- Create Date: 17:06:54 04/06/2016
-- Design Name:
-- Module Name: game_ctrl - package
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
ENTITY game_ctrl IS
   PORT (
            game_clk_i      : IN STD_LOGIC;
            rst_i           : IN STD_LOGIC;
            dead_p0_i       : IN STD_LOGIC;
            dead_p1_i       : IN STD_LOGIC;
            restart_game_i  : IN STD_LOGIC;
            end_game_o      : OUT STD_LOGIC;    -- indique aux autres composants que le jeux est terminé
            p0_win_o        : OUT STD_LOGIC;    -- indique que le player 0 à gagné
            p1_win_o        : OUT STD_LOGIC     -- indique que le player 1 à gagné
        );
END game_ctrl;

ARCHITECTURE Behavioral OF game_ctrl IS



TYPE etat IS (game, end_game_p0, end_game_p1);      -- end_game_p0 : p0 gagne;   end_game_p1 : P1 gagne
    SIGNAL etat_present, etat_futur : etat;

BEGIN


    ------------------------------------------
    -- Combinatoire d'entrée
    combinatoire : PROCESS(etat_present, restart_game_i, dead_p0_i, dead_p1_i)
    BEGIN
        CASE etat_present IS
            WHEN game => 
                IF (dead_p1_i = '1') THEN
                    etat_futur <= end_game_p0;
                    
                ELSIF (dead_p0_i = '1') THEN
                    etat_futur <= end_game_p1;
                    
                ELSE
                    etat_futur <= game;
                END IF;
                
            WHEN end_game_p0 => 
                IF restart_game_i = '1' THEN
                    etat_futur <= game;
                ELSE
                    etat_futur <= end_game_p0;
                END IF;
                
            WHEN end_game_p1 => 
                IF restart_game_i = '1' THEN
                    etat_futur <= game;
                ELSE
                    etat_futur <= end_game_p1;
                END IF;
                
            WHEN OTHERS => 
                etat_futur <= game;
        END CASE;
    END PROCESS combinatoire;
    ------------------------------------------


    ------------------------------------------
    -- Bascule D
    registre : PROCESS(game_clk_i, rst_i)
    BEGIN
        IF rst_i = '1' THEN
            etat_present <= game;
        ELSIF rising_edge(game_clk_i) THEN
            etat_present <= etat_futur;
        END IF;
    END PROCESS registre;
    ------------------------------------------
    
    
    ------------------------------------------
    -- assignation des sorties
    PROCESS (etat_present)
    BEGIN
    
        IF (etat_present = end_game_p0) THEN
           end_game_o <= '1';
           p0_win_o <= '1';
           p1_win_o <= '0';
            
        ELSIF (etat_present = end_game_p1) THEN
           end_game_o <= '1';
           p0_win_o <= '0';
           p1_win_o <= '1';
        
        ELSE
            end_game_o <= '0';
            p0_win_o <= '0';
            p1_win_o <= '0';
        END IF;
    END PROCESS;
    ------------------------------------------

END ARCHITECTURE;