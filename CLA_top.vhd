library ieee; 
use ieee.std_logic_1164.all; 

entity CLA_top is 
	generic( --allows us to have multiple of them but 
		--still custom values for each one
		
		width : positive := 32
	);

	port(
		a,b : in std_ulogic_vector(width-1 downto 0);
		cin : in std_ulogic; 
		s : out std_ulogic_vector(width-1 downto 0); 
		cout : out std_ulogic
	);
end entity CLA_top; --apparently burde man si end entity name cuz 
			-- modern standard or sth so remember that 

architecture setteSammen of CLA_top is 

	component CLA_block
		port(
		a,b : in std_ulogic_vector(3 downto 0);
                cin : in std_ulogic;
                s : out std_ulogic_vector(3 downto 0);
                cout : out std_ulogic
		); 
	end component;
	
	signal carry : std_ulogic_vector(8 downto 0); 

begin 
	carry(0)<=cin; 

	-- lager en loop for å lage 8 CLA blokker
	
	gen_CLA: for i in 0 to 7 generate
		CLA_X : CLA_block
			port map( 
				a    => a(4*i+3 downto 4*i),
				b    => b(4*i+3 downto 4*i),
				cin  => carry(i),
				s    => s(4*i+3 downto 4*i),
				cout => carry(i+1));
	end generate gen_CLA;
	
	cout<=carry(8);	
end setteSammen;
