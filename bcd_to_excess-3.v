module bcd_to_excess_3(e, b);
    input  [3:0] b;

    output [3:0] e;

    wire or_b0_b1;
    wire and_orb0b1_b2;

    not(e[0], b[0]);
    xnor(e[1], b[0], b[1]);

    or(or_b0_b1, b[0], b[1]);
    xor(e[2], b[2], or_b0_b1);

    and(and_orb0b1_b2, or_b0_b1, b[2]);
    or(e[3], b[3], and_orb0b1_b2);
endmodule

module bcd_to_excess_3_test;
    reg  [3:0] b;
    wire [3:0] e;

    bcd_to_excess_3 bte(e, b);

    initial begin
        #0  b = 4'b0000;
        #50 b = 4'b100;
        #50 b = 4'b101;
        #50 b = 4'b111;
        #50 b = 4'b1001;
        #50 b = 4'b1101;
    end
endmodule