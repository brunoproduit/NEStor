

 
 
 




window new WaveWindow  -name  "Waves for BMG Example Design"
waveform  using  "Waves for BMG Example Design"

      waveform add -signals /nestor_left_sprite_ram_tb/status
      waveform add -signals /nestor_left_sprite_ram_tb/nestor_left_sprite_ram_synth_inst/bmg_port/CLKA
      waveform add -signals /nestor_left_sprite_ram_tb/nestor_left_sprite_ram_synth_inst/bmg_port/ADDRA
      waveform add -signals /nestor_left_sprite_ram_tb/nestor_left_sprite_ram_synth_inst/bmg_port/DOUTA

console submit -using simulator -wait no "run"
