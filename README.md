# **FPGA-Based PWM Fan Controller with RPM Monitoring**  

## **Overview**  
This project implements an **FPGA-based Fan Controller System** that enables precise **fan speed control** using **Pulse Width Modulation (PWM)** and real-time **RPM monitoring** via a tachometer. The system is designed in **VHDL** and tested on a **Xilinx Spartan-7 FPGA** (XC7S50-1CSGA324C) using **Vivado, ModelSim, and GTKWAVE**.  

The system consists of three key modules:  
- **PWM Generator** – Generates a **20 kHz PWM signal** to control fan speed.  
- **Tachometer Reader** – Measures the **actual RPM** from the fan’s tachometer signal.  
- **Bus Interface** – Provides a **register-based interface** for user interaction.  

This project is useful for **embedded systems, industrial automation, and cooling solutions**, where precise fan speed control and monitoring are required.  

---

## **Features**  
✅ **Precise Fan Speed Control** via **20 kHz PWM** generation.  
✅ **Real-time RPM Monitoring** using **tachometer pulse counting (4 pulses per revolution)**.  
✅ **Register-Based Interface** for setting and reading RPM values.  
✅ **Tested on Xilinx Spartan-7 FPGA**, a **cost-effective ($100)** option for FPGA prototyping.  
✅ **Designed & Verified using** **Vivado, ModelSim, and GTKWAVE**.  
✅ **Scalable and Modular Design**, allowing easy integration into larger FPGA-based systems.  

---

## **Project Architecture**  
The system is divided into the following VHDL modules:  

### **1. Top Module (`top.vhd`)**  
- **Integrates all components** (PWM Generator, Tachometer Reader, Bus Interface).  
- **Receives user-defined RPM value** and controls fan speed accordingly.  
- **Monitors real-time RPM feedback** from the fan and updates the register.  

### **2. PWM Generator (`pwm_gen.vhd`)**  
- Generates a **20 kHz PWM signal** with a duty cycle proportional to the **desired RPM**.  
- **Takes RPM input** from the Bus Interface and adjusts the **PWM duty cycle** dynamically.  
- **Outputs `pwm_out` signal** to control the fan’s speed.  

### **3. Tachometer Reader (`techo_reader.vhd`)**  
- **Counts tachometer pulses** to determine **actual fan RPM**.  
- **Outputs RPM value** to the Bus Interface.  
- Uses a **4 pulses per revolution** calculation method for accurate RPM monitoring.  

### **4. Bus Interface (`bus_if.vhd`)**  
- Implements a **register-based communication system** for RPM control.  
- Provides two **32-bit registers**:  
  - **Register 0:** Stores **desired RPM** (write operation).  
  - **Register 1:** Stores **measured RPM** (read operation).  
- Supports **100 MHz bus clock timing** for smooth operation.  

---

## **Block Diagram**  
```plaintext
           +-------------------------------------------+
           |           FPGA Fan Controller            |
           |-------------------------------------------|
           |  +-------------+   +-----------------+   |
User Input |  | Bus Interface|-->| PWM Generator  |--> PWM Output (Fan)
 (RPM Set) |  +-------------+   +-----------------+   |
           |      |                    |              |
           |      v                    v              |
           |  +-------------+   +-----------------+   |
  Fan RPM  |  | RPM Register|<--| Tachometer Read |<-- Tachometer Input (Fan)
  Feedback |  +-------------+   +-----------------+   |
           +-------------------------------------------+
```

---

## **Hardware and Tools Used**  
### **FPGA Board:**  
- **Xilinx Spartan-7 FPGA** (**XC7S50-1CSGA324C**) – Cost-effective (~$100).  

### **Development Tools:**  
- **Vivado** (for synthesis, implementation, and debugging).  
- **ModelSim** (for VHDL simulation and verification).  
- **GTKWAVE** (for waveform analysis and debugging).  

### **Fan Hardware:**  
- **Delta Electronics EFC0812DB-F00** (DC Fan with PWM & Tachometer).  

---

## **Getting Started**  
### **1. Clone the Repository**  
```bash
git clone https://github.com/MuddasirAttar/FPGA-Based-PWM-Fan-Controller-with-RPM-Monitoring.git
cd FPGA-Based-PWM-Fan-Controller-with-RPM-Monitoring
```

### **2. Open in Vivado**  
1. Launch **Vivado**.  
2. Create a new project and select **Xilinx Spartan-7 FPGA (XC7S50-1CSGA324C)**.  
3. Add **VHDL source files** (`top.vhd`, `pwm_gen.vhd`, `techo_reader.vhd`, `bus_if.vhd`).  
4. Implement and generate the bitstream.  

### **3. Simulation with ModelSim**  
1. Open **ModelSim**.  
2. Load the testbench files.  
3. Run the simulation and verify PWM and RPM signals.  

### **4. Hardware Testing**  
- Connect the **Delta EFC0812DB-F00 fan** to the FPGA.  
- Set an RPM value using the **register-based interface**.  
- Observe PWM duty cycle changes and validate measured RPM.  

---

## **Results & Verification**  
✅ **Achieved precise fan speed control** with **accurate RPM measurement**.  
✅ **Verified digital design using ModelSim** (Functional Simulation).  
✅ **Tested hardware with real fan and FPGA implementation**.  
✅ **Met timing constraints and 100 MHz bus clock synchronization**.  

---

## **Future Enhancements**  
🚀 **Implement AXI Interface** for integration with SoC-based designs.  
🚀 **Add I2C/SPI support** for external sensor communication.  
🚀 **Enhance RPM control algorithm** for **better dynamic fan speed adjustments**.  



## Contributors 
📧 Contact: muddasirattar1999@gmail.com 

---
