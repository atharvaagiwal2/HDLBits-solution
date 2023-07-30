module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss
);

    always @(posedge clk)
    begin
        if (reset)
        begin
            hh <= 8'h12;
            mm <= 0;
            ss <= 0;
            pm <= 0;
        end
        else begin
            if (ena) begin
                pm <= (hh == 8'h11 && mm == 8'h59 && ss == 8'h59) ^ pm;
                if (ss == 8'h59) begin
                    ss <= 0;
                    if (mm == 8'h59) begin
                        mm <= 0;
                        if (hh == 8'h12)
                            hh <= 8'h01;
                        else begin
                            if (hh[3:0] == 4'h9) begin
                                hh[3:0] <= 0;
                                hh[7:4] <= hh[7:4] + 4'h1;
                            end
                            else
                                hh <= hh + 8'h1;
                        end
                    end
                    else begin
                        if (mm[3:0] == 4'h9) begin
                            mm[3:0] <= 0;
                            mm[7:4] <= mm[7:4] + 4'h1;
                        end
                        else
                            mm <= mm + 8'h1;
                    end
                end
                else begin
                    if (ss[3:0] == 4'h9) begin
                        ss[3:0] <= 0;
                        ss[7:4] <= ss[7:4] + 4'h1;
                    end
                    else
                        ss <= ss + 8'h1;
                end
            end
        end
    end
endmodule
