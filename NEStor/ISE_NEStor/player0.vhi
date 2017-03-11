
-- VHDL Instantiation Created from source file player0.vhd -- 20:06:45 06/22/2016
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT player0
	PORT(
		game_clk_i : IN std_logic;
		rst_i : IN std_logic;
		mov_p0_i : IN std_logic_vector(3 downto 0);
		posX_p1_i : IN std_logic_vector(7 downto 0);
		posY_p1_i : IN std_logic_vector(7 downto 0);
		hit_i : IN std_logic;
		end_game_i : IN std_logic;
		collision_map_data0_i : IN std_logic_vector(0 to 0);
		collision_map_data1_i : IN std_logic_vector(0 to 0);          
		collision_map_addr0_o : OUT std_logic_vector(14 downto 0);
		collision_map_addr1_o : OUT std_logic_vector(14 downto 0);
		posX_p0_o : OUT std_logic_vector(7 downto 0);
		posY_p0_o : OUT std_logic_vector(7 downto 0);
		orient_p0_o : OUT std_logic_vector(1 downto 0);
		hp_p0_o : OUT std_logic_vector(4 downto 0);
		dead_p0_o : OUT std_logic
		);
	END COMPONENT;

	Inst_player0: player0 PORT MAP(
		game_clk_i => ,
		rst_i => ,
		mov_p0_i => ,
		posX_p1_i => ,
		posY_p1_i => ,
		hit_i => ,
		end_game_i => ,
		collision_map_data0_i => ,
		collision_map_addr0_o => ,
		collision_map_data1_i => ,
		collision_map_addr1_o => ,
		posX_p0_o => ,
		posY_p0_o => ,
		orient_p0_o => ,
		hp_p0_o => ,
		dead_p0_o => 
	);


