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

module up_down_counter(q, clock, clear, updown);
    input clock, clear, updown;
    output [2:0] q;

    wire updown_bar;
    wire [2:0] q_bar;
    wire and_not_updown_q12;
    wire and_updown_q12;
    wire [2:0] j;
    wire [2:0] k;

    not(updown_bar, updown);
    and(and_not_updown_q01, updown_bar, q_bar[0], q_bar[1]);
    and(and_updown_q01, updown, q[0], q[1]);
    or(j[2], and_not_updown_q01, and_updown_q01);

    and(k[2], j[2], 1);

    xnor(j[1], updown, q[0]);
    
    and(k[1], j[1], 1);

    or(j[0], 1, 1);

    or(k[0], 1, 1);

    jk_flipflop jk0(q[0], q_bar[0], j[0], k[0], clock, clear);
    jk_flipflop jk1(q[1], q_bar[1], j[1], k[1], clock, clear);
    jk_flipflop jk2(q[2], q_bar[2], j[2], k[2], clock, clear);
endmodule
