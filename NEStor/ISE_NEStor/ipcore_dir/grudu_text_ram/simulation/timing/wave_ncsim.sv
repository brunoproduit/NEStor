
 
 
 




window new WaveWindow  -name  "Waves for BMG Example Design"
waveform  using  "Waves for BMG Example Design"


      waveform add -signals /grudu_text_ram_tb/status
      waveform add -signals /grudu_text_ram_tb/grudu_text_ram_synth_inst/bmg_port/CLKA
      waveform add -signals /grudu_text_ram_tb/grudu_text_ram_synth_inst/bmg_port/ADDRA
      waveform add -signals /grudu_text_ram_tb/grudu_text_ram_synth_inst/bmg_port/DOUTA
console submit -using simulator -wait no "run"
