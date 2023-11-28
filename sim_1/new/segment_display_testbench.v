// segment_display_testbench.v

`timescale 1ns / 1ps
`define Clock 10 // ����ʱ������Ϊ10ns

// �߶���ʾ������ģ��
module segment_display_testbench();
    reg clk_1kHz; // 1kHzʱ���ź�
    reg rst_; // ��λ�ź�
    wire [3:0] an1, an2; // Ƭѡ���
    wire [6:0] seg1, seg2; // �߶���ʾ�����
    wire dp1, dp2; // С�������

    // ��ʼ������
    initial begin
        clk_1kHz = 0; // ��ʼ��ʱ��Ϊ0
        rst_ = 0; #(`Clock * 40 + 1); // ��λ�ź��ӳ�40��ʱ�����ں��Ϊ1
        rst_ = 1;
        forever
            #(500000) clk_1kHz = ~clk_1kHz; // ����1kHzʱ���ź�
    end

    // ʵ������ߵ��߶���ʾ��
    segment_display segmentl(
        .clk_1kHz(clk_1kHz),
        .rst_(rst_),
        .en(4'b1111), // �������ж�
        .bin0(4'hd), // ��������d
        .bin1(4'h9), // ��������9����g
        .bin2(4'h2), // ��������2
        .bin3(4'h1), // ��������1
        .dpin(4'b1000), // С�����ڵ�һλ
        .an(an1), // Ƭѡ���
        .seg({dp1,seg1}) // �߶���ʾ����С�������
    );

    // ʵ�����ұߵ��߶���ʾ��
    segment_display segmentr(
        .clk_1kHz(clk_1kHz),
        .rst_(rst_),
        .en(4'b1111), // �������ж�
        .bin0(4'h0), // ��������0
        .bin1(4'h1), // ��������1
        .bin2(4'h2), // ��������2
        .bin3(4'h3), // ��������3
        .dpin(4'b0000), // С�����ڵ�һλ
        .an(an2), // Ƭѡ���
        .seg({dp2,seg2}) // �߶���ʾ����С�������
    );

endmodule
