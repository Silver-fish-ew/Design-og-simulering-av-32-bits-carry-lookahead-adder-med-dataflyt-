library ieee; 
use ieee.std_logic_1164.all;

entity fulladder is 
	port(a,b,cin:in std_ulogic; s,cout:out std_ulogic); 
end fulladder; 

architecture dataflyt of fulladder is 
	begin 
	s <= a xor b xor cin; 
	cout <= ((a xor b) and cin) or (a and b); 
end dataflyt;  

