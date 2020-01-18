`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:     Indiana University
// Engineer:    Dmitrii Galantsev
//
// Module Name: tb
// Project Name:
// Description: testbench
//
//////////////////////////////////////////////////////////////////////////////////

module testbench ();

    reg RESETN, CLK;

    // inst DUT here

    // a simple macro to replace delaying by #N*2
    `define clk(N) repeat (N) @(posedge CLK);

    initial forever
    #1 CLK = !CLK;

    initial begin
        CLK             = 0;
        RESETN          = 0;


        `clk(50);
        RESETN          = 1;

        `clk(1);
        $stop();

        `clk(100);
        $finish();
    end

    // Assert examples:
    //
    //// anonymous assert property
    //// The RHS is evaluated on the same cycle as LHS
    //full_empty_chk: assert property
    //(@(posedge CLK) disable iff (!RESETN)
    //    empty |-> !full);


    //// named assert property
    //// The RHS is evaluated on the same cycle as LHS
    //property empty_full_chk;
    //    @(posedge CLK) disable iff (!RESETN)
    //    full |-> !empty;
    //endproperty
    //// instantiate
    //empty_full_chk_inst: assert property (empty_full_chk);

endmodule
