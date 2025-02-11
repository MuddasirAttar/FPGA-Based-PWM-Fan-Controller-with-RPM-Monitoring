
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top is
  port (
    reset       : in  std_logic;
    bus_clk     : in  std_logic;
    bus_we      : in  std_logic_vector (3 downto 0);
    addr        : in  std_logic_vector (1 downto 0);
    read_data   : out  unsigned (31 downto 0);
    write_data  : in unsigned (31 downto 0);
    bus_ena     : in  std_logic ;
    pwm_out     : out std_logic;
    fan_tacho_in: in  std_logic
);
end top;

architecture rtl of top is

component pwm_gen
  Port (
    clk       : in  std_logic;          
    reset     : in  std_logic;          
    rpm_input : in  unsigned(31 downto 0); 
    pwm_out   : out std_logic           
);
end component;


component tacho_reader
    Port (
        clk         : in  std_logic;       
        reset       : in  std_logic;      
        tach_signal : in  std_logic;       
        rpm_out     : out unsigned(31 downto 0)  
    );
end component;

component simple_bus_if
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
end component;
    
    signal rpm_input : unsigned(31 downto 0);
    signal rpm_input_reg : unsigned(31 downto 0);
    signal rpm_out   : unsigned (31 downto 0);


begin

    pwm_inst : pwm_gen
    port map (
        clk => bus_clk,
        reset => reset,
        pwm_out => pwm_out,
        rpm_input => rpm_input
    );

    tacho_reader_inst : tacho_reader
    port map (
    clk           => bus_clk, 
    reset         => reset,    
    tach_signal   => fan_tacho_in,     
    rpm_out       => rpm_out
    );
  
    simple_bus_if_inst : simple_bus_if
        generic map(
            REG_COUNT => 2 
        )
        port map(
            clk        => bus_clk,
            reset      => reset,
            bus_en     => bus_ena,
            wr_en      => bus_we,
            addr       => addr,
            wr_data    => write_data,
            read_data  => read_data,
            rpm_get    => rpm_out,
            rpm_set    => rpm_input_reg
        );

 rpm_input <= rpm_input_reg ;

end rtl ;



