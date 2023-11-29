// DAC0832_driver.v

`timescale 1ns / 1ps

module DAC0832_driver(
    input clk, // ʱ���ź�
    input rst_, // ��λ�ź�
    input [7:0] data_in, // 8λ��������
    output reg ile, // ��������ʹ���ź�
    output reg cs_, // Ƭѡ�ź�
    output reg wr1_, // дʹ���ź�
    output reg wr2_, // дʹ���ź�
    output reg xfer_, // �����ź�
    output reg [7:0] data_out // 8λ�������
    );

    always @(posedge clk or negedge rst_ ) begin
        if (!rst_) begin
            ile <= 1'b0; // ��λʱ��������������
            cs_ <= 1'b1; // ��λʱ������DAC0832
            wr1_ <= 1'b1; // ��λʱ������д����
            wr2_ <= 1'b1; // ��λʱ������д����
            xfer_ <= 1'b1; // ��λʱ�����ô���
            data_out <= 8'd0; // ��λʱ���������Ϊ0
        end else begin
            ile <= 1'b1; // ʹ����������
            cs_ <= 1'b0; // ʹ��DAC0832
            wr1_ <= 1'b0; // ʹ��д����
            wr2_ <= 1'b0; // ʹ��д����
            xfer_ <= 1'b0; // ʹ�ܴ���
            data_out <= data_in; // ���������ݴ��ݸ�DAC0832
        end
    end
endmodule
