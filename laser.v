module laser(clk, reset_n, x_go, y_init, subtract_x, x_pos, y_pos);
	input clk; // Clock synced to the system
	input reset_n; // Resets the system
	input x_go; //Represents the space bar
	input [2:0] subtract_x; // Indicates how much to move the x-pixel
	input [6:0] y_init; // The initial y_pos for this laser (should not change)
	output [7:0] x_pos; // The current x-position of the alien
	output [6:0] y_pos; // The current y-position of the alien

	reg signed [7:0] x_pixel;
	reg [6:0] y_pixel;

	always @(posedge clk) begin
	if (!reset_n) begin
		x_pixel <= 8'b10011011;
		y_pixel <= y_init;
	end
	else begin
		if (x_go)
			x_pixel <= 8'b10011011;
			y_pixel <= y_init;
			subtract_x <= 1;
		else
			subtract_x <= 0;
	end
	end

	assign x_pos = x_pixel - subtract_x;
	assign y_pos = y_pixel;
endmodule
