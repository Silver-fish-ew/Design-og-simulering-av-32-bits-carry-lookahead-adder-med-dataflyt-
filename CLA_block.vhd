library ieee; 
use ieee.std_logic_1164.all; 

entity CLA_block is 
	port(
	a,b: in std_ulogic_vector(3 downto 0); 
	cin: in std_ulogic; 
	s : out std_ulogic_vector(3 downto 0); 
	cout: out std_ulogic
	); 
end entity CLA_block; 

architecture mixed of CLA_block is 
	
	component fulladder 
		port(a,b,cin : in std_ulogic;
		s, cout : out std_ulogic
		); 
	end component; 
	

	signal p, g : std_ulogic_vector(3 downto 0); 
	signal carry: std_ulogic_vector(4 downto 0); 
	signal c: std_ulogic_vector(4 downto 0); 
	signal p30, g30: std_ulogic;
	
begin 
	p<= a xor b; 
	g<= a and b; 

	p30 <= p(0) and p(1) and p(2) and p(3); -- propagere over 4 bits
	g30 <= g(3) or (p(3) and g(2)) or (p(3) and p(2) and g(1)) or
		(p(3) and p(2) and p(1) and g(0)); 

	 

	c(0) <= cin;
	c(1) <= g(0) or (p(0) and c(0));
	c(2) <= g(1) or (p(1) and g(0)) or (p(1) and p(0) and c(0));
	c(3) <= g(2) or (p(2) and g(1)) or (p(2) and p(1) and g(0)) or
            (p(2) and p(1) and p(0) and c(0));
	c(4) <= g30 or (p30 and c(0));

	carry(0) <= cin;
	

	cout <= c(4);
	
	Fulladder0: fulladder 
		port map( 
			a => a(0), 
			b => b(0), 
			cin => carry(0),
			s => s(0),
			cout => carry(1) 
		); 
	
	Fulladder1: fulladder 
		port map(
			a => a(1),
			b => b(1),
			cin => carry(1), 
			s => s(1),
			cout => carry(2) 
		); 

	Fulladder2: fulladder 
		port map(
			a => a(2), 
			b => b(2),
			cin => carry(2), 
			s => s(2),
			cout => carry(3) 
		); 
	
	Fulladder3: fulladder 
		port map( 
			a => a(3), 
			b => b(3),
			cin => carry(3), 
			s => s(3),
			cout => carry(4)
		); 
		

end mixed; 

	
