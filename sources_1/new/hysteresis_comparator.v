// hysteresis_comparator.v

`timescale 1ns / 1ps

// 滞回比较器
module hysteresis_comparator(
    input rst_, // 复位信号
    input [7:0] wave, // 输入的数字波形
    output square_wave // 输出的方波
    );

    reg high_threshold_reached; // 高阈值达到标志

    always @(*) begin
        if (!rst_) begin
            high_threshold_reached <= 0;
        end else if (wave > 8'd128) begin
            high_threshold_reached <= 1;
        end else begin
            high_threshold_reached <= 0;
        end
    end

    assign square_wave = high_threshold_reached;

endmodule
