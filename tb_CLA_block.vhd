library ieee;                                           
use ieee.std_logic_1164.all;

entity tb_CLA_block is
end tb_CLA_block;

architecture behavioural of tb_CLA_block is

        component CLA_block
                port(
                        a,b: in std_ulogic_vector(3 downto 0);
                        cin : in std_ulogic;
                        s: out std_ulogic_vector(3 downto 0);
                        cout : out std_ulogic
                );
        end component;

	
        signal cin, cout : std_ulogic := '0'; 
	signal a,b,s : std_ulogic_vector(3 downto 0):= (others => '0'); 




        begin
        DUT:CLA_block
        port map(
                a => a,
                b => b,
                cin => cin,
                cout => cout,
                s => s
        );

  
	process
	begin 
		wait for 10 ns; 
		a <="0001"; -- = 1
		b <="0010"; -- = 2 
		cin <= '0'; --ingen mente 
		
		wait for 10 ns;
		a<="0011"; -- =3 
		b <="0100"; -- =4
		cin <='1'; --ingen mente
		
		wait for 10 ns; 
		a <="0101"; --=5
		b <="0110"; --=6 
		cin<='0'; -- ingen mente 
		
		wait for 10 ns; 
		a <="0011"; 
		b<="0011"; 
		cin <= '1'; -- ingen mente 
 
		wait for 10 ns; 
		a <="1110"; -- = 14
		b<="0011"; -- = 3
		cin <='1'; --skal lage mente 14+3+1=18 aka 10010
		wait for 10 ns;
		assert(s ="0010" and cout= '1')
			report "feil oppstod" 
			severity failure;

		wait for 10 ns;  
		a <= "0001"; -- = 1
		b <= "1111"; -- = 15
		cin <= '1'; --skal lage mente 1 + 15 + 1 = 17 aka 10001
		wait for 10 ns; 

		assert(s ="0001" and cout='1')
			report"feil oppstod" 
			severity failure; 

		wait for 10 ns; 
		report "alle tester ble passed" severity note; 
		wait;

	end process; 
end architecture behavioural; 


