import cocotb, cocotb.clock
from cocotb.triggers import ClockCycles

@cocotb.test()
async def test_main(dut):
    cocotb.start_soon(cocotb.clock.Clock(dut.clock, 10).start())

    async def wait_cycle():
        await ClockCycles(dut.clock, 1, rising=False)

    dut.reset.value = 1
    await wait_cycle()
    dut.reset.value = 0

    for _ in range(10):
        await wait_cycle()

