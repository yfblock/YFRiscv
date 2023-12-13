#![no_std]
#![no_main]
use core::panic::PanicInfo;


#[no_mangle]
unsafe extern "C" fn _start() {
    let t = 0x30000 as * mut u8;
    *t = 4;
}

// 程序遇到错误
#[panic_handler]
fn panic_handler(_info: &PanicInfo) -> ! {
    loop {}
}
