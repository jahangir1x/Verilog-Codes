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

module synchronous_4_bit_counter(q, clock, clear);
    input clock, clear;
    output [3:0] q;

    wire [3:0] j;
    wire [3:0] k;
    wire [3:0] q_bar;
    wire and_not_q123;
    wire and_not_q1_23;
    wire and_not_q13;
    wire and_q12;
    wire and_not_q12;
    wire and_q23;
    wire and_q03;
    wire and_not_q013;
    wire and_not_q3_01;
    wire and_not_q1_03;
    wire and_not_q012;
    wire and_not_q2_01;
    wire and_not_q0_12;
    wire and_not_q12_3;

    // -------------------------0---------------------------
    and(and_not_q123, q_bar[1], q_bar[2], q_bar[3]);
    and(and_not_q1_23, q_bar[1], q[2], q[3]);
    or(j[0], and_not_q123, and_not_q1_23);

    and(and_not_q13, q_bar[1], q_bar[3]);
    and(and_q12, q[1], q[2]);
    and(and_not_q12, q_bar[1], q_bar[2]);
    or(k[0], and_not_q13, and_q12, and_not_q12);
    // ------------------------------------------------------

    // -------------------------1---------------------------
    and(and_q23, q[2], q[3]);
    and(and_q03, q[0], q[3]);
    or(j[1], and_q23, and_q03);

    or(k[1], q_bar[0], q[2], q[3]);
    // ------------------------------------------------------

    // -------------------------2---------------------------
    and(and_not_q013, q_bar[0], q_bar[1], q_bar[3]);
    and(and_not_q3_01, q_bar[3], q[0], q[1]);
    and(and_not_q1_03, q_bar[1], q[0], q[3]);
    or(j[2], and_not_q013, and_not_q3_01, and_not_q1_03);

    or(k[2], q[3], q_bar[1], q[0]);
    // ----------------------------------------------------

    // -----------------------3-----------------------------
    and(and_not_q012, q_bar[0], q_bar[1], q_bar[2]);
    and(and_not_q2_01, q_bar[2], q[0], q[1]);
    and(and_not_q0_12, q_bar[0], q[1], q[2]);
    or(j[3], and_not_q012, and_not_q2_01, and_not_q0_12);

    and(and_not_q12_3, q_bar[1], q_bar[2], q[3]);
    or(k[3], q_bar[0], and_not_q12_3, and_q12);
    // ----------------------------------------------------

    jk_flipflop jk0(q[0], q_bar[0], j[0], k[0], clock, clear);
    jk_flipflop jk1(q[1], q_bar[1], j[1], k[1], clock, clear);
    jk_flipflop jk2(q[2], q_bar[2], j[2], k[2], clock, clear);
    jk_flipflop jk3(q[3], q_bar[3], j[3], k[3], clock, clear);
endmodule
