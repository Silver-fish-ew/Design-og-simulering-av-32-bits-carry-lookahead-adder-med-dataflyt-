library ieee; 
use ieee.std_logic_1164.all; 

entity tb_CLA_top is 
end entity tb_CLA_top; 

architecture behavioural of tb_CLA_top is
	constant width : positive := 32;	
	component CLA_top
		generic(
			width: positive := 32
		);

		port( 
			a,b : in std_ulogic_vector(width-1 downto 0);
			cin : in std_ulogic;
			s : out std_ulogic_vector(width-1 downto 0);
			cout : out std_ulogic
		); 
	end component;
	
	signal a,b,s: std_ulogic_vector(31 downto 0);
	signal cout,cin: std_ulogic; 
	
begin
	DUT: CLA_top
		--generic map(width => width)
		port map(
			a =>a, 
			b=>b, 
			cin=>cin, 
			cout=>cout, 
			s=>s
		);

	

	process 
	begin 
	-- faktiske testingen jeg bruker ikke hintet og går til hex.dec. representasjon bleh

		a<= x"00000001"; 
		b<=x"00000002"; 
		cin<='0';
		wait for 10 ns; -- skal bli lik 3 aka x00000003
		
		a<=x"00000001";
		b<=x"00000001";
		cin<='1';
		wait for 10 ns; 

		a<=x"00000005"; 
		b<=x"00000000"; 
		cin<='1'; 
		wait for 10 ns;
		
		a<=x"80000000"; --brukes MSB
		b<=x"80000000";
		cin<='0'; 
		wait for 10 ns; --skal få s=00000000 og cout=1

		a<=x"00000001"; 
		b<=x"FFFFFFFE"; 
		cin <='1'; 
		wait for 10 ns; -- også få s= 0000000 og cout=1

		a<=x"00000013"; --19
		b<=x"00000001"; --1
		cin<='0'; -- 19 +1 + 0 = 20
		wait for 10 ns; -- skal få x00000014 
	end process; 

end architecture behavioural; 
