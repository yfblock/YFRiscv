package io.github.yfblock.yfriscv

import spinal.core._

class PC extends Component {
    val io = new Bundle {
        val pc = out(Bits(GlobalConfig.dataBitsWidth bits))
    }

    val pc_reg = Reg(UInt(GlobalConfig.dataBitsWidth bits)).init(0)
    io.pc := pc_reg.asBits
    pc_reg := pc_reg + 1
}
