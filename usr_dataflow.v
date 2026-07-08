module usr_dataflow(
    input clk,
    input reset,
    input [1:0] sel,
    input sr,
    input sl,
    input [3:0] din,
    output reg [3:0] q
);

wire [3:0] next_q;

assign next_q =
    (sel==2'b00) ? q :
    (sel==2'b01) ? {sr,q[3:1]} :
    (sel==2'b10) ? {q[2:0],sl} :
                   din;

always @(posedge clk or posedge reset)
begin
    if(reset)
        q <= 4'b0000;
    else
        q <= next_q;
end

endmodule
