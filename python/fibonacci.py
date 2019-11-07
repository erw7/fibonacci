from benchmarker import Benchmarker


def f(n):
    if n < 2:
        return n
    else:
        return f(n - 1) + f(n - 2)


def main():
    with Benchmarker(width = 1) as bench:

        @bench("fibonacci(34):")
        def _(bm):
            for i in bm:
                print("{0}".format(f(34)))


if __name__ == '__main__':
    main()
