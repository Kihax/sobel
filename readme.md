# Sobel Filter (VHDL)

This project presents a **hardware implementation of a Sobel edge‑detection filter in VHDL**, targeting the **Xilinx Artix‑7 XC7A100T‑CSG324** FPGA. The goal is to demonstrate how a classic image‑processing algorithm can be efficiently implemented and validated on FPGA hardware.

![Artix‑7 XC7A100T‑CSG324](images/carte.jpg)

---

## Project Description

The **Sobel filter** is a widely used operator in image processing for **edge detection**. It highlights regions of an image where pixel intensity changes sharply, which usually correspond to object boundaries. By computing intensity gradients in the horizontal and vertical directions, the Sobel filter extracts the main structural features of an image.

This filter is particularly well suited for **FPGA implementation** because it relies on simple arithmetic operations and local pixel neighborhoods, allowing efficient parallelization. Such implementations are commonly used in **computer vision**, **robotics**, **real‑time video processing**, and **embedded systems** where low latency is critical.

---

## Team Members
- **Killian Kerlau**  
- **Rémi Leluan**

---

## Tools & Software

- **Vivado (Xilinx)**  
  Used for synthesis, implementation, and bitstream generation for the Artix‑7 FPGA.

- **GHDL**  
  Open‑source VHDL simulator used to compile and simulate the design.

- **Surfer**  
  Waveform viewer used to analyze simulation results.

---

## Simulation & Testbench

The design is first validated using VHDL testbenches before being deployed on the FPGA.

### Compilation

```bash
ghdl -a --std=08 --workdir=build sources/regUnit.vhd
ghdl -a --std=08 --workdir=build sources/tb_regUnit.vhd
```

### Simulation and Waveform Generation

```bash
ghdl -r --std=08 --workdir=build tb_regUnit \
  --vcd=build/wave.vcd \
  --assert-level=error \
  --stop-time=1us
```

The generated `wave.vcd` file can be opened with **Surfer** to verify signal timing and functional correctness.

---

## Results

![Result](images/result.jpg)

The resulting image clearly shows the detected **edges of the bug**, confirming the correct behavior of the Sobel filter implementation.

---

## Repository

The complete project is available on GitHub:

👉 https://github.com/Kihax/sobel

