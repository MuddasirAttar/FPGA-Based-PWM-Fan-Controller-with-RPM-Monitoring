
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity simple_bus_if is
    generic (
        REG_COUNT : integer := 2
    );
    port (
        clk        : in  std_logic;        
        reset      : in  std_logic;       
        bus_en     : in  std_logic;       
        wr_en      : in  std_logic_vector(3 downto 0);
        addr       : in  std_logic_vector(1 downto 0); 
        wr_data    : in  unsigned(31 downto 0); 
        read_data  : out unsigned(31 downto 0);
        rpm_get    : in unsigned(31 downto 0);
        rpm_set    : out unsigned(31 downto 0)
    );
end simple_bus_if;

architecture rtl of simple_bus_if is
    type reg_array is array (0 to REG_COUNT - 1) of std_logic_vector(31 downto 0); -- (32-bit registers)
    signal registers : reg_array := (others => (others => '0'));

begin
    
    process(clk, reset)
    begin
        if reset = '1' then
            registers(0) <= X"00000400"; -- Reset rpm 
            registers(1) <= X"00000100" ; -- Reset tachometer speed
        elsif rising_edge(clk) then
            if bus_en = '1' then
                -- Write operation
                if wr_en /= "0000" then
                    case addr is
                        when "00" =>
                            if wr_en(0) = '1' then registers(0)(7 downto 0)   <= std_logic_vector(wr_data(7 downto 0));   end if;
                            if wr_en(1) = '1' then registers(0)(15 downto 8)  <= std_logic_vector(wr_data(15 downto 8));  end if;
                            if wr_en(2) = '1' then registers(0)(23 downto 16) <= std_logic_vector(wr_data(23 downto 16)); end if;
                            if wr_en(3) = '1' then registers(0)(31 downto 24) <= std_logic_vector(wr_data(31 downto 24)); end if;
                        when "01" =>
                            if wr_en(0) = '1' then registers(1)(7 downto 0)   <= std_logic_vector(wr_data(7 downto 0));   end if;
                            if wr_en(1) = '1' then registers(1)(15 downto 8)  <= std_logic_vector(wr_data(15 downto 8));  end if;
                            if wr_en(2) = '1' then registers(1)(23 downto 16) <= std_logic_vector(wr_data(23 downto 16)); end if;
                            if wr_en(3) = '1' then registers(1)(31 downto 24) <= std_logic_vector(wr_data(31 downto 24)); end if;
                        when others =>
                            registers (0) <=  registers(0);
                            registers (1) <=  registers(1);
                    end case;
                end if;
            end if;
            registers(1) <= std_logic_vector(rpm_get) ;
            
        end if;
    end process;

    -- Read operation
    process(addr, bus_en, registers)
    begin
        if bus_en = '1' then
            case addr is
                when "00" =>
                    read_data <= unsigned(registers(0));
                when "01" =>
                    read_data <= unsigned(registers(1));
                when others =>
                    read_data <= (others => '0');
            end case;
        else
            read_data <= (others => '0'); 
        end if;
    end process;

rpm_set <= unsigned(registers(0));

end rtl;
