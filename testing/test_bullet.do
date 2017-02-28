force -freeze sim:/bullet/game_clk_i 1 0, 0 {50 ps} -r 100
force -freeze sim:/bullet/rst_i 1 0
force -freeze sim:/bullet/shoot_i 0 0
force -freeze sim:/bullet/posx_p_i 00000110 0
force -freeze sim:/bullet/posy_p_i 00000110 0
force -freeze sim:/bullet/orient_i 11 0
run
run
