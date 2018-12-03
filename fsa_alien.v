module fsa_alien(clk, reset_n, draw_enable, add_x, colour, write_en, continue_draw);
  input clk; // Clock cycle for the system,,
  input reset_n; // Resets the states
  input draw_enable; // Tells the FSA when it should start writing
  output reg [2:0] add_x; // Draw the pixel at x_pixel + add_x
  output reg [2:0] colour; // Determines the colour of the pixel
  output reg write_en; // Tells the VGA if it should write
  output reg continue_draw; // Tells the FPGA top FSA to draw the next object
	// ****************************
	// ***** DEFINE STATES ********
	// ****************************
  localparam WAIT = 3'd0;
  localparam RIGHT1 = 3'd1;
  localparam RIGHT2 = 3'd2;
  localparam RIGHT3 = 3'd3;
  localparam RIGHT4 = 3'd4;
  localparam RIGHT5 = 3'd5;

	// ***************************
	// ****** STATE TABLE ********
	// ***************************
  reg [2:0] current_state;
  reg [2:0] next_state;

  always@(*)
  begin:states
    case(current_state)
      WAIT : begin
      if (draw_enable == 1)
        next_state = RIGHT1;
      else
        next_state = WAIT;
      end
      RIGHT1 : next_state = RIGHT2;
      RIGHT2 : next_state = RIGHT3;
      RIGHT3 : next_state = RIGHT4;
      RIGHT4 : next_state = RIGHT5;
      RIGHT5 : next_state = WAIT;
    endcase
  end
	// ***************************
	// ******** STATES ***********
	// ***************************
  always @(*)
  begin : signal_states
    add_x = 2'b000;
    colour = 2'b000;
    write_en = 1;
    continue_draw = 0;
    case (current_state)
		 RIGHT1: begin
			write_en = 1;
		 end
		 RIGHT2: begin
			write_en = 1;
			add_x = 2'b001;
			colour = 2'b101;
		 end
		 RIGHT3: begin
			write_en = 1;
			add_x = 2'b010;
			colour = 2'b101;
		 end
		 RIGHT4: begin
			write_en = 1;
			add_x = 2'b011;
			colour = 2'b101;
		 end
		 RIGHT5: begin
			write_en = 1;
			add_x = 2'b100;
			continue_draw = 1;
		 end
	  endcase
  end
endmodule
