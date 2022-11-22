module jk_flipflop(q, q_bar, j, k, clock, clear);
    input j, k, clock, clear;
    output q, q_bar;

    wire cbar, a, b, y, ybar, c, d;

    not(cbar, clock);
    nand(a, q_bar, j, clock, clear);
    nand(b, clock, k, q);
    nand(y, a, ybar);
    nand(ybar, y, clear, b);
    nand(c, y, cbar);
    nand(d, cbar, ybar);
    nand(q, c, q_bar);
    nand(q_bar, q, clear, d);
endmodule

module mod_10_counter(q, clock, clear);
    input clock, clear;
    output [3:0] q;

    wire [3:0] q_bar;

    jk_flipflop jk3(q[0], q_bar[0], 1, 1, clock, clear);
    jk_flipflop jk2(q[1], q_bar[1], 1, 1, q[0], clear);
    jk_flipflop jk1(q[2], q_bar[2], 1, 1, q[1], clear);
    jk_flipflop jk0(q[3], q_bar[3], 1, 1, q[2], clear);

    nand(clear, q[1], q[3]);
endmodule
