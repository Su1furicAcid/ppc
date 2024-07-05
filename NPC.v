`include "ctrl_encode_def.v"

module NPC(PC, NPCOp, IMM, NPC, RD1, PCWrite);  // next pc module
    
   input  [31:0] PC;        // pc
   input  [2:0]  NPCOp;     // next pc operation
   input  [31:0] IMM;       // immediate
	input [31:0] RD1;
   output reg [31:0] NPC;   // next pc
   input  PCWrite;
   
   // definite the adder

   wire [31:0] PCPLUS4;
   
   assign PCPLUS4 = PC + 4; // pc + 4
   
   always @(*) begin
      if (PCWrite) begin
         case (NPCOp)
            `NPC_PLUS4: NPC <= PCPLUS4;
            `NPC_BRANCH: NPC <= PC + IMM;
            `NPC_JUMP: NPC <= PC + IMM;
            `NPC_JALR: NPC <= RD1 + IMM;
            default: NPC <= PCPLUS4;
         endcase
      end else begin
         NPC <= PC;
      end
   end
   
endmodule
