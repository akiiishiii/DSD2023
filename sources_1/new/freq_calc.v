// freq_calc.v

`timescale 1ns / 1ps

// ����Ƶ�ʼ���ģ��
module freq_calc(
    input clk_100kHz, // 100kHzʱ���ź�
    input rst_, // ��λ�ź�
    input [7:0] freq_ctrl, // Ƶ�ʿ�����
    output reg [31:0] freq_theory // ����Ƶ��
    );

    integer i = 0; // ѭ������
    reg [31:0] temp_freq;

    always @(posedge clk_100kHz or negedge rst_ ) begin
        if (!rst_) begin
            freq_theory <= 32'd0; // ��λʱ������Ƶ�����0
        end else begin
            temp_freq = 32'd0;
            for (i = 0; i < freq_ctrl; i = i + 1) begin
                temp_freq = temp_freq + 'd100000; // ����Ƶ�ʼ���
            end
            temp_freq = temp_freq >> 'd8; // ����Ƶ�ʼ���
            freq_theory <= temp_freq; // ����Ƶ�����
        end
    end

endmodule
