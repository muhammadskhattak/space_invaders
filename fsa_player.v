module fsa_player(clk, reset_n, p_up, p_down, y_pos_mod, add_x, add_y, colour, write_en);
  input clk; // Clock cycle for the system, should be 60 Hz
  input reset_n; // Resets the position of the ship/all states
  input p_up; // Indicates when to move the player up
  input p_down; // Indicates when to move the player down

  output y_pos_mod; // Based on up/down, change the position of the ship
  output add_x; // Tells the datapath which pixel to draw to VGA
  output add_y; // Tells the datapath which pixel to draw to VGA
  output write_en; // Tells the VGA when to draw
  // ****************************
  // ***** DEFINE STATES ********
  // ****************************
  localparam WAIT = 4'd0;
  localparam UP1 = 4'd1;
  localparam UP2 = 4'd2;
  localparam UP3 = 4'd3;
  localparam UP4 = 4'd4;
  localparam UP5 = 4'd5;
  localparam UP6 = 4'd6;
  localparam DOWN1 = 4'd7;
  localparam DOWN2 = 4'd8;
  localparam DOWN3 = 4'd9;
  localparam DOWN4 = 4'd10;
  localparam DOWN5 = 4'd11;
  localparam DOWN6 = 4'd12;

  // ***************************
  // ****** STATE TABLE ********
  // ***************************
  reg [3:0] current_state;
  reg [3:0] next_state;

  always @(*)
  begin:states
    case(current_state)
      WAIT : begin
        if (up == 1)
          next_state = UP1;
        else if (down == 1)
          next_state = DOWN1;
        else
          next_state = WAIT;
      end
      UP1 : next_state = UP2;
      UP2 : next_state = UP3;
      UP3 : next_state = UP4;
      UP4 : next_state = UP5;
      UP5 : next_state = UP6;
      UP6 : next_state = WAIT;
      DOWN1 : next_state = DOWN2;
      DOWN2 : next_state = DOWN3;
      DOWN3 : next_state = DOWN4;
      DOWN4 : next_state = DOWN5;
      DOWN5 : next_state = DOWN6;
      DOWN6 : next_state = WAIT;
    endcase
  end

  // ***************************
  // ******** STATES ***********
  // ***************************
  always @(*)
  begin : signal_states
    add_x = 0;
    add_y = 0;
    y_pos_mod = 0;
    write_en = 0;

    case (current_state)
    endcase
  end
endmodule
