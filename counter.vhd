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
USE IEEE.NUMERIC_STD.ALL;
USE work.local.ALL;

ENTITY counter IS
   PORT (
            game_clk_i  : IN STD_LOGIC;
            rst_i       : IN STD_LOGIC;
            blink_o  : OUT STD_LOGIC  
        );
END counter;

ARCHITECTURE Behavioral OF counter IS
SIGNAL blink_s : INTEGER RANGE 0 TO (BLINK_SPEED_c - 1);
begin
-- process pour le clignotement de 
    blink_count : process (game_clk_i, rst_i)
    begin
        if rst_i = '1' then
            blink_s <= 0;
        elsif RISING_EDGE(game_clk_i) then
            if (blink_s < (BLINK_SPEED_c - 1)) then
                blink_s <= blink_s + 1;
            else 
                blink_s <= 0;
            end if;
        end if;
    end process;
    
    blink_o <= '1' when (blink_s < (BLINK_SPEED_c/2)) else '0';
    
end architecture behavioral;
