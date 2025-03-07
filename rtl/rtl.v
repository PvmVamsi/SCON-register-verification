/*  Specification:
 *
The “SCON (Serial Control) register” in the 8051 microcontroller is an 8-bit register used to configure and control the serial communication functionality via the UART. It allows selection of different serial modes (Mode 0 to Mode 3) and manages essential features like enabling reception, handling 9-bit data communication, and controlling interrupts for transmission and reception. The register also includes flags for the transmission complete (“TI”) and reception complete (“RI”) interrupts, ensuring smooth serial data transfer operations.
*/


  module SCON (
    input  clk,           // Clock signal
    input  reset,         // Reset signal
    input  [1:0] mode,    // Serial mode (SM0, SM1)
    input  ren,           // Receive enable (REN)
    input  tb8_set,       // Set TB8 bit (9th transmit bit)
    input  rb8_receive,   // Set RB8 bit (9th receive bit)
    input  tx_complete,   // Transmission complete flag (sets TI)
    input  rx_complete,   // Reception complete flag (sets RI)
    output reg [7:0] scon     // Serial Control Register (SCON)
);

    // SCON Bits:
    // scon[7]: SM0  (Serial mode bit 0)
    // scon[6]: SM1  (Serial mode bit 1)
    // scon[5]: REN  (Receive Enable)
    // scon[4]: TB8  (Transmit 9th data bit)
    // scon[3]: RB8  (Receive 9th data bit)
    // scon[2]: TI   (Transmit Interrupt Flag)
    // scon[1]: RI   (Receive Interrupt Flag)

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            scon <= 8'b0000_0000; // Reset SCON register

     end else begin
            // Serial Mode Control
            scon[7:6] <= mode;

            // Receive Enable
            scon[5] <= ren;

            // Transmit 9th bit (TB8)
            if (tb8_set)
                scon[4] <= 1'b1;
            else
                scon[4] <= 1'b0;

            // Receive 9th bit (RB8)
            if (rb8_receive)
                scon[3] <= 1'b1;
            else
                scon[3] <= 1'b0;

            // Transmit Interrupt Flag (TI)
            if (tx_complete)
                scon[2] <= 1'b1; // Set TI when transmission completes
            else
                scon[2] <= 1'b0;

            // Receive Interrupt Flag (RI)
            if (rx_complete)
 		scon[1] <= 1'b1; // Set RI when reception completes
            else
                scon[1] <= 1'b0;
        end
    end
endmodule
