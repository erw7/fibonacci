#![feature(test)]

extern crate test;

#[bench]
fn fibonacci_bench(b: &mut test::Bencher) {
    b.iter( || fibonacci::fibonacci(32));
}
