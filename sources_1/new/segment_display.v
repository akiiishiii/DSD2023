// segment_display.v

`timescale 1ns / 1ps

// 七段显示器模块
module segment_display(
    input clk_1kHz, // 输入时钟
    input rst_, // 复位信号
    input [3:0] en, // 启用信号
    input [3:0] bin0, // 二进制输入0
    input [3:0] bin1, // 二进制输入1
    input [3:0] bin2, // 二进制输入2
    input [3:0] bin3, // 二进制输入3
    input [3:0] dpin, // 小数点输入
    output reg [7:0] seg, // 七段显示器输出
    output reg [3:0] an // 片选输出
    );

    reg [3:0] digout; // 数字输出
    reg dp; // 小数点
    reg [1:0] counter; // 计数器

    always @(posedge clk_1kHz or negedge rst_ ) begin
        if (!rst_) begin
            counter <= 0; // 复位计数器
            an <= 4'b0000; // 复位片选输出
        end else begin
            counter <= counter + 1; // 增加计数器的值
            an <= 4'b0000; // 默认不输出
            case (counter)
                2'b00: begin
                    digout = bin0; // 输出二进制输入0
                    dp = dpin[0]; // 输出小数点输入0
                end
                2'b01: begin
                    digout = bin1; // 输出二进制输入1
                    dp = dpin[1]; // 输出小数点输入1
                end
                2'b10: begin
                    digout = bin2; // 输出二进制输入2
                    dp = dpin[2]; // 输出小数点输入2
                end
                2'b11: begin
                    digout = bin3; // 输出二进制输入3
                    dp = dpin[3]; // 输出小数点输入3
                end
                default: begin
                    digout = 4'b0000; // 默认输出0
                    dp = 1'b0; // 默认小数点输出0
                end
            endcase
            if(en[counter] == 1)
                an[counter] <= 1; // 如果启用信号为1则输出
        end
    end

    // 七段显示器输出逻辑
    always @(*) begin
        case(digout)
            // 对应每个数字的七段显示器编码
            4'h0: seg[6:0] = 7'b1111110;
            4'h1: seg[6:0] = 7'b0110000;
            4'h2: seg[6:0] = 7'b1101101;
            4'h3: seg[6:0] = 7'b1111001;
            4'h4: seg[6:0] = 7'b0110011;
            4'h5: seg[6:0] = 7'b1011011;
            4'h6: seg[6:0] = 7'b1011111;
            4'h7: seg[6:0] = 7'b1110000;
            4'h8: seg[6:0] = 7'b1111111;
            4'h9: seg[6:0] = 7'b1111011;
            4'ha: seg[6:0] = 7'b1110111;
            4'hb: seg[6:0] = 7'b0011111;
            4'hc: seg[6:0] = 7'b1001110;
            4'hd: seg[6:0] = 7'b0111101;
            4'he: seg[6:0] = 7'b1001111;
            4'hf: seg[6:0] = 7'b1000111;
            default: seg[6:0] = 7'b0000000; // 默认输出0
        endcase
        seg[7] = dp; // 输出小数点
    end

endmodule
