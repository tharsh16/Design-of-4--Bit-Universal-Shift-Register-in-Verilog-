`timescale 1ns/1ps

module tb_universal_shift_register;

reg clk;
reg reset;
reg [1:0] sel;
reg sr;
reg sl;
reg [3:0] din;

wire [3:0] q;

//-----------------------------------------------------
// Instantiate ONE model at a time
//-----------------------------------------------------

// Behavioral Model
usr_behavioral uut (
    .clk(clk),
    .reset(reset),
    .sel(sel),
    .sr(sr),
    .sl(sl),
    .din(din),
    .q(q)
);

/*
// Dataflow Model
usr_dataflow uut (
    .clk(clk),
    .reset(reset),
    .sel(sel),
    .sr(sr),
    .sl(sl),
    .din(din),
    .q(q)
);
*/

/*
// Structural Model
usr_structural uut (
    .clk(clk),
    .reset(reset),
    .sel(sel),
    .sr(sr),
    .sl(sl),
    .din(din),
    .q(q)
);
*/

//-----------------------------------------------------
// Clock Generation (10 ns period)
//-----------------------------------------------------

always #5 clk = ~clk;

//-----------------------------------------------------
// Test Sequence
//-----------------------------------------------------

initial
begin

    clk = 0;
    reset = 1;
    sel = 2'b00;
    sr = 0;
    sl = 0;
    din = 4'b0000;

    #10;
    reset = 0;

    // Parallel Load
    sel = 2'b11;
    din = 4'b1010;
    #10;

    // Hold
    sel = 2'b00;
    #10;

    // Shift Right
    sel = 2'b01;
    sr = 1;
    #10;

    // Shift Right Again
    sr = 0;
    #10;

    // Shift Left
    sel = 2'b10;
    sl = 1;
    #10;

    // Shift Left Again
    sl = 0;
    #10;

    // Parallel Load
    sel = 2'b11;
    din = 4'b1101;
    #10;

    // Hold
    sel = 2'b00;
    #10;

    $finish;

end

//-----------------------------------------------------
// Monitor Output
//-----------------------------------------------------

initial
begin
    $display("------------------------------------------------------------");
    $display("Time\tReset\tSel\tDIN\tSR\tSL\tQ");
    $display("------------------------------------------------------------");

    $monitor("%0t\t%b\t%b\t%b\t%b\t%b\t%b",
              $time, reset, sel, din, sr, sl, q);
end

endmodule
