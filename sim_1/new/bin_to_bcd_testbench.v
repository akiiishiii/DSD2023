// bin_to_bcd_testbench.v

`timescale 1ns / 1ps

// ������תBCD�����ģ��
module bin_to_bcd_testbench();
    reg clk_100kHz; // 100kHzʱ���ź�
    reg rst_; // ��λ�ź�
    reg [31:0] bin; // 32λ��������
    wire [3:0] bcd0;
    wire [3:0] bcd1;
    wire [3:0] bcd2;
    wire [3:0] bcd3;
    wire [3:0] bcd4;
    wire [3:0] bcd5;
    wire [3:0] bcd6;
    wire [3:0] bcd7; // 8λBCD��
    wire [7:0] en; // ����ʹ��

    initial begin
        clk_100kHz = 1'b0;
        forever #5 clk_100kHz = ~clk_100kHz;
    end

    initial begin
        rst_ = 1'b0;
        bin = 32'd0;
        #20 rst_ = 1'b1;
        forever
            #100 bin = bin + 10;
            if (bin == 32'd99999999)
                $finish;
    end

    bin_to_bcd bin_to_bcd_0(
        .clk_100kHz(clk_100kHz),
        .rst_(rst_),
        .bin(bin),
        .bcd0(bcd0),
        .bcd1(bcd1),
        .bcd2(bcd2),
        .bcd3(bcd3),
        .bcd4(bcd4),
        .bcd5(bcd5),
        .bcd6(bcd6),
        .bcd7(bcd7),
        .en(en)
        );

endmodule
