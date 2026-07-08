module usr_behavioral(
    input clk,
    input reset,
    input [1:0] sel,
    input sr,
    input sl,
    input [3:0] din,
    output reg [3:0] q
);

always @(posedge clk or posedge reset)
begin
    if(reset)
        q <= 4'b0000;
    else
        case(sel)
            2'b00: q <= q;
            2'b01: q <= {sr, q[3:1]};
            2'b10: q <= {q[2:0], sl};
            2'b11: q <= din;
        endcase
end

endmodule
