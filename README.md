Fan Controller System Documentation
Introduction
The Fan Controller System enables users to control the fan speed using PWM (Pulse Width Modulation) and monitor the actual fan speed (RPM) using the fan’s tachometer signal. This system provides a simple register-based interface to set the desired RPM and read the actual RPM measured from the fan.
System Overview
The system consists of several modules that work together to manage fan operation:
- Top Module: Integrates the entire system.
- PWM Generator: Controls fan speed with a 20 kHz PWM signal.
- Tachometer Reader: Measures the fan's actual RPM.
- Bus Interface: Manages register-based communication for setting and reading RPM values.
Modules and Their Functions
1. Top Module
The Top Module brings together the PWM generator, tachometer reader, and bus interface. It coordinates the internal signals to ensure proper fan speed control and feedback monitoring.
Key Functions:
- Receives the desired RPM value from the user.
- Controls the fan using PWM output.
- Monitors fan speed using tachometer input and updates the measured RPM register.
2. PWM Generator
The PWM Generator creates a 20 kHz signal to control the fan speed. The duty cycle of the signal determines how fast the fan will spin. This duty cycle is proportional to the RPM value set by the user.
Key Signals:
- pwm_out: Sends the PWM signal to the fan.
- rpm_input: Receives the desired RPM from the bus interface.
- clk: Clock input for PWM operation.
3. Tachometer Reader
The Tachometer Reader monitors the fan’s speed by counting pulses from the fan’s tachometer signal. The fan provides 4 pulses per revolution, and the system uses these pulses to calculate the RPM.
Key Signals:
- tach_signal: Receives pulses from the fan.
- rpm_out: Outputs the measured RPM value.
- clk: Clock input for pulse counting.
4. Bus Interface
The Bus Interface allows the user to interact with the fan system through registers. It provides two 32-bit registers:
- Register 0: RPM Set Register – Stores the desired RPM value.
- Register 1: RPM Get Register – Holds the measured RPM value.
Key Signals:
- write_data: Input to write the desired RPM.
- read_data: Output for reading the stored or measured RPM.
- bus_ena: Enables bus communication for reading and writing.
- addr: Selects the register (0 for RPM set, 1 for RPM get).
How to Use the System
Setting the Fan Speed
1. Write the desired RPM value (e.g., 2500) to Register 0.
2. The PWM generator will adjust the fan speed based on the provided RPM.
Reading the Measured RPM
1. Monitor the fan’s speed through tachometer pulses.
2. Read the actual RPM value from Register 1 to verify the fan's speed.
Conclusion
The Fan Controller System provides an easy-to-use interface for controlling and monitoring fan speed. Users can write the desired RPM to the set register and read the actual RPM from the get register. With its register-based design, the system ensures flexibility and scalability for various fan control applications.
