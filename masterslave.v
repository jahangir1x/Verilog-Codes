module jk_flipflop_orig(q, qbar, j, k, clk, clr);
input j,k,clk,clr;
output q,qbar;
wire a,b,c,d,y,ybar,cbar;

nand(a,j,clr,clk,qbar);
nand(b,clk, k,q);

nand(y,ybar ,a);
nand(ybar,b,clr,y);

not(cbar,clk);

nand(c,cbar,y);
nand(d,ybar,cbar);
nand(q,c,qbar);
nand(qbar,q,clr,d);
endmodule

module jk_stimulus;
    wire q, qbar;
    reg j, k, clk, clr;

    jk_flipflop jk(q, qbar, j, k, clk, clr);

    initial
        clk = 1'b0;
    always
        #5 clk = ~clk;
    initial begin
        clr = 1'b0;
        j = 1'b0;
        k = 1'b0;
        #5 clr = 1'b1;
        #10 j = 1'b1;
        k = 1'b1;
        #50 $finish;
    end

    initial
        $monitor($time, " Output q = %d", q);
endmodule
