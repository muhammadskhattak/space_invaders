module player(clk, reset_n, add_x, add_y, y_pos_mod, y_neg_mod, x_pos, y_pos);
    input clk; // The system clock, 60 Hz
    input reset_n; // Resets the system
    input add_x; // Indicates the x-coordinate mod to draw a pixel
    input [1:0] add_y; // Indicates the y-coordinate mod to draw a pixel
    input y_pos_mod; // Indicates when to move the entire "ship" up
    input y_neg_mod;  // Indicates when to move the entire "ship" down
    output [7:0] x_pos; // Output to VGA
    output [7:0] y_pos; // Output to VGA
	 
	 reg [7:0] x_pixel = 8'b10011011;
	 reg [7:0] y_pixel;
	 reg y_increment;
	 
	 //Determines what y increment is
    always @(posedge clk) begin
		if (!reset_n)
			y_pixel <= 8'b0;
		else begin
			if (y_pos_mod)
				y_increment <= 1;
			else if (y_neg_mod)
				y_increment <= -1;
			else
				y_increment <= 0;
		end
		//Assign y_pixel to y_pixel + the y_increment chosen by input
		y_pixel = y_pixel + y_increment;
    end
	 assign x_pos = x_pixel + add_x;
	 assign y_pos = add_y + y_pixel;
	 
endmodule
