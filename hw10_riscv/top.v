module top(
  input wire reset,
  input wire clock
);
  localparam WORD_COUNT = 65536;
  localparam INIT_FILE = "memory.bin";

  reg [31:0] storage [0:WORD_COUNT - 1];
  initial begin
    integer file;
    integer status;
    integer i;
    reg [31:0] temp;
    file = $fopen(INIT_FILE, "rb");
    if (file) begin
      status = $fread(storage, file);
      $fclose(file);
      // Byte reverse each word after loading
      for (i = 0; i < WORD_COUNT; i = i + 1) begin
        temp = storage[i];
        for (integer j = 0; j < 4; j = j + 1) begin
          storage[i][(j+1)*8-1 -: 8] = temp[(32-j*8-1) -: 8];
        end
      end
    end else begin
      $display("Error: Could not open file %s", INIT_FILE);
      $finish;
    end
  end

  reg [15:0] counter;
  always @(posedge clock) begin
    if (reset) begin
      counter = 0;
    end else begin
      counter <= counter + 1;
      $display("IP: %h Instruction: %h", counter, storage[counter]);
    end
  end
endmodule

