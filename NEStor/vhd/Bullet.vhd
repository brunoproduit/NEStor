----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 17:14:57 04/06/2016
-- Design Name:
-- Module Name: Bullet0_p0 - Behavioral
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
ENTITY Bullet IS
    PORT (
        game_clk_i : IN STD_LOGIC;
        rst_i : IN STD_LOGIC;

        -- enable
        shoot_i : IN STD_LOGIC;

        -- position du player qui tire
        posX_p_i : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        posY_p_i : IN STD_LOGIC_VECTOR (7 DOWNTO 0);


        -- position du player adverse
        posX_adv_i : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        posY_adv_i : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        -- orientation du joueur qui tire
        Orient_i : IN STD_LOGIC_VECTOR (1 DOWNTO 0); -- 00 = up, 01 = left, 10 = down, 11 = right

        -- fin du jeu
        end_game_i    : IN STD_LOGIC;
        
        -- position de la balle
        posX_o : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
        posY_o : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);

        -- balle tire si 1
        shot_o : OUT STD_LOGIC;
        
        -- collision map
        collision_map_data_i : IN STD_LOGIC_VECTOR(0 downto 0); 
        collision_map_addr_o : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
        hit_o : OUT STD_LOGIC  --impulsion de collision avec un joueur
    );
END Bullet;

ARCHITECTURE Behavioral OF Bullet IS

    SIGNAL posX_s : INTEGER RANGE 0 TO (COLLI_MAP_X - 1);   -- signal de la position X de la balle
    SIGNAL posY_s : INTEGER RANGE 0 TO (COLLI_MAP_Y - 1);   -- signal de la position Y de la balle
    SIGNAL posX_depart_s : INTEGER RANGE 0 TO (COLLI_MAP_X - 1);    -- signal de la position X de départ de la balle 
    SIGNAL posY_depart_s : INTEGER RANGE 0 TO (COLLI_MAP_Y - 1);    -- signal de la position Y de départ de la balle 
    SIGNAL posX_adv_s : INTEGER RANGE 0 TO (COLLI_MAP_X - 1);
    SIGNAL posY_adv_s : INTEGER RANGE 0 TO (COLLI_MAP_Y - 1);
    SIGNAL shot_s : STD_LOGIC;
    signal map_addr_temp_s : integer range 0 to 30000;   -- permet de stocker l'adresse calcule pour la lecture dans les RAM de la map de collisions
    signal orient_bullet_s : STD_LOGIC_VECTOR (1 DOWNTO 0);
    signal count_s : INTEGER RANGE 0 TO (COUNT_MOV_BULLET - 1);
    
    
    
BEGIN
    posX_o <= std_logic_vector(to_unsigned(posX_s, 8));
    posY_o <= std_logic_vector(to_unsigned(posY_s, 8));
    posX_adv_s <= to_integer(unsigned(posX_adv_i));
    posY_adv_s <= to_integer(unsigned(posY_adv_i));
    shot_o <= shot_s;

    -- assignation de l'adresse calcule en sortie
    collision_map_addr_o <= std_logic_vector(to_unsigned(map_addr_temp_s,15));   
    

    ----------------------------------------------
    -- Process de lecture dans la carte des
    -- collisions en fonction du deplacement
    ----------------------------------------------
    read_collision_map : process(orient_bullet_s, rst_i, posX_s, posY_s)
    begin
        if rst_i = '1' then
            map_addr_temp_s <= 0;
        else
            case orient_bullet_s is
            
                -- deplacement en haut
                when "00" => 
                    map_addr_temp_s <= posX_s + ((posY_s - 1) * 200);
                --------------------------------------------------
                
                -- deplacement gauche
                when "01" =>
                    map_addr_temp_s <= (posX_s - 1) + (posY_s * 200);
                --------------------------------------------------
                
                -- deplacement en bas
                when "10" =>
                    map_addr_temp_s <= posX_s + ((posY_s + 2) * 200);
                --------------------------------------------------
                
                -- deplacement  droite
                when others =>
                    map_addr_temp_s <= (posX_s + 2) + (posY_s * 200);
                --------------------------------------------------
            end case;
        end if;
    end process;
    ----------------------------------------------
    
    
    ----------------------------------------------
    -- Process de ralentissement du deplacement
    -- + deplacement + gestion des collisions
    ----------------------------------------------
    compteur_deplacement: PROCESS (game_clk_i, rst_i)
    BEGIN
        IF (rst_i = '1') THEN
            posX_s <= 0; --default state on reset.
            posY_s <= 0;
            shot_s <= '0';
            count_s <= 0;
            hit_o <= '0';
        ELSIF rising_edge(game_clk_i) THEN
            -- si jeux terminé
            IF end_game_i = '1' THEN
                posX_s <= 0; --default state on reset.
                posY_s <= 0;
                shot_s <= '0';
                count_s <= 0;
                hit_o <= '0';
            -- pendant le jeux
            ELSE
                ---------------------------------------
                -- impulsion de tir et init
                ---------------------------------------
                IF shoot_i = '1' THEN
                
                    orient_bullet_s <= Orient_i;
                    posX_s <= posX_depart_s; 
                    posY_s <= posY_depart_s;
                    shot_s <= '1';
                    count_s <= 0;
                    hit_o <= '0';
                    ---------------------------------------
     
                ELSE
                    -- si la balle est tirée et n'a pas rencontré d'obstacle
                    IF shot_s = '1' THEN
                        count_s <= count_s + 1;
                        
                        -- overflow du compteur
                        IF count_s = COUNT_MOV_BULLET THEN
     
                            count_s <= 0; -- retour a 0 (modulo COUNT_MOV_BULLET)
     
                            -- déplacement de la balle en fonction de l'orientation lors du tir
                            CASE orient_bullet_s IS
                            
                                -------------------------------------------
                                -- deplacement vers le haut
                                WHEN "00" => 
                                    if posY_s > 0   then
                                        if (collision_map_data_i = "0") then
                                            -- collision avec joueur adverse
                                            if (((posX_s > posX_adv_s) and (posX_s < (posX_adv_s + 8))) and 
                                            ((posY_s < (posY_adv_s + 8)) and (posY_s > posY_adv_s))) then
                                                
                                                shot_s <= '0';  -- balle disparait
                                                hit_o <= '1';   -- Indique au joueur qu'il est touché
                                            else
                                                posY_s <= posY_s - 1; 
                                            end if;
                                            
                                        -- collision avec mur
                                        else
                                            shot_s <= '0';  -- balle disparait
                                        end if;
                                        
                                    -- collision avec bord carte
                                    else
                                        shot_s <= '0';  -- balle disparait
                                    end if;
                                -------------------------------------------
                                    
                                -------------------------------------------
                                -- deplacement a gauche                           
                                WHEN "01" => 
                                    if posX_s > 0   then
                                        if (collision_map_data_i = "0") then
                                            if (((posY_s > posY_adv_s) and (posY_s < (posY_adv_s + 8))) and 
                                            ((posX_s < (posX_adv_s + 8)) and (posX_s > posX_adv_s))) then
                                                shot_s <= '0';
                                                hit_o <= '1';
                                            else
                                                posX_s <= posX_s - 1;
                                            end if;
                                            
                                        -- collision avec mur
                                        else
                                            shot_s <= '0';  -- balle disparait
                                        end if;
                                        
                                    -- collision avec bord carte
                                    else
                                        shot_s <= '0';  -- balle disparait
                                    end if;
                                -------------------------------------------
                                
                                -------------------------------------------
                                -- deplacement vers le bas
                                WHEN "10" => 
                                    if posY_s < (COLLI_MAP_Y - 1)   then
                                        if (collision_map_data_i = "0") then
                                            if (((posX_s > posX_adv_s) and (posX_s < (posX_adv_s + 8))) and 
                                            ((posY_s > posY_adv_s) and (posY_s < (posY_adv_s + 8)))) then
                                                shot_s <= '0';
                                                hit_o <= '1';
                                            else
                                                posY_s <= posY_s + 1;
                                            end if;
                                            
                                        -- collision avec mur
                                        else
                                            shot_s <= '0';  -- balle disparait
                                        end if;
                                        
                                    -- collision avec bord carte
                                    else
                                        shot_s <= '0';  -- balle disparait
                                    end if;
                                -------------------------------------------
                                
                                -------------------------------------------
                                -- deplacement a droite
                                WHEN OTHERS => 
                                    if posX_s < (COLLI_MAP_X - 1)   then
                                        if (collision_map_data_i = "0") then
                                            if (((posY_s > posY_adv_s) and (posY_s < (posY_adv_s + 8))) and 
                                            ((posX_s > posX_adv_s) and (posX_s < (posX_adv_s + 8)))) then
                                                shot_s <= '0';
                                                hit_o <= '1';
                                            else
                                                posX_s <= posX_s + 1;
                                            end if;
                                            
                                        -- collision avec mur
                                        else
                                            shot_s <= '0';  -- balle disparait
                                        end if;
                                        
                                    -- collision avec bord carte
                                    else
                                        shot_s <= '0';  -- balle disparait
                                    end if;
                                -------------------------------------------  
                            END CASE;
                        END IF;
                    ELSE
                        hit_o <= '0';
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS compteur_deplacement;
    ------------------------------------------
    
    
    ----------------------------------------------
    -- process qui met a jour la position du départ
    -- de la balle en fonction de l'orientation et
    -- de la position du joueur
    ----------------------------------------------
    update_pos_depart_bullet : process(orient_i, posX_p_i, posY_p_i)
    BEGIN
        CASE orient_i IS         
            -------------------------------------------
            -- deplacement vers le haut
            WHEN "00" => 
                posX_depart_s <= to_integer(unsigned(posX_p_i)) + 4;
                posY_depart_s <= to_integer(unsigned(posY_p_i));
            -------------------------------------------
                
            -------------------------------------------
            -- deplacement a gauche                           
            WHEN "01" => 
                posX_depart_s <= to_integer(unsigned(posX_p_i));
                posY_depart_s <= to_integer(unsigned(posY_p_i)) + 2;
            -------------------------------------------
            
            -------------------------------------------
            -- deplacement vers le bas
            WHEN "10" => 
                posX_depart_s <= to_integer(unsigned(posX_p_i)) + 5;
                posY_depart_s <= to_integer(unsigned(posY_p_i)) + 8;
            -------------------------------------------
            
            -------------------------------------------
            -- deplacement a droite
            WHEN OTHERS => 
                posX_depart_s <= to_integer(unsigned(posX_p_i)) + 8;
                posY_depart_s <= to_integer(unsigned(posY_p_i)) + 2;
                             
        END CASE;
    END PROCESS;
    ----------------------------------------------


END Behavioral;

