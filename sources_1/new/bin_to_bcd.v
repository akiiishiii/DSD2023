// bin_to_bcd.v

`timescale 1ns / 1ps

// 二进制转BCD码模块
module bin_to_bcd(
    input clk_100kHz, // 100kHz时钟信号
    input rst_, // 复位信号
    input [31:0] bin, // 32位二进制数
    output reg [3:0] bcd0,
    output reg [3:0] bcd1,
    output reg [3:0] bcd2,
    output reg [3:0] bcd3,
    output reg [3:0] bcd4,
    output reg [3:0] bcd5,
    output reg [3:0] bcd6,
    output reg [3:0] bcd7, // 8位BCD码
    output reg [7:0] en // 数显使能
    );

    reg [63:0] temp_bin; // 临时二进制数

    always @(posedge clk_100kHz or negedge rst_ ) begin
        if (!rst_) begin
            bcd0 <= 4'd0;
            bcd1 <= 4'd0;
            bcd2 <= 4'd0;
            bcd3 <= 4'd0;
            bcd4 <= 4'd0;
            bcd5 <= 4'd0;
            bcd6 <= 4'd0;
            bcd7 <= 4'd0;
            en <= 8'b00000000;
        end else begin
            temp_bin = 64'd0;
            temp_bin[31:0] = bin;
            repeat(32) begin
                if (temp_bin[35:32] >= 4'd5) begin
                    temp_bin[35:32] = temp_bin[35:32] + 4'd3;
                end
                if (temp_bin[39:36] >= 4'd5) begin
                    temp_bin[39:36] = temp_bin[39:36] + 4'd3;
                end
                if (temp_bin[43:40] >= 4'd5) begin
                    temp_bin[43:40] = temp_bin[43:40] + 4'd3;
                end
                if (temp_bin[47:44] >= 4'd5) begin
                    temp_bin[47:44] = temp_bin[47:44] + 4'd3;
                end
                if (temp_bin[51:48] >= 4'd5) begin
                    temp_bin[51:48] = temp_bin[51:48] + 4'd3;
                end
                if (temp_bin[55:52] >= 4'd5) begin
                    temp_bin[55:52] = temp_bin[55:52] + 4'd3;
                end
                if (temp_bin[59:56] >= 4'd5) begin
                    temp_bin[59:56] = temp_bin[59:56] + 4'd3;
                end
                if (temp_bin[63:60] >= 4'd5) begin
                    temp_bin[63:60] = temp_bin[63:60] + 4'd3;
                end
                temp_bin[63:0] = temp_bin[63:0] << 1;
            end
            bcd0 = temp_bin[35:32];
            bcd1 = temp_bin[39:36];
            bcd2 = temp_bin[43:40];
            bcd3 = temp_bin[47:44];
            bcd4 = temp_bin[51:48];
            bcd5 = temp_bin[55:52];
            bcd6 = temp_bin[59:56];
            bcd7 = temp_bin[63:60];
            // 判断高位数字消隐
            if (bcd7 == 4'd0) begin
                if (bcd6 == 4'd0) begin
                    if (bcd5 == 4'd0) begin
                        if (bcd4 == 4'd0) begin
                            if (bcd3 == 4'd0) begin
                                if (bcd2 == 4'd0) begin
                                    if (bcd1 == 4'd0) begin
                                        en = 8'b10000000;
                                    end else begin
                                        en = 8'b11000000;
                                    end
                                end else begin
                                    en = 8'b11100000;
                                end
                            end else begin
                                en = 8'b11110000;
                            end
                        end else begin
                            en = 8'b11111000;
                        end
                    end else begin
                        en = 8'b11111100;
                    end
                end else begin
                    en = 8'b11111110;
                end
            end else begin
                en = 8'b11111111;
            end
        end
    end

endmodule
