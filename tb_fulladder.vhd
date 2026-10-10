library ieee; 
use ieee.std_logic_1164.all; 
  
entity tb_fulladder is 
end entity tb_fulladder;

architecture behavioral of tb_fulladder is
  component fulladder is
    port(
      a, b  : in  std_ulogic;
      cin   : in  std_ulogic;
      s     : out std_ulogic; 
      cout  : out std_ulogic
    );
  end component;


  signal tb_a, tb_b, tb_cin : std_ulogic := '0'; 

  signal tb_s, tb_cout : std_ulogic; 
	  
begin  
  -- instansiering: 
  DUT: fulladder    -- Merkelappen DUT betyr «device under test» som er en av mange 
  port map(         -- vanlige betegnelser på simuleringsobjektet.    
    a    => tb_a,   -- Mappinger gjøres med =>, til forskjell fra tilordninger som
    b    => tb_b,   -- bruker <= eller :=  
    cin  => tb_cin, -- Mappinger kan ses på en ren sammenkobling av ledninger
    s    => tb_s,   -- Vi mapper alltid testenhetens porter til testbenkens signaler 
    cout => tb_cout -- Siste informasjon før parantes-slutt har ikke ',' eller ';'
  );	
  -- I testbenker kan vi ha prosesser uten sensitivitetsliste.
  -- i slike prosesser kan vi angi tid med «wait» statements, og
  -- vi kan sette signaler flere ganger etter hverandre uten å gi konflikter.
  -- NB: Prosessen vil trigges om og om igjen om vi ikke hindrer det. 
  process  
  begin
    wait for 10 ns;
    tb_a <= '1';
    tb_b <= '0';
    tb_cin <= '0';
    wait for 10 ns;
	tb_a <= '1'; 
	tb_b<='1';
	tb_cin<='1';
wait for 10 ns; 
	tb_a<='1';
	tb_b<='1';
	tb_cin<='0'; 
wait for 10 ns;
	tb_a<='1';
	tb_b<='0'; 
	tb_cin<='1'; 
wait for 10 ns; 
	tb_a<='0'; 
	tb_b <= '0'; 
	tb_cin<='0'; 
wait for 10 ns; 
	tb_a<='0'; 
	tb_b<='1'; 
	tb_cin<='0'; 
wait for 10 ns; 
	tb_a<='0'; 
	tb_b<='0';
	tb_cin<='1'; 
wait for 10 ns; 
	tb_a<='0'; 
	tb_b<='1'; 
	tb_cin<='1'; 
wait for 10 ns;     
    report("Ferdig!") severity note;
    ---std.env.stop;   -- stopper simuleringen
    wait; -- brukes med GHDL som alternativ til "std.env.stop;"
  end process;
end architecture behavioral;
