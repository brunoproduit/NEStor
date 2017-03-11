----------------------------------------------------------------------------------
-- Company: HEIA-FR
-- Engineer: Joachim Burket & Bruno Produit
--
-- Create Date: 11:35:41 03/22/2016
-- Design Name:
-- Module Name: TOP_LEVEL - Behavioral
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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.local.all;
--================================================================================
--================================================================================
--ENTITE TOP-LEVEL
--================================================================================
--================================================================================
ENTITY TOP_LEVEL IS
    PORT (
        fpga_clk_i      : IN STD_LOGIC;
        rst_i           : IN STD_LOGIC;
        button_restart_game_i : IN STD_LOGIC;
        --shoot_p0_i : IN STD_LOGIC;
        --shoot_p1_i : IN STD_LOGIC;
        MISO_p1_i : in  STD_LOGIC;								-- Master In Slave Out, JA3
        SS_p1_o : out  STD_LOGIC;								-- Slave Select, Pin 1, Port JA
        MOSI_p1_o : out  STD_LOGIC;							-- Master Out Slave In, Pin 2, Port JA
        SCLK_p1_o : out  STD_LOGIC;							-- Serial Clock, Pin 4, Port JA
        MISO_p0_i : in  STD_LOGIC;								-- Master In Slave Out, JC3
        SS_p0_o : out  STD_LOGIC;								-- Slave Select, Pin 1, Port JC
        MOSI_p0_o : out  STD_LOGIC;							-- Master Out Slave In, Pin 2, Port JC
        SCLK_p0_o : out  STD_LOGIC;							-- Serial Clock, Pin 4, Port JC
        HS_o            : OUT STD_LOGIC;
        VS_o            : OUT STD_LOGIC;
        Red_o           : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        Green_o         : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        Blue_o          : OUT STD_LOGIC_VECTOR (1 DOWNTO 0)
    );
END TOP_LEVEL;


ARCHITECTURE Behavioral OF TOP_LEVEL IS

    --================================================================================
    --================================================================================
    -- COMPOSANTS
    --================================================================================
    --================================================================================
    
    -- =============================================================================
    --                              RAMs
    -- =============================================================================   
    component DCM1 is
        port
         (-- Clock in ports
          CLK_IN1           : in     std_logic;
          -- Clock out ports
          CLK_OUT1          : out    std_logic;
          CLK_OUT2          : out    std_logic;
          CLK_OUT3          : out    std_logic;
          CLK_OUT4          : out    std_logic;
          -- Status and control signals
          RESET             : in     std_logic;
          LOCKED            : out    std_logic
         );
        end component;
     ---------------------------------
     
     component mur_sprite_ram is
        port
        (
            CLKA            : in std_logic;
            ADDRA           : in std_logic_vector(10 downto 0);
            DOUTA           : out std_logic_vector(7 downto 0)
         );
      end component;
    ---------------------------------
    
    component sol_sprite_ram is
        port
        (
            CLKA            : in std_logic;
            ADDRA           : in std_logic_vector(10 downto 0);
            DOUTA           : out std_logic_vector(7 downto 0)
         );
      end component;
    -------------------------------
    
    component grudu_up_sprite_ram is
        port
        (
            CLKA            : in std_logic;
            ADDRA           : in std_logic_vector(9 downto 0);
            DOUTA           : out std_logic_vector(7 downto 0)
         );
      end component;
    ---------------------------------
    
    component grudu_left_sprite_ram is
        port
        (
            CLKA            : in std_logic;
            ADDRA           : in std_logic_vector(9 downto 0);
            DOUTA           : out std_logic_vector(7 downto 0)
         );
      end component;
    ---------------------------------
    
    component grudu_down_sprite_ram is
        port
        (
            CLKA            : in std_logic;
            ADDRA           : in std_logic_vector(9 downto 0);
            DOUTA           : out std_logic_vector(7 downto 0)
         );
      end component;
    ---------------------------------
    
    component grudu_right_sprite_ram is
        port
        (
            CLKA            : in std_logic;
            ADDRA           : in std_logic_vector(9 downto 0);
            DOUTA           : out std_logic_vector(7 downto 0)
         );
      end component;
    ---------------------------------
    
    component nestor_up_sprite_ram is
        port
        (
            CLKA            : in std_logic;
            ADDRA           : in std_logic_vector(9 downto 0);
            DOUTA           : out std_logic_vector(7 downto 0)
         );
      end component;
    ---------------------------------
    
    component nestor_left_sprite_ram is
        port
        (
            CLKA            : in std_logic;
            ADDRA           : in std_logic_vector(9 downto 0);
            DOUTA           : out std_logic_vector(7 downto 0)
         );
      end component;
    ---------------------------------
    
    component nestor_down_sprite_ram is
        port
        (
            CLKA            : in std_logic;
            ADDRA           : in std_logic_vector(9 downto 0);
            DOUTA           : out std_logic_vector(7 downto 0)
         );
      end component;
    ---------------------------------
    
    component nestor_right_sprite_ram is
        port
        (
            CLKA            : in std_logic;
            ADDRA           : in std_logic_vector(9 downto 0);
            DOUTA           : out std_logic_vector(7 downto 0)
         );
      end component;
    ---------------------------------
    
    component end_game_screen1_ram is
        port
        (
            CLKA            : in std_logic;
            ADDRA           : in std_logic_vector(16 downto 0);
            DOUTA           : out std_logic_vector(0 downto 0)
         );
      end component;
    ---------------------------------
    
    component end_game_screen0_ram is
        port
        (
            CLKA            : in std_logic;
            ADDRA           : in std_logic_vector(16 downto 0);
            DOUTA           : out std_logic_vector(0 downto 0)
         );
      end component;
    ---------------------------------
    
    component nestor_text_ram is
        port
        (
            CLKA            : in std_logic;
            ADDRA           : in std_logic_vector(10 downto 0);
            DOUTA           : out std_logic_vector(0 downto 0)
         );
      end component;
    ---------------------------------
    
    component grudu_text_ram is
        port
        (
            CLKA            : in std_logic;
            ADDRA           : in std_logic_vector(10 downto 0);
            DOUTA           : out std_logic_vector(0 downto 0)
         );
      end component;
    ---------------------------------
    
    
    component collision_map_ram is
        port
        (
            CLKA            : in std_logic;
            ADDRA           : in std_logic_vector(14 downto 0);
            DOUTA           : out std_logic_vector(0 downto 0);
            CLKB            : in std_logic;
            ADDRB           : in std_logic_vector(14 downto 0);
            DOUTB           : out std_logic_vector(0 downto 0)
         );
      end component;
    ---------------------------------


    -- =============================================================================
    --                              SPI
    -- =============================================================================
    
    component PmodJSTK

			 Port ( 
                      CLK : in  STD_LOGIC;
					  RST : in  STD_LOGIC;
					  sndRec : in  STD_LOGIC;
					  DIN : in  STD_LOGIC_VECTOR (7 downto 0);
					  MISO : in  STD_LOGIC;
					  SS : out  STD_LOGIC;
					  SCLK : out  STD_LOGIC;
					  MOSI : out  STD_LOGIC;
					  DOUT : inout  STD_LOGIC_VECTOR (39 downto 0)
			 );

    end component;
        
    -- **********************************************
    -- 				5Hz Clock Divider
    -- **********************************************
    component ClkDiv_5Hz

         Port ( CLK : in  STD_LOGIC;
                  RST : in  STD_LOGIC;
                  CLKOUT : inout STD_LOGIC
         );

    end component;
    
    -- =============================================================================
    --                              Jeu
    -- ============================================================================= 
    
    COMPONENT VGA IS
        PORT (
            pixel_clk_i, rst_i   : IN STD_LOGIC;
            HS_o, VS_o, blank_o  : OUT STD_LOGIC;
            hcount_o             : OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
            vcount_o             : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
        );
    END COMPONENT;
    ---------------------------------

    COMPONENT player0 IS
        PORT (
            game_clk_i    : IN STD_LOGIC;
            rst_i         : IN STD_LOGIC;
            mov_p0_i      : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            hit_i    : IN STD_LOGIC;
            
            -- position player1
            posX_p1_i    : in  std_logic_vector(7 downto 0);
            posY_p1_i    : in std_logic_vector(7 downto 0);
            
            -- fin du jeu
            end_game_i    : IN STD_LOGIC;
            
            -- collision map
            collision_map_data0_i : IN STD_LOGIC_VECTOR(0 DOWNTO 0); 
            collision_map_addr0_o : OUT STD_LOGIC_VECTOR (14 DOWNTO 0); 
            collision_map_data1_i : IN STD_LOGIC_VECTOR(0 DOWNTO 0); 
            collision_map_addr1_o : OUT STD_LOGIC_VECTOR (14 DOWNTO 0); 
            
            
            posX_p0_o     : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
            posY_p0_o     : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
            orient_p0_o   : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
            hp_p0_o       : OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
            dead_p0_o     : OUT STD_LOGIC -- joueur 0 indique qu'il est mort
        );
    END COMPONENT;
    ---------------------------------

    COMPONENT player1 IS
        PORT (
            game_clk_i    : IN STD_LOGIC;
            rst_i         : IN STD_LOGIC;
            mov_p1_i      : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            hit_i    : IN STD_LOGIC;
            
            -- position player0
            posX_p0_i    : in  std_logic_vector(7 downto 0);
            posY_p0_i    : in std_logic_vector(7 downto 0);
            
            -- fin du jeu
            end_game_i    : IN STD_LOGIC;
            
            -- collision map
            collision_map_data0_i : IN STD_LOGIC_VECTOR(0 downto 0); 
            collision_map_addr0_o : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
            collision_map_data1_i : IN STD_LOGIC_VECTOR(0 downto 0); 
            collision_map_addr1_o : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
            
            posX_p1_o     : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
            posY_p1_o     : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
            orient_p1_o   : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
            hp_p1_o       : OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
            dead_p1_o     : OUT STD_LOGIC -- joueur 1 indique qu'il est mort
        );
    END COMPONENT;
    ---------------------------------

    COMPONENT Bullet IS
        PORT (
            game_clk_i  : IN STD_LOGIC;
            rst_i       : IN STD_LOGIC;
            shoot_i     : IN STD_LOGIC;
            posX_p_i    : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            posY_p_i    : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            -- position du player adverse
            posX_adv_i : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            posY_adv_i : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            Orient_i    : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
            -- fin du jeu
            end_game_i    : IN STD_LOGIC;
            posX_o      : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
            posY_o      : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
            shot_o      : OUT STD_LOGIC;
            -- collision map
            collision_map_data_i : IN STD_LOGIC_VECTOR(0 downto 0);
            hit_o    : OUT STD_LOGIC;
            collision_map_addr_o : OUT STD_LOGIC_VECTOR (14 DOWNTO 0)
        );
    END COMPONENT;
    ---------------------------------
    
    COMPONENT bullet_ctrl is
        Port ( 
            game_clk_i, rst_i : in STD_LOGIC;
            button_shoot_i, shot_b0_i, shot_b1_i, shot_b2_i  : in STD_LOGIC;
            -- fin du jeu
            end_game_i    : IN STD_LOGIC;
            shoot_b0_o, shoot_b1_o, shoot_b2_o : out STD_LOGIC
        );
    END COMPONENT;
    ---------------------------------

    COMPONENT game_ctrl IS
        PORT (
            game_clk_i      : IN STD_LOGIC;
            rst_i           : IN STD_LOGIC;
            dead_p0_i       : IN STD_LOGIC;
            dead_p1_i       : IN STD_LOGIC;
            restart_game_i  : IN STD_LOGIC;
            end_game_o      : OUT STD_LOGIC;    -- indique aux autres composants que le jeux est termin
            p0_win_o        : OUT STD_LOGIC;    -- indique que le player 0  gagn
            p1_win_o        : OUT STD_LOGIC     -- indique que le player 1  gagn
        );
    END COMPONENT;
    ---------------------------------
 
    COMPONENT graphic IS 
        PORT (
        game_clk_i   : IN STD_LOGIC;
        rst_i         : IN STD_LOGIC;
 
        --VGA
        hcount_i      : IN STD_LOGIC_VECTOR (10 DOWNTO 0); -- de 0 a 1056 coordonees du pixel horizontale
        vcount_i      : IN STD_LOGIC_VECTOR (9 DOWNTO 0); -- de 0 a 628 coordonees du pixel verticales;
        blank_i       : IN STD_LOGIC;
        -- Player 0
        posX_p0_i     : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        posY_p0_i     : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        orient_p0_i   : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        hp_p0_i       : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
        
        -- Player 0 gagne
        end_p0_i     : IN STD_LOGIC;
 
 
        -- Balles player 0
        posX_b0_p0_i  : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        posY_b0_p0_i  : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        posX_b1_p0_i  : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        posY_b1_p0_i  : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        posX_b2_p0_i  : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        posY_b2_p0_i  : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
 
        shot_b0_p0_i  : IN STD_LOGIC; -- 1 si la balle est tire, 0 sinon
        shot_b1_p0_i  : IN STD_LOGIC;
        shot_b2_p0_i  : IN STD_LOGIC;
 

        -- Player 1
        posX_p1_i     : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        posY_p1_i     : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        orient_p1_i   : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        hp_p1_i       : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
 
 
        -- Player 1 gagne
        end_p1_i      : IN STD_LOGIC;
 
 
        -- Balles player 1
        posX_b0_p1_i  : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        posY_b0_p1_i  : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        posX_b1_p1_i  : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        posY_b1_p1_i  : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        posX_b2_p1_i  : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        posY_b2_p1_i  : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
 
        shot_b0_p1_i  : IN STD_LOGIC; -- 1 si la balle est tire, 0 sinon
        shot_b1_p1_i  : IN STD_LOGIC;
        shot_b2_p1_i  : IN STD_LOGIC;
        
        
        -- fin du jeu
        end_game_i    : IN STD_LOGIC;
        
        -- signal pour le clignotement
        blink_i       : IN STD_LOGIC;
 
         ---- RAMs ----
         -- draw map
        mur_sprite_data_i : IN STD_LOGIC_VECTOR(7 downto 0);    -- data in a l'adresse demande de la ram
        sol_sprite_data_i : IN STD_LOGIC_VECTOR(7 downto 0);    -- data in a l'adresse demande de la ram
        
        mur_sprite_addr_o : OUT STD_LOGIC_VECTOR(10 downto 0);  -- adresse out pour lire dans la ram
        sol_sprite_addr_o : OUT STD_LOGIC_VECTOR(10 downto 0);  -- adresse out pour lire dans la ram
        
        grudu_text_data_i : IN std_logic_vector(0 downto 0);
        grudu_text_addr_o : out std_logic_vector(10 downto 0);
        nestor_text_data_i : IN std_logic_vector(0 downto 0);
        nestor_text_addr_o : out std_logic_vector(10 downto 0);
        
        end_game_screen0_data_i : IN std_logic_vector(0 downto 0);
        end_game_screen0_addr_o : out std_logic_vector(16 downto 0);
        
        end_game_screen1_data_i : IN std_logic_vector(0 downto 0);
        end_game_screen1_addr_o : out std_logic_vector(16 downto 0);
        
        -- perso
        grudu_up_sprite_data_i :IN STD_LOGIC_VECTOR(7 downto 0);
        grudu_left_sprite_data_i :IN STD_LOGIC_VECTOR(7 downto 0);
        grudu_down_sprite_data_i :IN STD_LOGIC_VECTOR(7 downto 0);
        grudu_right_sprite_data_i :IN STD_LOGIC_VECTOR(7 downto 0);
        nestor_up_sprite_data_i :IN STD_LOGIC_VECTOR(7 downto 0);
        nestor_left_sprite_data_i :IN STD_LOGIC_VECTOR(7 downto 0);
        nestor_down_sprite_data_i :IN STD_LOGIC_VECTOR(7 downto 0);
        nestor_right_sprite_data_i :IN STD_LOGIC_VECTOR(7 downto 0);
        
        grudu_up_sprite_addr_o : OUT STD_LOGIC_VECTOR(9 downto 0); 
        grudu_left_sprite_addr_o : OUT STD_LOGIC_VECTOR(9 downto 0); 
        grudu_down_sprite_addr_o : OUT STD_LOGIC_VECTOR(9 downto 0); 
        grudu_right_sprite_addr_o : OUT STD_LOGIC_VECTOR(9 downto 0); 
        nestor_up_sprite_addr_o : OUT STD_LOGIC_VECTOR(9 downto 0); 
        nestor_left_sprite_addr_o : OUT STD_LOGIC_VECTOR(9 downto 0); 
        nestor_down_sprite_addr_o : OUT STD_LOGIC_VECTOR(9 downto 0); 
        nestor_right_sprite_addr_o : OUT STD_LOGIC_VECTOR(9 downto 0); 

        --RGB
        Red_o         : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        Green_o       : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        Blue_o        : OUT STD_LOGIC_VECTOR (1 DOWNTO 0)
        );
    END COMPONENT;
    ---------------------------------
    
    COMPONENT counter IS
    PORT (
            game_clk_i  : IN STD_LOGIC;
            rst_i       : IN STD_LOGIC;
            blink_o  : OUT STD_LOGIC  
        );
    END COMPONENT;
 
 
 
 
 
 
    --================================================================================
    --================================================================================
    -- SIGNAUX
    --================================================================================
    --================================================================================

    -- DCM
    SIGNAL spi_clk_s : STD_LOGIC;
    SIGNAL pixel_clk_s : STD_LOGIC;
    SIGNAL game_clk_s : STD_LOGIC;
    
    
    -- =============================================================================
    --                              RAMs
    -- ============================================================================= 
    -- mur_sprite_ram
    signal addr_mur_sprite_ram_s : std_logic_vector(10 downto 0);
    signal dout_mur_sprite_ram_s : std_logic_vector(7 downto 0);
    
    -- sol_sprite_ram
    signal addr_sol_sprite_ram_s : std_logic_vector(10 downto 0);
    signal dout_sol_sprite_ram_s : std_logic_vector(7 downto 0);
    
    -- end game screen ram
    signal addr_end_game_screen0_ram_s : std_logic_vector(16 downto 0);
    signal dout_end_game_screen0_ram_s : std_logic_vector(0 downto 0);
    signal addr_end_game_screen1_ram_s : std_logic_vector(16 downto 0);
    signal dout_end_game_screen1_ram_s : std_logic_vector(0 downto 0);
    
    -- nestor_text_ram
    signal addr_grudu_text_ram_s : std_logic_vector(10 downto 0);
    signal dout_grudu_text_ram_s : std_logic_vector(0 downto 0);
    
    -- grudu_text_ram
    signal addr_nestor_text_ram_s : std_logic_vector(10 downto 0);
    signal dout_nestor_text_ram_s : std_logic_vector(0 downto 0);
    
    -- grudu_sprite_ram
    signal addr_grudu_up_sprite_ram_s : std_logic_vector(9 downto 0);
    signal addr_grudu_left_sprite_ram_s : std_logic_vector(9 downto 0);
    signal addr_grudu_down_sprite_ram_s : std_logic_vector(9 downto 0);
    signal addr_grudu_right_sprite_ram_s : std_logic_vector(9 downto 0);
    
    signal dout_grudu_up_sprite_ram_s : std_logic_vector(7 downto 0);
    signal dout_grudu_left_sprite_ram_s : std_logic_vector(7 downto 0);
    signal dout_grudu_down_sprite_ram_s : std_logic_vector(7 downto 0);
    signal dout_grudu_right_sprite_ram_s : std_logic_vector(7 downto 0);
    
    -- nestor_sprite_ram
    signal addr_nestor_up_sprite_ram_s : std_logic_vector(9 downto 0);
    signal addr_nestor_left_sprite_ram_s : std_logic_vector(9 downto 0);
    signal addr_nestor_down_sprite_ram_s : std_logic_vector(9 downto 0);
    signal addr_nestor_right_sprite_ram_s : std_logic_vector(9 downto 0);
    
    signal dout_nestor_up_sprite_ram_s : std_logic_vector(7 downto 0);
    signal dout_nestor_left_sprite_ram_s : std_logic_vector(7 downto 0);
    signal dout_nestor_down_sprite_ram_s : std_logic_vector(7 downto 0);
    signal dout_nestor_right_sprite_ram_s : std_logic_vector(7 downto 0);
    
    ---- collision_map_rams ----
    -- joueur0
    signal addr_collision_map_ram0_p0_s : std_logic_vector(14 downto 0);
    signal dout_collision_map_ram0_p0_s : std_logic_vector(0 downto 0);
    signal addr_collision_map_ram1_p0_s : std_logic_vector(14 downto 0);
    signal dout_collision_map_ram1_p0_s : std_logic_vector(0 downto 0);
    -- joueur1
    signal addr_collision_map_ram0_p1_s : std_logic_vector(14 downto 0);
    signal dout_collision_map_ram0_p1_s : std_logic_vector(0 downto 0);
    signal addr_collision_map_ram1_p1_s : std_logic_vector(14 downto 0);
    signal dout_collision_map_ram1_p1_s : std_logic_vector(0 downto 0);
    
    -- pour les bullets on cree 3 ram: bullet0, bullet1 et bullet2. 
    -- chaque ram est lue par les deux joueurs pour leurs bullet respectives
    -- bullet0_p0
    signal addr_collision_map_ram_b0_p0_s : std_logic_vector(14 downto 0);
    signal dout_collision_map_ram_b0_p0_s : std_logic_vector(0 downto 0);
    -- bullet1_p0
    signal addr_collision_map_ram_b1_p0_s : std_logic_vector(14 downto 0);
    signal dout_collision_map_ram_b1_p0_s : std_logic_vector(0 downto 0);
    -- bullet2_p0
    signal addr_collision_map_ram_b2_p0_s : std_logic_vector(14 downto 0);
    signal dout_collision_map_ram_b2_p0_s : std_logic_vector(0 downto 0);
    -- bullet0_p1
    signal addr_collision_map_ram_b0_p1_s : std_logic_vector(14 downto 0);
    signal dout_collision_map_ram_b0_p1_s : std_logic_vector(0 downto 0);
    -- bullet1_p1
    signal addr_collision_map_ram_b1_p1_s : std_logic_vector(14 downto 0);
    signal dout_collision_map_ram_b1_p1_s : std_logic_vector(0 downto 0);
    -- bullet2_p1
    signal addr_collision_map_ram_b2_p1_s : std_logic_vector(14 downto 0);
    signal dout_collision_map_ram_b2_p1_s : std_logic_vector(0 downto 0);
    
    -- =============================================================================
    --                              SPI
    -- =============================================================================
    -- Signal to send/receive data to/from PmodJSTK
    signal sndRec_s : STD_LOGIC;
    
    --p1
    Signal posXData_p1_s : integer range 0 to 1024;
    Signal posYData_p1_s : integer range 0 to 1024;
    Signal DOUT_spi_p1_s : std_logic_vector(39 downto 0):= (others => '0');
    -- Holds data to be sent to PmodJSTK
    signal sndData_p1_s : STD_LOGIC_VECTOR(7 downto 0) := X"00";

    -- Signal indicating that SPI interface is busy
    signal BUSY_p1_s : STD_LOGIC := '0';


    -- Signal carrying output data that user selected
    signal posData_p1_s : STD_LOGIC_VECTOR(9 downto 0);
    
    --boutons de déplacement converti depuis le spi

    SIGNAL buttons_p1_s : STD_LOGIC_VECTOR(4 DOWNTO 0);
    
    
    --p0
    Signal posXData_p0_s : integer range 0 to 1024;
    Signal posYData_p0_s : integer range 0 to 1024;
    Signal DOUT_spi_p0_s : std_logic_vector(39 downto 0):= (others => '0');
    -- Holds data to be sent to PmodJSTK
    signal sndData_p0_s : STD_LOGIC_VECTOR(7 downto 0) := X"00";

    -- Signal indicating that SPI interface is busy
    signal BUSY_p0_s : STD_LOGIC := '0';

    -- Signal carrying output data that user selected
    signal posData_p0_s : STD_LOGIC_VECTOR(9 downto 0);
    
    --boutons de déplacement converti depuis le spi
    SIGNAL buttons_p0_s : STD_LOGIC_VECTOR(4 DOWNTO 0);
    
    
    
    -- =============================================================================
    --                              Player0
    -- ============================================================================= 
    -- player0
    SIGNAL orient_p0_s : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL hp_p0_s : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL posX_p0_s : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL posY_p0_s : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL dead_p0_s : STD_LOGIC;

    -- bullets of player 0
    SIGNAL posX_b0_p0_s, posY_b0_p0_s, posX_b1_p0_s, posY_b1_p0_s, posX_b2_p0_s, posY_b2_p0_s : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL shoot_b0_p0_s, shoot_b1_p0_s, shoot_b2_p0_s : STD_LOGIC;
    SIGNAL shot_b0_p0_s, shot_b1_p0_s, shot_b2_p0_s : STD_LOGIC;
    SIGNAL hit_p1_s : STD_LOGIC;
    SIGNAL hit_p1_b0_s : STD_LOGIC;
    SIGNAL hit_p1_b1_s : STD_LOGIC;
    SIGNAL hit_p1_b2_s : STD_LOGIC;
    
    
    -- =============================================================================
    --                              Player1
    -- ============================================================================= 
    -- player1
    SIGNAL orient_p1_s : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL hp_p1_s : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL posX_p1_s : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL posY_p1_s : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL dead_p1_s : STD_LOGIC;

    
    -- bullets of player 1
    SIGNAL posX_b0_p1_s, posY_b0_p1_s, posX_b1_p1_s, posY_b1_p1_s, posX_b2_p1_s, posY_b2_p1_s : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL shoot_b0_p1_s, shoot_b1_p1_s, shoot_b2_p1_s : STD_LOGIC;
    SIGNAL shot_b0_p1_s, shot_b1_p1_s, shot_b2_p1_s : STD_LOGIC;
    SIGNAL hit_p0_s : STD_LOGIC;
    SIGNAL hit_p0_b0_s : STD_LOGIC;
    SIGNAL hit_p0_b1_s : STD_LOGIC;
    SIGNAL hit_p0_b2_s : STD_LOGIC;

    -- fin du jeu
    SIGNAL end_game_s : STD_LOGIC;
    SIGNAL end_p0_s : STD_LOGIC;
    SIGNAL end_p1_s : STD_LOGIC;
    
    
    -- signal pour le clignotement
    SIGNAL blink_s : STD_LOGIC;
    
    -- VGA
    SIGNAL hcount_s : STD_LOGIC_VECTOR(10 DOWNTO 0);
    SIGNAL vcount_s : STD_LOGIC_VECTOR(9 DOWNTO 0);
    SIGNAL blank_s : STD_LOGIC;
    
    
    --=======================================================================

    BEGIN
            
        hit_p0_s <= (hit_p0_b0_s or hit_p0_b1_s or hit_p0_b2_s);
        hit_p1_s <= (hit_p1_b0_s or hit_p1_b1_s or hit_p1_b2_s);
    
        --spi
        
        
        --p0
        
        posXData_p0_s <= to_integer(unsigned((DOUT_spi_p0_s(9 downto 8) & DOUT_spi_p0_s(23 downto 16))));
		posYData_p0_s <= to_integer(unsigned((DOUT_spi_p0_s(25 downto 24) & DOUT_spi_p0_s(39 downto 32))));
        
        
        
        buttons_p0_s(4) <= '1' when (posYData_p0_s > UPPER_SENSIBILITY_JOYSTICK_Y_c) else '0'; --right
        buttons_p0_s(3) <= '1' when (posXData_p0_s < LOWER_SENSIBILITY_JOYSTICK_X_c) else '0'; --down
        buttons_p0_s(2) <= '1' when (posYData_p0_s < LOWER_SENSIBILITY_JOYSTICK_Y_c) else '0'; --left
        buttons_p0_s(1) <= '1' when (posXData_p0_s > UPPER_SENSIBILITY_JOYSTICK_X_c) else '0'; --up
        buttons_p0_s(0) <= DOUT_spi_p0_s(1);                        --shoot
        
        --p1
        posXData_p1_s <= to_integer(unsigned((DOUT_spi_p1_s(9 downto 8) & DOUT_spi_p1_s(23 downto 16))));
		posYData_p1_s <= to_integer(unsigned((DOUT_spi_p1_s(25 downto 24) & DOUT_spi_p1_s(39 downto 32))));
        
        buttons_p1_s(4) <= '1' when (posYData_p1_s > UPPER_SENSIBILITY_JOYSTICK_Y_c) else '0'; --right
        buttons_p1_s(3) <= '1' when (posXData_p1_s < LOWER_SENSIBILITY_JOYSTICK_X_c) else '0'; --down
        buttons_p1_s(2) <= '1' when (posYData_p1_s < LOWER_SENSIBILITY_JOYSTICK_Y_c) else '0'; --left
        buttons_p1_s(1) <= '1' when (posXData_p1_s > UPPER_SENSIBILITY_JOYSTICK_X_c) else '0'; --up
        buttons_p1_s(0) <= DOUT_spi_p1_s(1);    	                                         --shoot
        
        --================================================================================
        --================================================================================
        -- MAPPAGE
        --================================================================================
        --================================================================================
        DCM_descr : DCM1
        PORT MAP(
        clk_in1 => fpga_clk_i, 
        clk_out1 => pixel_clk_s, 
        clk_out2 => game_clk_s, 
        clk_out3 => spi_clk_s, 
        clk_out4 => open, 
        reset => rst_i, 
        locked => open
        );
        ---------------------------------
        
        -- =============================================================================
        --                              SPI
        -- ============================================================================= 
        
        spi_joystick_p0 : PmodJSTK 
        port map(
					CLK=> spi_clk_s,
					RST=> rst_i,
					sndRec=> sndRec_s,
					DIN=> sndData_p0_s,
                    SS=>   SS_p0_o,
                    MOSI=> MOSI_p0_o,
					MISO=> MISO_p0_i,
					SCLK=> SCLK_p0_o,
					DOUT=> DOUT_spi_p0_s
			);
        
        spi_joystick_p1 : PmodJSTK 
        port map(
					CLK=> spi_clk_s,
					RST=> rst_i,
					sndRec=> sndRec_s,
					DIN=> sndData_p1_s,
                    SS=>   SS_p1_o,
                    MOSI=> MOSI_p1_o,
					MISO=> MISO_p1_i,
					SCLK=> SCLK_p1_o,
					DOUT=> DOUT_spi_p1_s
			);
			
        -------------------------------------------------
        --  		 Send Receive Signal Generator
        -------------------------------------------------
        genSndRec : ClkDiv_5Hz 
        port map(
                CLK=>spi_clk_s,
                RST=>rst_i,
                CLKOUT=>sndRec_s
        );
        
        
        -- =============================================================================
        --                              RAMs
        -- ============================================================================= 
        mur_ram_descr : mur_sprite_ram
        port map(
        CLKA => pixel_clk_s,
        ADDRA => addr_mur_sprite_ram_s,
        DOUTA => dout_mur_sprite_ram_s
        );
        ---------------------------------
        
        sol_ram_descr : sol_sprite_ram
        port map(
        CLKA => pixel_clk_s,
        ADDRA => addr_sol_sprite_ram_s,
        DOUTA => dout_sol_sprite_ram_s
        );
        ---------------------------------
        
        grudu_up_ram_descr : grudu_up_sprite_ram
        port map(
        CLKA => pixel_clk_s,
        ADDRA => addr_grudu_up_sprite_ram_s,
        DOUTA => dout_grudu_up_sprite_ram_s
        );
        ---------------------------------
        
        grudu_left_ram_descr : grudu_left_sprite_ram
        port map(
        CLKA => pixel_clk_s,
        ADDRA => addr_grudu_left_sprite_ram_s,
        DOUTA => dout_grudu_left_sprite_ram_s
        );
        ---------------------------------
        
        grudu_down_ram_descr : grudu_down_sprite_ram
        port map(
        CLKA => pixel_clk_s,
        ADDRA => addr_grudu_down_sprite_ram_s,
        DOUTA => dout_grudu_down_sprite_ram_s
        );
        ---------------------------------
        
        grudu_right_ram_descr : grudu_right_sprite_ram
        port map(
        CLKA => pixel_clk_s,
        ADDRA => addr_grudu_right_sprite_ram_s,
        DOUTA => dout_grudu_right_sprite_ram_s
        );
        ---------------------------------
        
        nestor_up_ram_descr : nestor_up_sprite_ram
        port map(
        CLKA => pixel_clk_s,
        ADDRA => addr_nestor_up_sprite_ram_s,
        DOUTA => dout_nestor_up_sprite_ram_s
        );
        ---------------------------------
        
        nestor_left_ram_descr : nestor_left_sprite_ram
        port map(
        CLKA => pixel_clk_s,
        ADDRA => addr_nestor_left_sprite_ram_s,
        DOUTA => dout_nestor_left_sprite_ram_s
        );
        ---------------------------------
        
        nestor_down_ram_descr : nestor_down_sprite_ram
        port map(
        CLKA => pixel_clk_s,
        ADDRA => addr_nestor_down_sprite_ram_s,
        DOUTA => dout_nestor_down_sprite_ram_s
        );
        ---------------------------------
        
        nestor_right_ram_descr : nestor_right_sprite_ram
        port map(
        CLKA => pixel_clk_s,
        ADDRA => addr_nestor_right_sprite_ram_s,
        DOUTA => dout_nestor_right_sprite_ram_s
        );
        ---------------------------------
        
        nestor_text_ram_descr : nestor_text_ram
        port map(
        CLKA => pixel_clk_s,
        ADDRA => addr_nestor_text_ram_s,
        DOUTA => dout_nestor_text_ram_s
        );
        ---------------------------------
        
        grudu_text_ram_descr : grudu_text_ram
        port map(
        CLKA => pixel_clk_s,
        ADDRA => addr_grudu_text_ram_s,
        DOUTA => dout_grudu_text_ram_s
        );
        ---------------------------------
        
        end_game_screen0_descr : end_game_screen0_ram
        port map(
        CLKA => pixel_clk_s,
        ADDRA => addr_end_game_screen0_ram_s,
        DOUTA => dout_end_game_screen0_ram_s
        );
        ---------------------------------
        
        end_game_screen1_descr : end_game_screen1_ram
        port map(
        CLKA => pixel_clk_s,
        ADDRA => addr_end_game_screen1_ram_s,
        DOUTA => dout_end_game_screen1_ram_s
        );
        ---------------------------------
        
        collision_map_ram_player0 : collision_map_ram
        port map(
        CLKA => pixel_clk_s,
        CLKB => pixel_clk_s,
        ADDRA => addr_collision_map_ram0_p0_s,
        ADDRB => addr_collision_map_ram1_p0_s,
        DOUTA => dout_collision_map_ram0_p0_s,
        DOUTB => dout_collision_map_ram1_p0_s
        );
        ---------------------------------        
        
        collision_map_ram_player1 : collision_map_ram
        port map(
        CLKA => pixel_clk_s,
        CLKB => pixel_clk_s,
        ADDRA => addr_collision_map_ram0_p1_s,
        ADDRB => addr_collision_map_ram1_p1_s,
        DOUTA => dout_collision_map_ram0_p1_s,
        DOUTB => dout_collision_map_ram1_p1_s
        );
        ---------------------------------      
        
        collision_map_ram_bullet0 : collision_map_ram
        port map(
        CLKA => pixel_clk_s,
        CLKB => pixel_clk_s,
        ADDRA => addr_collision_map_ram_b0_p0_s,
        ADDRB => addr_collision_map_ram_b0_p1_s,
        DOUTA => dout_collision_map_ram_b0_p0_s,
        DOUTB => dout_collision_map_ram_b0_p1_s
        );
        ---------------------------------     

        collision_map_ram_bullet1 : collision_map_ram
        port map(
        CLKA => pixel_clk_s,
        CLKB => pixel_clk_s,
        ADDRA => addr_collision_map_ram_b1_p0_s,
        ADDRB => addr_collision_map_ram_b1_p1_s,
        DOUTA => dout_collision_map_ram_b1_p0_s,
        DOUTB => dout_collision_map_ram_b1_p1_s
        );
        ---------------------------------   

        collision_map_ram_bullet2 : collision_map_ram
        port map(
        CLKA => pixel_clk_s,
        CLKB => pixel_clk_s,
        ADDRA => addr_collision_map_ram_b2_p0_s,
        ADDRB => addr_collision_map_ram_b2_p1_s,
        DOUTA => dout_collision_map_ram_b2_p0_s,
        DOUTB => dout_collision_map_ram_b2_p1_s
        );
        ---------------------------------         
        
        VGA_controller : VGA
        PORT MAP(
        rst_i => rst_i, 
        pixel_clk_i => pixel_clk_s, 
        hcount_o => hcount_s, 
        vcount_o => vcount_s, 
        blank_o => blank_s, 
        HS_o => HS_o, 
        VS_o => VS_o
        );
        ---------------------------------
        
        p0 : player0
        PORT MAP(
        game_clk_i => game_clk_s, 
        rst_i => rst_i, 
        mov_p0_i => buttons_p0_s(4 DOWNTO 1), 
        hit_i => hit_p0_s, 
        posX_p1_i => posX_p1_s,   
        posY_p1_i => posX_p1_s,
        end_game_i => end_game_s,
        collision_map_data0_i => dout_collision_map_ram0_p0_s,
        collision_map_addr0_o => addr_collision_map_ram0_p0_s,
        collision_map_data1_i => dout_collision_map_ram1_p0_s,
        collision_map_addr1_o => addr_collision_map_ram1_p0_s,
        posX_p0_o => posX_p0_s, 
        posY_p0_o => posY_p0_s, 
        orient_p0_o => orient_p0_s,
        hp_p0_o => hp_p0_s,
        dead_p0_o => dead_p0_s
        );
        ---------------------------------
        
        p1 : player1
        PORT MAP(
        game_clk_i => game_clk_s, 
        rst_i => rst_i, 
        mov_p1_i => buttons_p1_s(4 DOWNTO 1), 
        hit_i => hit_p1_s, 
        posX_p0_i => posX_p0_s,   
        posY_p0_i => posX_p0_s,
        end_game_i => end_game_s,
        collision_map_data0_i => dout_collision_map_ram0_p1_s,
        collision_map_addr0_o => addr_collision_map_ram0_p1_s,
        collision_map_data1_i => dout_collision_map_ram1_p1_s,
        collision_map_addr1_o => addr_collision_map_ram1_p1_s,
        posX_p1_o => posX_p1_s, 
        posY_p1_o => posY_p1_s, 
        orient_p1_o => orient_p1_s,
        hp_p1_o => hp_p1_s,
        dead_p1_o => dead_p1_s
        );
        ---------------------------------
        
        Bullet0_p0 : Bullet
        PORT MAP(
        game_clk_i => game_clk_s, 
        rst_i => rst_i, 
        shoot_i => shoot_b0_p0_s, 
        posX_p_i => posX_p0_s, 
        posY_p_i => posY_p0_s,
        posX_adv_i => posX_p1_s,
        posY_adv_i => posY_p1_s,
        Orient_i => Orient_p0_s, 
        end_game_i => end_game_s,
        collision_map_data_i => dout_collision_map_ram_b0_p0_s,
        collision_map_addr_o => addr_collision_map_ram_b0_p0_s,
        posX_o => posX_b0_p0_s, 
        posY_o => posY_b0_p0_s, 
        shot_o => shot_b0_p0_s,
        hit_o => hit_p1_b0_s
        );
        ---------------------------------
        
        Bullet1_p0 : Bullet
        PORT MAP(
        game_clk_i => game_clk_s, 
        rst_i => rst_i, 
        shoot_i => shoot_b1_p0_s, 
        posX_p_i => posX_p0_s, 
        posY_p_i => posY_p0_s,
        posX_adv_i => posX_p1_s,
        posY_adv_i => posY_p1_s,
        Orient_i => Orient_p0_s,
        end_game_i => end_game_s,
        collision_map_data_i => dout_collision_map_ram_b1_p0_s,
        collision_map_addr_o => addr_collision_map_ram_b1_p0_s,         
        posX_o => posX_b1_p0_s, 
        posY_o => posY_b1_p0_s, 
        shot_o => shot_b1_p0_s,
        hit_o => hit_p1_b1_s
        );
        ---------------------------------
        
        Bullet2_p0 : Bullet
        PORT MAP(
        game_clk_i => game_clk_s, 
        rst_i => rst_i, 
        shoot_i => shoot_b2_p0_s, 
        posX_p_i => posX_p0_s, 
        posY_p_i => posY_p0_s,
        posX_adv_i => posX_p1_s,
        posY_adv_i => posY_p1_s,        
        Orient_i => Orient_p0_s,
        end_game_i => end_game_s,
        collision_map_data_i => dout_collision_map_ram_b2_p0_s,
        collision_map_addr_o => addr_collision_map_ram_b2_p0_s,        
        posX_o => posX_b2_p0_s, 
        posY_o => posY_b2_p0_s, 
        shot_o => shot_b2_p0_s,
        hit_o => hit_p1_b2_s
        );
        ---------------------------------
        
        Bullet0_p1 : Bullet
        PORT MAP(
        game_clk_i => game_clk_s, 
        rst_i => rst_i, 
        shoot_i => shoot_b0_p1_s, 
        posX_p_i => posX_p1_s, 
        posY_p_i => posY_p1_s,
        posX_adv_i => posX_p0_s,
        posY_adv_i => posY_p0_s,        
        Orient_i => Orient_p1_s,
        end_game_i => end_game_s,
        collision_map_data_i => dout_collision_map_ram_b0_p1_s,
        collision_map_addr_o => addr_collision_map_ram_b0_p1_s,         
        posX_o => posX_b0_p1_s, 
        posY_o => posY_b0_p1_s, 
        shot_o => shot_b0_p1_s,
        hit_o => hit_p0_b0_s
        );
        ---------------------------------
        
        Bullet1_p1 : Bullet
        PORT MAP(
        game_clk_i => game_clk_s, 
        rst_i => rst_i, 
        shoot_i => shoot_b1_p1_s, 
        posX_p_i => posX_p1_s, 
        posY_p_i => posY_p1_s,
        posX_adv_i => posX_p0_s,
        posY_adv_i => posY_p0_s,        
        Orient_i => Orient_p1_s,
        end_game_i => end_game_s,
        collision_map_data_i => dout_collision_map_ram_b1_p1_s,
        collision_map_addr_o => addr_collision_map_ram_b1_p1_s,
        posX_o => posX_b1_p1_s, 
        posY_o => posY_b1_p1_s, 
        shot_o => shot_b1_p1_s,
        hit_o => hit_p0_b1_s
        );
        ---------------------------------
        
        Bullet2_p1 : Bullet
        PORT MAP(
        game_clk_i => game_clk_s, 
        rst_i => rst_i, 
        shoot_i => shoot_b2_p1_s, 
        posX_p_i => posX_p1_s, 
        posY_p_i => posY_p1_s,
        posX_adv_i => posX_p0_s,
        posY_adv_i => posY_p0_s,        
        Orient_i => Orient_p1_s,
        end_game_i => end_game_s,
        collision_map_data_i => dout_collision_map_ram_b2_p1_s,
        collision_map_addr_o => addr_collision_map_ram_b2_p1_s,
        posX_o => posX_b2_p1_s, 
        posY_o => posY_b2_p1_s, 
        shot_o => shot_b2_p1_s,
        hit_o => hit_p0_b2_s
        );
        ---------------------------------
        
        bullet_ctrl_p0 : bullet_ctrl
        PORT MAP(
        game_clk_i => game_clk_s, 
        rst_i => rst_i, 
        button_shoot_i => buttons_p0_s(0),
        shot_b0_i => shot_b0_p0_s,
        shot_b1_i => shot_b1_p0_s,
        shot_b2_i => shot_b2_p0_s,
        end_game_i => end_game_s,
        shoot_b0_o => shoot_b0_p0_s,
        shoot_b1_o => shoot_b1_p0_s,
        shoot_b2_o => shoot_b2_p0_s
        );
        ---------------------------------
                
         bullet_ctrl_p1 : bullet_ctrl
         PORT MAP(
         game_clk_i => game_clk_s, 
         rst_i => rst_i, 
         button_shoot_i => buttons_p1_s(0),
         shot_b0_i => shot_b0_p1_s,
         shot_b1_i => shot_b1_p1_s,
         shot_b2_i => shot_b2_p1_s,
         end_game_i => end_game_s,
         shoot_b0_o => shoot_b0_p1_s,
         shoot_b1_o => shoot_b1_p1_s,
         shoot_b2_o => shoot_b2_p1_s
         );
        ---------------------------------
        
        CTRL : game_ctrl
        PORT MAP(
        game_clk_i => game_clk_s, 
        rst_i => rst_i, 
        dead_p0_i => dead_p0_s, 
        dead_p1_i => dead_p1_s, 
        restart_game_i => button_restart_game_i,
        end_game_o => End_game_s,
        p0_win_o => end_p0_s,
        p1_win_o => end_p1_s
        );
        ---------------------------------
        
        counter1 : counter
        PORT MAP(
        game_clk_i => game_clk_s,
        rst_i   => rst_i,
        blink_o => blink_s
        );
        ---------------------------------
        
        
        Graphic1 : graphic
        PORT MAP(
        game_clk_i => game_clk_s,
        rst_i => rst_i, 
        
        hcount_i => hcount_s, 
        vcount_i => vcount_s, 
        blank_i => blank_s, 
        
        posX_p0_i => posX_p0_s, 
        posY_p0_i => posY_p0_s, 
        orient_p0_i => orient_p0_s, 
        hp_p0_i => hp_p0_s, 
        end_p0_i => end_p0_s,
        
        posX_b0_p0_i => posX_b0_p0_s, 
        posY_b0_p0_i => posY_b0_p0_s, 
        posX_b1_p0_i => posX_b1_p0_s, 
        posY_b1_p0_i => posY_b1_p0_s, 
        posX_b2_p0_i => posX_b2_p0_s, 
        posY_b2_p0_i => posY_b2_p0_s, 
        shot_b0_p0_i => shot_b0_p0_s, 
        shot_b1_p0_i => shot_b1_p0_s, 
        shot_b2_p0_i => shot_b2_p0_s, 
        
        posX_p1_i => posX_p1_s, 
        posY_p1_i => posY_p1_s, 
        orient_p1_i => orient_p1_s, 
        hp_p1_i => hp_p1_s, 
        end_p1_i => end_p1_s,
        
        -- fin du jeu
        end_game_i => end_game_s,
        
        -- clignotement
        blink_i => blink_s,
        
        ---- Sprites_rams ----
        -- mur_sprite_ram
        mur_sprite_data_i => dout_mur_sprite_ram_s,
        mur_sprite_addr_o => addr_mur_sprite_ram_s,
    
        -- sol_sprite_ram
        sol_sprite_data_i => dout_sol_sprite_ram_s,
        sol_sprite_addr_o => addr_sol_sprite_ram_s,
        
        -- end_game_screen0
        end_game_screen0_data_i => dout_end_game_screen0_ram_s,
        end_game_screen0_addr_o => addr_end_game_screen0_ram_s,
        
        -- end_game_screen1
        end_game_screen1_data_i => dout_end_game_screen1_ram_s,
        end_game_screen1_addr_o => addr_end_game_screen1_ram_s,
        
        -- nestor_text
        nestor_text_data_i => dout_nestor_text_ram_s,        
        nestor_text_addr_o => addr_nestor_text_ram_s,
        
        -- grudu_text
        grudu_text_data_i => dout_grudu_text_ram_s,        
        grudu_text_addr_o => addr_grudu_text_ram_s,
    
        -- grudu_sprite
        grudu_up_sprite_data_i => dout_grudu_up_sprite_ram_s,
        grudu_up_sprite_addr_o => addr_grudu_up_sprite_ram_s,
        grudu_left_sprite_data_i => dout_grudu_left_sprite_ram_s,
        grudu_left_sprite_addr_o => addr_grudu_left_sprite_ram_s,
        grudu_down_sprite_data_i => dout_grudu_down_sprite_ram_s,
        grudu_down_sprite_addr_o => addr_grudu_down_sprite_ram_s,
        grudu_right_sprite_data_i => dout_grudu_right_sprite_ram_s,
        grudu_right_sprite_addr_o => addr_grudu_right_sprite_ram_s,
        
        -- nestor_sprite
        nestor_up_sprite_data_i => dout_nestor_up_sprite_ram_s,
        nestor_up_sprite_addr_o => addr_nestor_up_sprite_ram_s,
        nestor_left_sprite_data_i => dout_nestor_left_sprite_ram_s,
        nestor_left_sprite_addr_o => addr_nestor_left_sprite_ram_s,
        nestor_down_sprite_data_i => dout_nestor_down_sprite_ram_s,
        nestor_down_sprite_addr_o => addr_nestor_down_sprite_ram_s,
        nestor_right_sprite_data_i => dout_nestor_right_sprite_ram_s,
        nestor_right_sprite_addr_o => addr_nestor_right_sprite_ram_s,

        -- bullets positions
        posX_b0_p1_i => posX_b0_p1_s, 
        posY_b0_p1_i => posY_b0_p1_s, 
        posX_b1_p1_i => posX_b1_p1_s, 
        posY_b1_p1_i => posY_b1_p1_s, 
        posX_b2_p1_i => posX_b2_p1_s, 
        posY_b2_p1_i => posY_b2_p1_s, 
        shot_b0_p1_i => shot_b0_p1_s, 
        shot_b1_p1_i => shot_b1_p1_s, 
        shot_b2_p1_i => shot_b2_p1_s, 
        
        -- RGB
        Red_o => Red_o, 
        Green_o => Green_o, 
        Blue_o => Blue_o
        );
        ---------------------------------
    END Behavioral;

