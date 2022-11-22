module full_adder(s, c_out, a, b, c_in);
    input a, b, c_in;
    output s, c_out;

    wire and_a_b, and_b_c, and_c_a;

    xor(s, a, b, c_in);

    and(and_a_b, a, b);
    and(and_b_c, b, c_in);
    and(and_c_a, c_in, a);
    
    or(c_out, and_a_b, and_b_c, and_c_a);
endmodule

module four_bit_full_adder(s, c_out, a, b, mode);
    input mode;
    input [3:0] a;
    input [3:0] b;

    output c_out;
    output [3:0] s;

    wire [3:0] complement;
    wire [3:1] c;

    xor(complement[0], b[0], mode);
    xor(complement[1], b[1], mode);
    xor(complement[2], b[2], mode);
    xor(complement[3], b[3], mode);

    full_adder fa0(s[0], c[1], a[0], complement[0], mode);
    full_adder fa1(s[1], c[2], a[1], complement[1], c[1]);
    full_adder fa2(s[2], c[3], a[2], complement[2], c[2]);
    full_adder fa3(s[3], c_out, a[3], complement[3], c[3]);
endmodule

module four_bit_full_adder_test;
    reg [3:0] a;
    reg [3:0] b;
    reg mode;

    wire c_out;
    wire [3:0] sum;

    four_bit_full_adder fbfa(sum, c_out, a, b, mode);

    initial begin
        #0  a = 4'b11;   b = 4'b1;    mode = 0; // 4
        #50 a = 4'b100;  b = 4'b10;   mode = 0; // 6
        #50 a = 4'b101;  b = 4'b110;  mode = 0; // 11
        #50 a = 4'b110;  b = 4'b111;  mode = 0; // 13
        #50 a = 4'b111;  b = 4'b1000; mode = 0; // 15
        #50 a = 4'b1001; b = 4'b1000; mode = 1; // 1
        #50 a = 4'b1001; b = 4'b11;   mode = 1; // 6
        #50 a = 4'b1100; b = 4'b1000; mode = 1; // 4
        #50 a = 4'b1100; b = 4'b11;   mode = 1; // 9
    end
endmodule