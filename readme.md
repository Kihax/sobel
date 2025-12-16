# Sobel filter
A VHDL programm to implement a sobel filter on a  Artix 7 XC7A100T-CSG324.
![Artix 7 XC7A100T-CSG324](images/carte.jpg)
## Team members
- Killian Kerlau
- Rémi Leluan
## Software
First, we use Vivado from Xilinx and to implement the bitstream on  Artix 7 XC7A100T-CSG324. However, we can test the testbench on an open-source software such as GHDL and surfer to emulate and check everything is fine.

To run, the different benchmark, you can follow the commande line given under

Pour compiler 
🔹 Compilation
ghdl -a --std=08 --workdir=build sources/regUnit.vhd
ghdl -a --std=08 --workdir=build sources/tb_regUnit.vhd

🔹 Simulation + génération des signaux
ghdl -r --std=08 --workdir=build tb_regUnit --vcd=build/wave.vcd --assert-level=error --stop-time=1us

## Result
![Result](images/result.jpg)
You can see, we get the border from the bug on the image.