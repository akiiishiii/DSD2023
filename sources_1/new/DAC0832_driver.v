// DAC0832_driver.v

`timescale 1ns / 1ps

module DAC0832_driver(
    input clk, // 时钟信号
    input rst_, // 复位信号
    input [7:0] data_in, // 8位输入数据
    output reg ile, // 输入锁存使能信号
    output reg cs_, // 片选信号
    output reg wr1_, // 写使能信号
    output reg wr2_, // 写使能信号
    output reg xfer_, // 传输信号
    output reg [7:0] data_out // 8位输出数据
    );

    always @(posedge clk or negedge rst_ ) begin
        if (!rst_) begin
            ile <= 1'b0; // 复位时，禁用输入锁存
            cs_ <= 1'b1; // 复位时，禁用DAC0832
            wr1_ <= 1'b1; // 复位时，禁用写操作
            wr2_ <= 1'b1; // 复位时，禁用写操作
            xfer_ <= 1'b1; // 复位时，禁用传输
            data_out <= 8'd0; // 复位时，输出数据为0
        end else begin
            ile <= 1'b1; // 使能输入锁存
            cs_ <= 1'b0; // 使能DAC0832
            wr1_ <= 1'b0; // 使能写操作
            wr2_ <= 1'b0; // 使能写操作
            xfer_ <= 1'b0; // 使能传输
            data_out <= data_in; // 将输入数据传递给DAC0832
        end
    end
endmodule
