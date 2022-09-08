module opencartgba2(
	// GBA (GamePak) Interface
	input [23:0] GBA_AD,
	input GBA_CS,
	input GBA_WR,
	input GBA_RD,
	// ROM (Flash) Interface
	output reg[23:0] ROM_A
	);

reg[23:0] ROM_A_NEXT;
	
always @ (GBA_CS, GBA_RD, GBA_WR, GBA_AD)
begin
	if (GBA_CS)
		begin
			ROM_A = GBA_AD;
			ROM_A_NEXT = GBA_AD;
		end
	else if (!GBA_RD || !GBA_WR)
		ROM_A_NEXT = ROM_A + 24'b1;
	else
		ROM_A = ROM_A_NEXT;
end

endmodule