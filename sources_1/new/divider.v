// divider.v

`timescale 1ns / 1ps

// �ɵ���Ƶ���ӵķ�Ƶ��ģ��
module divider(
    input clk_in, // ����ʱ��
    input rst_, // ��λ�ź�
    input [31:0] div_factor, // ��Ƶ����
    output reg clk_out // ���ʱ��
    );

    reg [31:0] counter = 0; // ������

    always @(posedge clk_in or negedge rst_ ) begin
        if (!rst_) begin
            clk_out = 0; // ��λ���ʱ��
            counter = 0; // ��λ������
        end else if (counter == div_factor[31:1] - 1) begin
            clk_out = ~clk_out; // �л����ʱ��״̬
            counter = 0; // ���ü�����
        end else begin
            counter = counter + 1; // ���Ӽ�������ֵ
        end
    end

endmodule
