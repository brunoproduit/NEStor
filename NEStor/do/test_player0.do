force -freeze sim:/player0/game_clk_i 1 0, 0 {50 ps} -r 100
force -freeze sim:/player0/rst_i 1 0
run 7000000

force -freeze sim:/player0/rst_i 0 0
run 7000000

# right
force -freeze sim:/player0/mov_p0_i 1000 0
run 7000000
run 7000000

# down
force -freeze sim:/player0/mov_p0_i 0100 0
run 7000000
run 7000000

# left
force -freeze sim:/player0/mov_p0_i 0010 0
run 7000000
run 7000000

# up
force -freeze sim:/player0/mov_p0_i 0001 0
run 7000000
run 7000000