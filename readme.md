Pour compiler 
🔹 Compilation
ghdl -a --std=08 --workdir=build sources/regUnit.vhd
ghdl -a --std=08 --workdir=build sources/tb_regUnit.vhd

🔹 Simulation + génération des signaux
ghdl -r --std=08 --workdir=build tb_regUnit --vcd=build/wave.vcd --assert-level=error --stop-time=1us