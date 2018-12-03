module laser(clk, reset_n, on_create, y_init, subtract_x, x_pos, y_pos);
	input clk; // Clock synced to the system
	input reset_n; // Resets the system
	input on_create; //Represents the space bar
	input [2:0] subtract_x; // Indicates how much to move the x-pixel
	input [6:0] y_init; // The initial y_pos for this laser (should not change)
	output reg [7:0] x_pos; // The current x-position of the alien
	output reg [6:0] y_pos; // The current y-position of the alien

	reg signed [7:0] x_pixel;
	reg [6:0] y_pixel;
	reg created; // Indicates that on_create was called at least once

	always @(posedge clk) begin
		if (!reset_n) begin
			x_pixel <= 8'b10011011;
			y_pixel <= y_init;
			created <= 0;
		end
		else begin
			if (on_create)
				begin
					x_pixel <= 8'b10011011;
					y_pixel <= y_init;
					created <= 1;
				end
		end
	end
	always @(*) begin
		if (created) begin
			x_pos <= x_pixel - subtract_x;
			y_pos <= y_pixel;
		end
		else begin
			x_pos <= 8'b10011011;
			y_pos <= 7'b0000000;
		end
	end
endmodule
