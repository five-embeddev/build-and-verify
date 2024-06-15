#![no_std]
#![no_main]

use core::panic::PanicInfo;

//fn main() {
//    // Statements here are executed when the compiled binary is called
//
//    // Print text to the console
//    //    println!("Hello World!");
//}

// error: `#[panic_handler]` function required, but not found
#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {

    loop {}
}

#[no_mangle]
pub extern "C" fn _start() -> ! {
    loop {}
}
