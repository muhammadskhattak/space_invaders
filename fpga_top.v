module fpga_top(CLOCK_50, // The 50 MHz clock
                KEY, // Used exclusively for mapping the reset button
                VGA_CLK, // The VGA clock
                VGA_HS, // The VGA horizontal sync
                VGA_VS, // The VGA vertical sync
                VGA_BLANK_N, // The VGA Blank
					 inout PS2_CLK,
					 inout PS2_DAT,
                VGA_SYNC_N, // VGA Sync
                VGA_R, // VGA Red[9:0]
                VGA_G, // VGA Green[9:0]
                VGA_B); //VGA Blue[9:0]
	input [0:0] KEY;
	input CLOCK_50;			//	50 MHz
	wire resetn;
	assign resetn = KEY[0];
	// Declare your inputs and outputs here
	// Do not change the following outputs
	output			VGA_clock;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
	
	// Create the colour, x, y and writeEn wires that are inputs to the controller.
	wire writeEn;
	wire ld_x, ld_y;
	wire left_pressed;
	wire right_pressed;
	wire up_pressed;
	wire down_pressed;
	wire w;
	wire a;
	wire s;
	wire d;
	wire space;
	wire down;
	wire [2:0] colour;
	wire [7:0] x;
	wire [6:0] y;

	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(writeEn),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_clock(VGA_clock));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";
	
			
	// Put your code here. Your code should produce signals x,y,colour and writeEn/plot
	// for the VGA controller, in addition to any other functionality your design may require.
	keyboard_tracker #(.PULSE_OR_HOLD(1)) keyboard(
		.clock(CLOCK_50),
		.reset(resetn),
		.PS2_CLK(PS2_CLK),
		.PS2_DAT(PS2_DAT),
		.w(w),
		.a(a),
		.s(s),
		.d(d),
		.left(left_pressed),
		.right(right_pressed),
		.up(up_pressed),
		.down(down_pressed)
		.space(space),
		.enter(enter)
		);
	

	
endmodule
					 
					 
