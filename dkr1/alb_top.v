`timescale 1ns / 1ps

module alb_top #(parameter W = 10) (
    input wire clk,
    input wire reset,
    input wire [W-1:0] A_ALB,
    input wire [W-1:0] B_ALB,
    input wire CI,
    input wire [1:0] ALB_MI,
    output reg [W-1:0] F_ALB,
    output reg CO,
    output reg VO,
    output reg NO,
    output reg ZO
);

    reg [W-1:0] RgA;
    reg [W-1:0] RgB;
    
    reg [W-1:0] F_next;
    reg [W-1:0] F_post; 
    reg CO_next, VO_next, NO_next, ZO_next;
    reg [W:0] temp_res;

    // ?????? ????????
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            RgA <= 0;
            RgB <= 0;
        end else begin
            RgA <= A_ALB;
            RgB <= B_ALB;
        end
    end

    // ???????????? ?????? ???
    always @(*) begin
        F_next = 0;
        CO_next = 0;
        VO_next = 0;
        temp_res = 0;
        
        case(ALB_MI)
            2'b00: begin // R V S (??????? ???)
                F_next = RgA | RgB;
            end
            2'b01: begin // R + S + CI (?????????)
                temp_res = RgA + RgB + CI;
                F_next = temp_res[W-1:0];
                CO_next = temp_res[W];
                VO_next = (RgA[W-1] == RgB[W-1]) && (F_next[W-1] != RgA[W-1]); 
            end
            2'b10: begin // S - R - 1 + CI (??????????)
                temp_res = RgB - RgA - 1 + CI;
                F_next = temp_res[W-1:0];
                CO_next = temp_res[W];
                VO_next = (RgB[W-1] != RgA[W-1]) && (F_next[W-1] != RgB[W-1]);
            end
            2'b11: begin // ~(R ^ S) (??????????????? - XNOR ?? ????????? 4423)
                F_next = ~(RgA ^ RgB);
            end
        endcase


        if (VO_next == 1'b1) begin
           
            F_post = {~F_next[W-1], F_next[W-1:1]};
        end else begin
            F_post = F_next;
        end

        NO_next = F_post[W-1];
        ZO_next = (F_post == 0) ? 1'b1 : 1'b0;
    end

    // ???????? ???????
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            F_ALB <= 0;
            CO <= 0;
            VO <= 0;
            NO <= 0;
            ZO <= 0;
        end else begin
            F_ALB <= F_post; 
            CO <= CO_next;
            VO <= VO_next;
            NO <= NO_next;
            ZO <= ZO_next;
        end
    end

endmodule
