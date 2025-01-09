`timescale 1 ps/ 1 ps

module tb_lab3_gate();
reg [9:0] SW;
  reg [3:0] KEY;
  wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
  wire [9:0] LEDR;
	
	lab3_top dut (
    .SW(SW),
    .KEY(KEY),
    .HEX0(HEX0),
    .HEX1(HEX1),
    .HEX2(HEX2),
    .HEX3(HEX3),
    .HEX4(HEX4),
    .HEX5(HEX5),
    .LEDR(LEDR)
  );
	// Clock start
  always begin
  #5 KEY[0] = 0;
	  #5 KEY[0] = 1;
  end
  
  	initial begin
   	
	//resetting to start_state
	KEY[0] = 0;
	SW = 10'b0;
  KEY[3] = 0; #20;
 	KEY[3] = 1;
	
	// Test 1: Transition through multiple states to check if displays "OPEN"
	
	SW = 10'b110; #10;
	SW = 10'b1000; #10;
	SW = 10'b0011; #10;
	SW = 10'b0111; #10;
	SW = 10'b0101; #10;
	SW = 10'b0100; #10;
	  

	// Test 2: Reset
	#5 KEY[3] = 0; #5;
	KEY[3] = 1; #5;

	//Go through a failing sequence to see if displays "CLOSED"

	SW = 10'b110; #10;
	SW = 10'b1111; #10;
  SW = 10'b0011; #10;
	SW = 10'b0111; #10;
	SW = 10'b0101; #10;
	SW = 10'b0100; #10;
	  
	// Test 5: entering a regular input, then an input that should display "Error"
	SW = 10'b110; #10;
	SW = 10'b10111111; #10;


	// Test 6: Go through another sequence of states and reset before finishing
	SW = 10'b110; #10;
	SW = 10'b1000; #10;
	SW = 10'b0011; #10;
	SW = 10'b0111; #10;
	SW = 10'b0101; #10;
	
	KEY[3] = 0; #5; //reset
	KEY[3] = 1; #5;
	  

	$stop;
	 
	end
endmodule: tb_lab3_gate
