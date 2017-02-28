library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
package local is
   --VGA
    Constant HMAX_c : integer := 1056;
	Constant VMAX_c : integer := 628;
    Constant HLINES_c : integer := 800;  
    Constant VLINES_c : integer := 600;
    Constant HFP_c : integer := 840;
    Constant HSP_c : integer := 968;
    Constant VFP_c : integer := 601;
    Constant VSP_c : integer := 605;
    Constant HP_PLAYER0_c : integer := 8;
    Constant HP_PLAYER1_c : integer := 8;
    
    --JOYSTICK
    Constant UPPER_SENSIBILITY_JOYSTICK_Y_c : integer := 690;             
    Constant LOWER_SENSIBILITY_JOYSTICK_Y_c : integer := 150;             
    
    Constant UPPER_SENSIBILITY_JOYSTICK_X_c : integer := 810;             
    Constant LOWER_SENSIBILITY_JOYSTICK_X_c : integer := 160;             
    
     
    -- player0
    Constant COUNT_MOV_PLAYER : integer := 100000;                       -- permet de choisir la vitesse de deplacement du joueur, defaut 100000
    Constant COUNT_MOV_BULLET : integer := 20000;                       -- permet de choisir la vitesse de deplacement d'une balle, defaut 50000
    Constant NESTOR_COLOR_c : STD_LOGIC_VECTOR(7 downto 0) := X"0D";
    Constant GRUDU_COLOR_c : STD_LOGIC_VECTOR(7 downto 0) := X"F0";

    
    -- end game
    Constant POSX_END_GAME_c : integer := 225;
    Constant POSY_END_GAME_c : integer := 200;
    Constant SIZEX_END_GAME_c : integer := 350;
    Constant SIZEY_END_GAME_c : integer := 233;
    Constant END_GAME_RAM_SIZE_c : integer := SIZEX_END_GAME_c * SIZEY_END_GAME_c;

    -- map collisions
    Constant COLLI_MAP_X : integer := 200;    -- Taille en X de la map des collisions
    Constant COLLI_MAP_Y : integer := 150;    -- Taille en Y de la map des collisions
    Constant COLLI_MAP_DIV_c : integer := 4;     -- facteur de division de la map de collisions
    
    -- balles
    Constant BULLET_SIZE_C : integer := 8;
    
    --BLINK
    Constant BLINK_SPEED_c : integer := 5000000;
    
    
    -- Banire en haut de l'cran
    -- couleur des vies
    Constant HP_GREEN_COLOR_c : STD_LOGIC_VECTOR(7 downto 0) := X"1C";
    Constant HP_RED_COLOR_c : STD_LOGIC_VECTOR(7 downto 0) := X"E0";
    
    -- position banire
    Constant POSY_BANIERE_c : integer := 5;     -- hauteur de la banire
    
    -- nestor_text
    Constant POSX_TEXT_NESTOR_c : integer := 50;
    Constant POSY_TEXT_NESTOR_c : integer := POSY_BANIERE_c;
    Constant SIZEX_TEXT_NESTOR_c : integer := 75;
    Constant SIZEY_TEXT_NESTOR_c : integer := 15;
    Constant NESTOR_TEXT_RAM_SIZE_c : integer := SIZEX_TEXT_NESTOR_c * SIZEY_TEXT_NESTOR_c;
    
    -- nestor_HP
    Constant POSX_HP_NESTOR_c : integer := 135;
    Constant POSY_HP_NESTOR_c : integer := POSY_BANIERE_c;
    Constant SIZEX_HP_NESTOR_c : integer := 200;
    Constant SIZEY_HP_NESTOR_c : integer := 15;
    
    -- grudu_HP
    Constant POSX_HP_GRUDU_c : integer := 470;
    Constant POSY_HP_GRUDU_c : integer := POSY_BANIERE_c;
    Constant SIZEX_HP_GRUDU_c : integer := 200;
    Constant SIZEY_HP_GRUDU_c : integer := 15;
    
    -- grudu_text
    Constant POSX_TEXT_GRUDU_c : integer := 680;
    Constant POSY_TEXT_GRUDU_c : integer := POSY_BANIERE_c;
    Constant SIZEX_TEXT_GRUDU_c : integer := 70;
    Constant SIZEY_TEXT_GRUDU_c : integer := 15;
    Constant GRUDU_TEXT_RAM_SIZE_c : integer := SIZEX_TEXT_GRUDU_c * SIZEY_TEXT_GRUDU_c;
    
    
    -- taille (largeur) d'une barre de vie
    Constant SIZEX_ONE_HP_BAR_c : integer := 25;
    
    
    -- Map pour l'affichage d'un mur ou du sol
    type affich_map_m is array(0 to 19, 0 to 14) of std_logic;
    constant affich : affich_map_m :=
    (('0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), 
    ('0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), 
    ('0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), 
    ('0', '1', '1', '1', '0', '0', '1', '1', '0', '1', '1', '0', '0', '1', '0'), 
    ('0', '1', '0', '0', '0', '0', '1', '0', '0', '0', '1', '0', '0', '0', '0'), 
    ('0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), 
    ('0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), 
    ('0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), 
    ('0', '0', '0', '0', '0', '0', '0', '1', '0', '1', '0', '0', '0', '0', '0'), 
    ('0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0'), 
    ('0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0'), 
    ('0', '0', '0', '0', '0', '0', '0', '1', '0', '1', '0', '0', '0', '0', '0'), 
    ('0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), 
    ('0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), 
    ('0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), 
    ('0', '1', '0', '0', '0', '0', '1', '0', '0', '0', '1', '0', '0', '0', '0'), 
    ('0', '1', '1', '1', '0', '0', '1', '1', '0', '1', '1', '0', '0', '1', '0'), 
    ('0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), 
    ('0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), 
    ('0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'));
    
    
    -- Balle ronde blanche
    type bullet_m is array(0 to 7, 0 to 7) of std_logic_vector(7 downto 0);
    constant BULLET_SPRITE_C : bullet_m :=
    ((x"00", x"00", x"00", x"FF", x"FF", x"00", x"00", x"00"), 
    (x"00", x"00", x"FF", x"FF", x"FF", x"FF", x"00", x"00"), 
    (x"00", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"00"), 
    (x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF"), 
    (x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF"), 
    (x"00", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"00"), 
    (x"00", x"00", x"FF", x"FF", x"FF", x"FF", x"00", x"00"), 
    (x"00", x"00", x"00", x"FF", x"FF", x"00", x"00", x"00"));
end local;
