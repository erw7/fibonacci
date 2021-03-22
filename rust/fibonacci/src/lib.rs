pub fn fibonacci(num:i32) -> i32 {
    if num < 2 {
        num
    } else {
        fibonacci(num - 1) + fibonacci(num - 2)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn fibonacci_f0_test() {
        assert_eq!(fibonacci(0), 0);
    }

    #[test]
    fn fibonacci_f1_test() {
        assert_eq!(fibonacci(1), 1);
    }

    #[test]
    fn fibonacci_f2_test() {
        assert_eq!(fibonacci(2), 1);
    }

    #[test]
    fn fibonacci_f3_test() {
        assert_eq!(fibonacci(3), 2);
    }

    #[test]
    fn fibonacci_f4_test() {
        assert_eq!(fibonacci(4), 3);
    }

    #[test]
    fn fibonacci_f5_test() {
        assert_eq!(fibonacci(5), 5);
    }

    #[test]
    fn fibonacci_f10_test() {
        assert_eq!(fibonacci(10), 55);
    }
}
