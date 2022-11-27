module excess_3_to_bcd(b, e);
    input  [3:0] e;

    output [3:0] b;

    wire nor_e1_e2;
    wire xnor_e0_e2;
    wire and_e1_xnor_e0_e2;
    wire and_e2_e3;
    wire and_e0_e1_e3;
    wire and_e0_e1;

    not(b[0], e[0]);
    xor(b[1], e[0], e[1]);

    nor(nor_e1_e2, e[1], e[2]);

    xnor(xnor_e0_e2, e[0], e[2]);

    and(and_e1_xnor_e0_e2, e[1], xnor_e0_e2);

    and(and_e0_e1, e[0], e[1]);

    xnor(b[2], e[2], and_e0_e1);

    and(and_e2_e3, e[2], e[3]);

    and(and_e0_e1_e3, e[0], e[1], e[3]);
    or(b[3], and_e2_e3, and_e0_e1_e3);
endmodule

module excess_3_to_bcd_test;
    reg  [3:0] e;
    wire [3:0] b;

    excess_3_to_bcd etb(b, e);

    initial begin
        #0  e = 4'b11;
        #50 e = 4'b110;
        #50 e = 4'b1010;
        #50 e = 4'b1100;
        #50 e = 4'b1110;
        #50 e = 4'b1111;
    end
endmodule