library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity opencartgba is
	port (
		GBA_AD	: in	std_logic_vector(23 downto 0);
		GBA_CS	: in	std_logic;
		GBA_RD	: in	std_logic;
		GBA_WR	: in	std_logic;
		ROM_A		: out	std_logic_vector(23 downto 0)
	);
end opencartgba;

architecture cart of opencartgba is
  signal ADDR : std_logic_vector(23 downto 0);
  signal ADDR_INC : std_logic_vector(23 downto 0);
begin
	process (GBA_RD, GBA_CS, GBA_WR, GBA_AD) is
	begin
		if GBA_CS = '1' then
			ADDR <= GBA_AD;
			ADDR_INC <= GBA_AD;
		elsif GBA_WR = '0' or GBA_RD = '0' then
			ADDR_INC <= std_logic_vector(unsigned(ADDR) + 1);
		else
			ADDR <= ADDR_INC;
		end if;
	end process;
	ROM_A <= ADDR;
end cart;