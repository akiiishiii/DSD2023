// phase_accumulator.v

`timescale 1ns / 1ps

// ��λ�ۼ���ģ��
module phase_accumulator(
    input clk_100kHz, // 100kHzʱ���ź�
    input rst_, // ��λ�ź�
    input [7:0] freq_ctrl, // Ƶ�ʿ�����
    output reg [7:0] acc_sum // Nλ�ۼӺ�
    );

    always @(posedge clk_100kHz or negedge rst_ ) begin
        if (!rst_) begin
            acc_sum <= 8'd0; // ��λʱ���ۼӺ�Ϊ0
        end else begin
            acc_sum <= acc_sum + freq_ctrl; // ÿ��ʱ�����ڣ��ۼӺ�����Ƶ�ʿ�����
        end
    end

endmodule
