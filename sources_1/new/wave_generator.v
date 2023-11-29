// wave_generator.v

`timescale 1ns / 1ps

// ��������ģ��
module wave_generator(
    input clk_100kHz, // 100kHzʱ���ź�
    input rst_, // ��λ�ź�
    input [1:0] sw, // ���뿪��
    input [7:0] freq_ctrl, // Ƶ�ʿ�����
    output reg [7:0] wave_out // �����
    );

    wire [7:0] acc_sum; // ��λ�ۼ������
    wire [7:0] sine_out, triangle_out, square_out, sawtooth_out; // ���Ҳ������ǲ�����������ݲ����

    // ��λ�ۼ���
    phase_accumulator phase_acc(
        .clk_100kHz(clk_100kHz),
        .rst_(rst_),
        .freq_ctrl(freq_ctrl),
        .acc_sum(acc_sum)
    );

    // 8λ���Ҳ�ROM
    sine_rom sine_rom_8_256(
        .a(acc_sum),
        .clk(clk_100kHz),
        .qspo(sine_out)
    );

    // 8λ���ǲ�ROM
    triangle_rom triangle_rom_8_256(
        .a(acc_sum),
        .clk(clk_100kHz),
        .qspo(triangle_out)
    );

    // 8λ����ROM
    square_rom square_rom_8_256(
        .a(acc_sum),
        .clk(clk_100kHz),
        .qspo(square_out)
    );

    // 8λ��ݲ�ROM
    sawtooth_rom sawtooth_rom_8_256(
        .a(acc_sum),
        .clk(clk_100kHz),
        .qspo(sawtooth_out)
    );

    // ѡ���������
    always @(posedge clk_100kHz or negedge rst_ ) begin
        if (!rst_) begin
            wave_out = 8'd0;
        end else begin
            case (sw)
                8'd0: wave_out = sine_out;
                8'd1: wave_out = triangle_out;
                8'd2: wave_out = square_out;
                8'd3: wave_out = sawtooth_out;
                default: wave_out = 8'd0;
            endcase
        end
    end

endmodule
