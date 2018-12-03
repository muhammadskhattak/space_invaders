module fsa_laser(clk, reset_n, space, add_x,  colour, write_en);
  input clk; // Clock cycle for the system,,
  input reset_n;
  input space; //Represents the space bar
  output reg [2:0] add_x;
  output reg [2:0] colour; //Colour of the laser, probably red, NEED TO FIX
  output reg write_en;

	// ****************************
	// ***** DEFINE STATES ********
	// ****************************
  localparam WAIT = 3'd0;
  localparam LEFT1 = 3'd1;
  localparam LEFT2 = 3'd2;
  localparam LEFT3 = 3'd3;
  localparam LEFT4 = 3'd4;
  localparam LEFT5 = 3'd5;

	// ***************************
	// ****** STATE TABLE ********
	// ***************************
  reg [2:0] current_state;
  reg [2:0] next_state;

  always@(*)
  begin:states
    case(current_state)
      WAIT : next_state = LEFT1;
      LEFT1 : next_state = LEFT2;
      LEFT2 : next_state = LEFT3;
      LEFT3 : next_state = LEFT4;
      LEFT4 : next_state = LEFT5;
      LEFT5 : next_state = WAIT;
    endcase
  end
	// ***************************
	// ******** STATES ***********
	// ***************************
  always @(*)
  begin : signal_states
    add_x = 3'b00;
    colour = 3'b100;
    write_en = 1;

    case (current_state)
    RIGHT1: begin
      write_en = 1;
    end
    RIGHT2: begin
      write_en = 1;
      add_x = 3'b001;
      colour = 3'b101;
    end
    RIGHT3: begin
      write_en = 1;
      add_x = 3'b010;
      colour = 3'b101;
    end
    RIGHT4: begin
      write_en = 1;
      add_x = 3'b011
      colour = 3'b101;
    end
    RIGHT5: begin
      write_en = 1;
      add_x = 3'b100;
    end
  end
endmodule
