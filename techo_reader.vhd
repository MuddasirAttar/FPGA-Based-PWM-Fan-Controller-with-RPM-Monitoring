
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity tacho_reader is
    Port (
        clk         : in  std_logic;       -- 100 MHz system clock
        reset       : in  std_logic;       -- Reset signal
        tach_signal : in  std_logic;       -- Tachometer input signal
        rpm_out     : out unsigned(31 downto 0)  -- Calculated RPM output
    );
end tacho_reader;

architecture rtl of tacho_reader is
    constant CLK_FREQ   : integer := 100_000_000; -- 100 MHz clock frequency
    constant PULSES_PER_ROTATION : integer := 4; -- From Datasheet. It's 4 pole fan
    signal pulse_count     : integer := 0;     
    signal pulse_count_flag: std_logic:= '0' ;
    signal rpm_value       : unsigned(31 downto 0) := (others => '0'); -- RPM output
    signal one_second_tick : std_logic := '0';
    signal tach_prev : std_logic := '0';           
    signal counter_1sec    : integer := 0;    
    constant ONE_SECOND_COUNT : integer := CLK_FREQ - 1; 

begin
      process(clk, reset)
      begin
          if reset = '1' then
              counter_1sec <= 0;
              one_second_tick <= '0';
          elsif rising_edge(clk) then
              if counter_1sec < ONE_SECOND_COUNT then
                  counter_1sec <= counter_1sec + 1;
                  one_second_tick <= '0';
              else
                  counter_1sec <= 0;
                  one_second_tick <= '1';
              end if;
          end if;
      end process;
  
      -- Tachometer Signal
      process(clk, reset)
      begin
          if reset = '1' then
              tach_prev <= '0';
              pulse_count <= 0;
          elsif rising_edge(clk) then
              if tach_signal = '1' and tach_prev = '0' then
                  pulse_count <= pulse_count + 1;
              end if;
              if  pulse_count_flag = '1' then
                 pulse_count <= 0 ;
              end if;
              tach_prev <= tach_signal;
          end if;
      end process;
  
      process(clk, reset)
      begin
          if reset = '1' then
              rpm_value <= (others => '0');
              pulse_count_flag <= '0' ;
          elsif rising_edge(clk) then
              if one_second_tick = '1' then
                  rpm_value <= to_unsigned((pulse_count * 60) / PULSES_PER_ROTATION, 32);  -- RPM Calculation: (Pulse Count / Pulses Per Rotation) * 60
                  pulse_count_flag <= '1';
              else
                 pulse_count_flag <= '0';
              end if;
          end if;
      end process;
      rpm_out <= rpm_value;
  
end rtl;
