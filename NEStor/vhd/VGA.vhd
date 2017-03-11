----------------------------------------------------------------------------------
-- Company: HEIA-FR
-- Engineer: Bruno Produit & Joachim Burket
-- 
-- Create Date:    08:30:23 02/26/2016 
-- Design Name: 
-- Module Name:    VGA - Behavioral 
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
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.local.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity VGA is
    Port ( pixel_clk_i : in  STD_LOGIC;
           rst_i : in  STD_LOGIC;
           HS_o : out  STD_LOGIC;
           VS_o : out  STD_LOGIC;
           hcount_o : out  STD_LOGIC_VECTOR (10 downto 0); -- de 0 a 1056 coordonees horizontale
           vcount_o : out  STD_LOGIC_VECTOR (9 downto 0); -- de 0 a 628 coordonees verticales;
           blank_o : out  STD_LOGIC);
end VGA;

architecture Behavioral of VGA is

signal hcounter_s : integer range 0 to HMAX_c;
signal vcounter_s : integer range 0 to VMAX_c;
signal En_next_line_s : STD_LOGIC;

signal blank_s : STD_LOGIC;
signal hs_s : STD_LOGIC;
signal vs_s : STD_LOGIC;	

begin


--------------------------------------------
FF_HS: process (pixel_clk_i, rst_i)
begin
 if (rst_i='1') then
  HS_o <= '0';  --default state on reset.
elsif rising_edge(pixel_clk_i) then
  HS_o <= hs_s;   --state change.
end if;
end process FF_HS;
--------------------------------------------


--------------------------------------------
FF_VS: process (pixel_clk_i, rst_i)
begin
 if (rst_i='1') then
  VS_o <= '0';  --default state on reset.
elsif rising_edge(pixel_clk_i) then
  VS_o <= vs_s;   --state change.
end if;
end process FF_VS;
--------------------------------------------


--------------------------------------------
FF_blank: process (pixel_clk_i, rst_i)
begin
 if (rst_i='1') then
  blank_o <= '0';  --default state on reset.
elsif rising_edge(pixel_clk_i) then
  blank_o <= blank_s;   --state change.
end if;
end process FF_blank;
--------------------------------------------



--------------------------------------------
pixel_counter: process (pixel_clk_i, rst_i)
begin
if rst_i= '1' then
	hcounter_s <= 0;
elsif rising_edge(pixel_clk_i) then
    if hcounter_s = HMAX_c then
       hcounter_s <= 0;
    else
       hcounter_s <= hcounter_s + 1 ;
    end if;
end if;     
end process pixel_counter;
--------------------------------------------



--------------------------------------------
line_counter: process (pixel_clk_i, rst_i)
begin
if rst_i= '1' then
	vcounter_s <= 0;
elsif rising_edge(pixel_clk_i) then
    if En_next_line_s = '1' then
        if vcounter_s = VMAX_c then
           vcounter_s <= 0;
        else
           vcounter_s <= vcounter_s + 1 ;
        end if;
    end if;
end if;     
end process line_counter;
--------------------------------------------


blank_s <= '0' when (hcounter_s < HLINES_c AND vcounter_s < VLINES_c) else '1';
hs_s <= '1' when (hcounter_s >= HFP_c AND hcounter_s < HSP_c) else '0';
vs_s <= '1' when (vcounter_s >= VFP_c AND vcounter_s < VSP_c) else '0';	
en_next_line_s <= '1' when (hcounter_s = HMAX_c) else '0';

hcount_o <= std_logic_vector(to_unsigned(hcounter_s, 11));
vcount_o <= std_logic_vector(to_unsigned(vcounter_s, 10));

end Behavioral;

