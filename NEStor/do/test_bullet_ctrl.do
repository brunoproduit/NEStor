force -freeze sim:/bullet_ctrl/button_shoot_i 0 0
force -freeze sim:/bullet_ctrl/shot_b0_i 0 0
force -freeze sim:/bullet_ctrl/shot_b1_i 0 0
force -freeze sim:/bullet_ctrl/shot_b2_i 0 0
force -freeze sim:/bullet_ctrl/game_clk_i 0 0
force -freeze sim:/bullet_ctrl/rst_i 0 0
force -freeze sim:/bullet_ctrl/game_clk_i 1 0, 0 {50 ps} -r 100
run
run
run
force -freeze sim:/bullet_ctrl/rst_i 1 0
force -freeze sim:/bullet_ctrl/rst_i 1 0
run
run
run
run
run
run
force -freeze sim:/bullet_ctrl/rst_i 0 0
run
run
run
run
run
force -freeze sim:/bullet_ctrl/button_shoot_i 1 0
run
run
run
run
run
run
run
force -freeze sim:/bullet_ctrl/button_shoot_i 0 0
noforce sim:/bullet_ctrl/shot_b0_i
force -freeze sim:/bullet_ctrl/shot_b0_i 1 0
run
run
run
run
force -freeze sim:/bullet_ctrl/button_shoot_i 1 0
run
run
run
run
run
force -freeze sim:/bullet_ctrl/button_shoot_i 0 0
force -freeze sim:/bullet_ctrl/shot_b1_i 1 0
run
run
run
force -freeze sim:/bullet_ctrl/button_shoot_i 1 0
run
run
run
run
run
run
force -freeze sim:/bullet_ctrl/button_shoot_i 0 0

force -freeze sim:/bullet_ctrl/shot_b2_i 1 0
run
run
run
run
force -freeze sim:/bullet_ctrl/button_shoot_i 1 0
run
run
run
run
run
run
force -freeze sim:/bullet_ctrl/button_shoot_i 0 0
run
run
run
run
force -freeze sim:/bullet_ctrl/shot_b1_i 0 0
force -freeze sim:/bullet_ctrl/button_shoot_i 1 0
run
run
run
run
run
run