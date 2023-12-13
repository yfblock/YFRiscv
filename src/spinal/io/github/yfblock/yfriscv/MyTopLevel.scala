package io.github.yfblock.yfriscv

import spinal.core._

// Hardware definition
case class MyTopLevel() extends Component {
  val io = new Bundle {
    val leds  = out(UInt(6 bits)).setAsReg().init(U"6'b111110")
  }

  noIoPrefix()

  this.clockDomain.clock.setName("xtal_in")
  this.clockDomain.reset.setName("reset_button")

  val counter = Reg(UInt(25 bits)).init(0)
  counter := counter + 1

  when(counter === 27_000_000) {
    io.leds := io.leds.rotateLeft(1)
    counter := 0
  }
}

object MyTopLevelVerilog extends App {
  Config.spinal.generateVerilog(MyTopLevel())
}
