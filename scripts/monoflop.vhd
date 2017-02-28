----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:43:54 04/20/2015 
-- Design Name: 
-- Module Name:    monoflop - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity monoflop is
    Port ( T, clk, rst : in  STD_LOGIC;           
           S : out  STD_LOGIC);
end monoflop;

architecture Behavioral of monoflop is
type etat is (depart, impulsion, attendre);
signal etat_present, etat_futur : etat;
begin

S<='1' when etat_present=impulsion else '0';

    registre: process(clk, rst)
            begin
                if rst = '1' then
                etat_present <= depart;
                elsif rising_edge(clk) then
                etat_present <= etat_futur;
                end if;
            end process registre;

    combinatoire: process(etat_present)
            begin
                case etat_present is 
                when depart => 
                    if T='0' then
                        etat_futur<=depart;
                    else 
                        etat_futur<=impulsion;
                    end if;
                when impulsion =>
                   if T='0' then
                        etat_futur<=depart;
                    else 
                        etat_futur<=attendre;
                    end if;
                when attendre =>
                   if T='0' then
                        etat_futur<=depart;
                    else 
                        etat_futur<=attendre;
                    end if;
                when others =>
                    etat_futur<=depart;
                end case;
            end process combinatoire;
end Behavioral;

