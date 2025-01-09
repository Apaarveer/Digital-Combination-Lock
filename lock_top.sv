`define start_state 4'b0000
`define success_one 4'b0001
`define success_two 4'b0010
`define success_three 4'b0011
`define success_four 4'b0100
`define success_five 4'b0101
`define success_six 4'b0110
`define fail_one 4'b0111
`define fail_two 4'b1000
`define fail_three 4'b1001
`define fail_four 4'b1010
`define fail_five 4'b1011
`define fail_six 4'b1100


module lab3_top(SW,KEY,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,LEDR);
  input [9:0] SW;
  input [3:0] KEY;
  output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
  output [9:0] LEDR;   // optional: use these outputs for debugging on your DE1-SoC

  wire clk = ~KEY[0];  // this is your clock
  wire rst_n = KEY[3]; // this is your reset; your reset should be synchronous and active-low

  // put your solution code here!
  reg [3:0] state;
  
	always @(posedge clk) //start clock
  begin
		
	  if(~rst_n) // check if reset in on
		  state <= `start_state; //send state back to state one
		else
		
		begin
			case(state) // check the present state
			`start_state:
			begin
				if(SW == 10'b110)
					state <= `success_one; //if the correct digit is entered, send state to success_one state
				else
				state <= `fail_one; //if the incorrect digit is entered, send state to fail_one state
			end
			`success_one:
			begin
				if(SW == 10'b1000)
				state <= `success_two; //if the correct digit is entered, send state to success_two state
				else
				state <= `fail_two; //if the incorrect digit is entered, send state to fail_two state
			end
			`success_two:
			begin
				if(SW == 10'b0011)
				state <= `success_three; //if the correct digit is entered, send state to success_three state
				else
				state <= `fail_three; //if the incorrect digit is entered, send state to fail_three state
			end
			`success_three:
			begin
				if(SW == 10'b0111)
				state <= `success_four;//if the correct digit is entered, send state to success_four state
				else
				state <= `fail_four; //if the incorrect digit is entered, send state to fail_four state
			end
			`success_four:
			begin
				if(SW == 10'b0101)
				state <= `success_five; //if the correct digit is entered, send state to success_five state
				else
				state <= `fail_five; //if the incorrect digit is entered, send state to fail_five state
			end
			`success_five:
			begin
				if(SW == 10'b0100)
				state <= `success_six;//if the correct digit is entered, send state to success_six state
				else
				state <= `fail_six; //if the incorrect digit is entered, send state to fail_six state
			end
			`fail_one: // check if state is in fail_one
			begin
				state <= `fail_two; //send state to fail_two
			end 
			`fail_two: // check if state is in fail_two
			begin
				state <= `fail_three; //send state to fail_three
			end
			`fail_three: // check if state is in fail_three
			begin
				state <= `fail_four; //send state to fail_four
			end
			`fail_four: // check if state is in fail_four 
			begin
				state <= `fail_five; //send state to fail_five
			end 
			`fail_five: // check if state is in fail_five 
			begin
				state <= `fail_six; //send state to fail_six
			end
			endcase
		end
	end
				
  
  always @(*)
  begin
			HEX0 = 7'b1111111; //set all Hex's to off
			HEX1 = 7'b1111111; 
			HEX2 = 7'b1111111;
			HEX3 = 7'b1111111;
			HEX4 = 7'b1111111;
			HEX5 = 7'b1111111;
		
	  case(state) // check present state
		
			
		`success_six: // if we are in success_six, output should say "OPEn"
				begin
				HEX5 = 7'b1111111;
				HEX4 = 7'b1111111;
				HEX3 = 7'b1000000;
				HEX2 = 7'b0001100;
				HEX1 = 7'b0000110;
				HEX0 = 7'b0101011;
				end
		`fail_six: // if we are in fail_six, output should say "CLOSED"
			begin
			HEX5 = 7'b1000110;
			HEX4 = 7'b1000111;
			HEX3 = 7'b1000000;
			HEX2 = 7'b0010010;
			HEX1 = 7'b0000110;
			HEX0 = 7'b1000000;
			end
			
			default:
			begin
		
				case(SW) // check the inputs of the switches
		
					10'b0000000000: //If input is zero, display "0"
					
						begin
					   	HEX5 = 7'b1111111;
						HEX4 = 7'b1111111;
						HEX3 = 7'b1111111;
						HEX2 = 7'b1111111;
						HEX1 = 7'b1111111;
						HEX0 = 7'b1000000;
						end
					
					10'b0000000001:  //If input is one, display "1"
					
						begin
						HEX5 = 7'b1111111;
						HEX4 = 7'b1111111;
						HEX3 = 7'b1111111;
						HEX2 = 7'b1111111;
						HEX1 = 7'b1111111;
						HEX0 = 7'b1111001;
						end
					
					10'b0000000010: //If input is two, display "2"
					
						begin
						HEX5 = 7'b1111111;
						HEX4 = 7'b1111111;
						HEX3 = 7'b1111111;
						HEX2 = 7'b1111111;
						HEX1 = 7'b1111111;
						HEX0 = 7'b0100100;
						end
					
					10'b0000000011: //If input is three, display "3"
					
						begin	
						HEX5 = 7'b1111111;
						HEX4 = 7'b1111111;
						HEX3 = 7'b1111111;
						HEX2 = 7'b1111111;
						HEX1 = 7'b1111111;
						HEX0 = 7'b0110000;
						end
					
					10'b0000000100: //If input is four, display "4"
					
						begin
						HEX5 = 7'b1111111;
						HEX4 = 7'b1111111;
						HEX3 = 7'b1111111;
						HEX2 = 7'b1111111;
						HEX1 = 7'b1111111;
						HEX0 = 7'b0011001;
						end

					10'b0000000101: //If input is five, display "5"
					
						begin
						HEX5 = 7'b1111111;
						HEX4 = 7'b1111111;
						HEX3 = 7'b1111111;
						HEX2 = 7'b1111111;
						HEX1 = 7'b1111111;
						HEX0 = 7'b0010010;
						end
					
					10'b0000000110: //If input is six, display "6"
					
						begin
						HEX5 = 7'b1111111;
						HEX4 = 7'b1111111;
						HEX3 = 7'b1111111;
						HEX2 = 7'b1111111;
						HEX1 = 7'b1111111;
						HEX0 = 7'b0000010;
						end
					
					10'b0000000111: //If input is seven, display "7"
					
						begin
						HEX5 = 7'b1111111;
						HEX4 = 7'b1111111;
						HEX3 = 7'b1111111;
						HEX2 = 7'b1111111;
						HEX1 = 7'b1111111;
						HEX0 = 7'b1111000;
						end
					
					10'b0000001000: //If input is eight, display "8"
					
						begin
						HEX5 = 7'b1111111;
						HEX4 = 7'b1111111;
						HEX3 = 7'b1111111;
						HEX2 = 7'b1111111;
						HEX1 = 7'b1111111;
						HEX0 = 7'b0000000;
						end
					
					10'b0000001001:  //If input is nine, display "9"
					
						begin
						HEX5 = 7'b1111111;
						HEX4 = 7'b1111111;
						HEX3 = 7'b1111111;
						HEX2 = 7'b1111111;
						HEX1 = 7'b1111111;
						HEX0 = 7'b0011000;
						end
	
					default: //If inputs on the switches are not between (0-9), display "Error"
							
						begin
						HEX0 = 7'b1001110; //r
						HEX1 = 7'b1000000; //O
						HEX2 = 7'b1001110; //r
						HEX3 = 7'b1001110;//r
						HEX4 = 7'b0000110; //E
						HEX5 = 7'b1111111; //off
						end
				endcase
		
			end
	
	endcase
	end
endmodule
