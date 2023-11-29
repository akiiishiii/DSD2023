// wave_generator.v

`timescale 1ns / 1ps

// 波发生器模块
module wave_generator(
    input clk_100kHz, // 100kHz时钟信号
    input rst_, // 复位信号
    input [1:0] sw, // 拨码开关
    input [7:0] freq_ctrl, // 频率控制字
    output reg [7:0] wave_out // 波输出
    );

    wire [7:0] acc_sum; // 相位累加器输出
    wire [7:0] sine_out, triangle_out, square_out, sawtooth_out; // 正弦波、三角波、方波、锯齿波输出

    // 相位累加器
    phase_accumulator phase_acc(
        .clk_100kHz(clk_100kHz),
        .rst_(rst_),
        .freq_ctrl(freq_ctrl),
        .acc_sum(acc_sum)
    );

    // 8位正弦波ROM
    sine_rom sine_rom_8_256(
        .a(acc_sum),
        .clk(clk_100kHz),
        .qspo(sine_out)
    );

    // 8位三角波ROM
    triangle_rom triangle_rom_8_256(
        .a(acc_sum),
        .clk(clk_100kHz),
        .qspo(triangle_out)
    );

    // 8位方波ROM
    square_rom square_rom_8_256(
        .a(acc_sum),
        .clk(clk_100kHz),
        .qspo(square_out)
    );

    // 8位锯齿波ROM
    sawtooth_rom sawtooth_rom_8_256(
        .a(acc_sum),
        .clk(clk_100kHz),
        .qspo(sawtooth_out)
    );

    // 选择输出波形
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
