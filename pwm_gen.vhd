
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity pwm_gen is
  Port (
      clk       : in  std_logic;          -- Clock signal 100Mhz
      reset     : in  std_logic;          -- Reset signal
      rpm_input : in  unsigned(31 downto 0); -- RPM input (0-3800)
      pwm_out   : out std_logic           -- PWM output
  );
end pwm_gen;


architecture rtl of pwm_gen is
    
    constant PWM_FREQ      : integer := 20000; -- 20 kHz PWM frequency -- Can be increased to 25kHz
    constant SYS_CLK_FREQ  : integer := 100_000_000; -- System clock frequency (100 MHz)
    constant MAX_RPM       : integer := 3800; -- Maximum RPM

    
    signal counter         : unsigned(15 downto 0) := (others => '0'); -- PWM counter
    signal period          : integer := SYS_CLK_FREQ / PWM_FREQ; 
    signal duty_cycle      : unsigned(15 downto 0); 

begin
    -- Calculate the duty cycle based on RPM input
    process(rpm_input)
    begin
        duty_cycle <= to_unsigned(((to_integer(rpm_input) * period) / MAX_RPM), 16);    -- Duty cycle : (rpm_input / MAX_RPM) * period
    end process;

    --PWM signal
    process(clk, reset)
    begin
        if reset = '1' then
            counter <= (others => '0');
            pwm_out <= '0';
        elsif rising_edge(clk) then
            if counter < period then
                counter <= counter + 1;
            else
                counter <= (others => '0'); 
            end if;

            
            if counter < duty_cycle then -- Set PWM output based on duty cycle
                pwm_out <= '1';
            else
                pwm_out <= '0';
            end if;
        end if;
    end process;
end rtl;
