module fpga_top(CLOCK_50, // The 50 MHz clock
                KEY, // Used exclusively for mapping the reset button
                VGA_CLK, // The VGA clock
                VGA_HS, // The VGA horizontal sync
                VGA_VS, // The VGA vertical sync
                VGA_BLANK_N, // The VGA Blank
					      PS2_CLK,
					      PS2_DAT,
                VGA_SYNC_N, // VGA Sync
                VGA_R, // VGA Red[9:0]
                VGA_G, // VGA Green[9:0]
                VGA_B); //VGA Blue[9:0]
	input [3:0] KEY;
	input CLOCK_50;			//	50 MHz
	inout PS2_CLK;
	inout PS2_DAT;
	wire reset_n;
	assign reset_n = KEY[0];
	// Declare your inputs and outputs here
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0]

	// Create the colour, x, y and writeEn wires that are inputs to the controller.
	wire writeEn;
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
			.resetn(reset_n),
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
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";


	// Put your code here. Your code should produce signals x,y,colour and writeEn/plot
	// for the VGA controller, in addition to any other functionality your design may require.
	keyboard_tracker #(.PULSE_OR_HOLD(1)) keyboard(
		.clock(CLOCK_50),
		.reset(reset_n),
		.PS2_CLK(PS2_CLK),
		.PS2_DAT(PS2_DAT),
		.w(w),
		.a(a),
		.s(s),
		.d(d),
		.left(left_pressed),
		.right(right_pressed),
		.up(up_pressed),
		.down(down_pressed),
		.space(space),
		.enter(enter)
		);
  // **********************
  // **** PLAYER FIELD ****
  // **********************
  wire player_add_x;
  wire [1:0] player_add_y;
  wire y_pos_mod;
  wire y_neg_mod;
	wire [2:0] player_colour;
	wire [7:0] player_x;
	wire [6:0] player_y;
  wire finished_player;
  // **********************
  // **** ALIEN FIELDS ****
  // **********************
  wire [6:0] alien_y_init;
  wire [2:0] alien_add_x;
  wire [7:0] alien_x;
  wire [6:0] alien_y;
  wire alien_colour;
  wire finished_alien;

  assign alien_y_init = 7'b0001111;

  // **********************
  // ***** DATAPATH *******
  // **********************
  player player1(.clk(CLOCK_50),
                  .reset_n(reset_n),
                  .add_x(player_add_x),
                  .add_y(player_add_y),
                  .y_pos_mod(y_pos_mod),
                  .y_neg_mod(y_neg_mod),
                  .x_pos(player_x),
                  .y_pos(player_y));

  alien alien1(.clk(CLOCK_50),
              .reset_n(reset_n),
              .y_init(alien_y_init),
              .add_x(alien_add_x),
              .x_pos(alien_x),
              .y_pos(alien_y));
  // **********************
  // **** CONTROLLER ******
  // **********************
  fsa_player player_fsa1(.clk(CLOCK_50),
                  .reset_n(reset_n),
                  .up(up_pressed),
                  .down(down_pressed),
                  .draw_enable(ready_player), // Might need to change this to instead be based on some other signal
                  .y_pos_mod(y_pos_mod),
                  .y_neg_mod(y_neg_mod),
                  .add_x(player_add_x),
                  .add_y(player_add_y),
                  .colour(player_colour),
                  .write_en(writeEn)
                  .continue_draw(finished_player));

  fsa_alien alien_fsa1(.clk(CLOCK_50),
                  .reset_n(reset_n),
                  .draw_enable(ready_alien), // Might instead set to this to some more global signal
                  .add_x(alien_add_x),
                  .colour(alien_colour),
                  .write_en(writeEn),
                  .continue_draw(finished_alien));

  // **********************
  // **** CONTROLLER ******
  // **********************
  wire ready_player;
  wire ready_alien;
  wire curr;

  always@(posedge CLOCK_50) begin
  if (finished_player)
    curr = 1; // Now draw the alien
  if (finished_alien)
    curr = 0; // Now draw the player1
  if (~finished_alien && ~finished_player)
    curr = 0;

  if (curr == 0)
    begin
      ready_player = 1;
      ready_alien = 0;
      x_pos = player_x;
      y_pos = player_y;
      colour = player_colour;
    end
  else if (curr == 1)
    begin
      ready_player = 0;
      ready_alien = 1;
      x_pos = alien_x;
      y_pos = alien_y;
      colour = alien_colour;
  end
endmodule
