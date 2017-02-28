#!/usr/bin/python3
# -*- coding: utf-8 -*-


"""

jpg_to_binary_array.py: This script convert any image into a 8bit RBG format displayed in hex (for exemple : 0xff) 
The output is to be declared as an array in VHDL in order to send it to a VGA output

Standard usage:       python3 jpg_to_binary_array.py image.jpg 
With image scaling:   python3 jpg_to_binary_array.py image.jpg 32 32

The output file is named <yourimagename>.txt

"""


__author__  = "Bruno Produit"


import sys
import PIL
from PIL import Image

im = Image.open(sys.argv[1]) 	#Can be in different formats

# rescale if asked
if len(sys.argv) > 2:
	size = (int(sys.argv[2]), int(sys.argv[3]))
	im = im .resize(size, Image.ANTIALIAS)

# load image and create output file with 4 last characters stripped
output = open("".join([sys.argv[1][:-4], ".txt"]) , 'w')
pix = im.load()

#print (im.size) #Get the width and hight of the image for iterating over
#print (pix[5,5]) #Get the RGBA Value of the a pixel of an image

output.write("type memory_m is array(0 to ")
output.write(str(im.size[0]-1))
output.write(", 0 to ")
output.write(str(im.size[1]-1))
output.write(") of std_logic_vector(7 downto 0);\nconstant mem : memory_m :=\n(")
output.write("(")

# iterate over image
for i in range(0, im.size[0]):
  if (i != 0):
     output.write("), \n(") 
  for j in range(0, im.size[1]):

      # take out and convert each pixel to it's binary value	
      Blue =  bin(round(pix[i,j][0] >> 5))[2:].zfill(3) # bit shift of 5, stripped "0b", do not stip zeros
      Green = bin(round(pix[i,j][1] >> 5))[2:].zfill(3) # bit shift of 5, stripped "0b", do not stip zeros
      Red =   bin(round(pix[i,j][2] >> 6))[2:].zfill(2) # bit shift of 6 (only 2 bits for blue), stripped "0b", do not stip zeros
      data ='{:02x}'.format(int(''.join([Blue, Green, Red]), 2)) # concatenate and convert to hex
      output.write("x\"")
      output.write(data)
      output.write("\"")
      if (j != im.size[1]-1):
         output.write(", ")

output.write(")")  
output.write(");")    
