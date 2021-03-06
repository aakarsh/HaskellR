# ------------------------------------------------------------------
# The Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# Contributed by Leo Osvald
# ------------------------------------------------------------------

lim <- 2
iter <- 50
# Turn off warnings that appear on Windows, so that we can compare
# the output without the warning messages.
options ( warn = -1)

mandelbrot_noout <- function(args) {
    # Turn off warnings that appear on Windows, so that we can compare
    # the output without the warning messages.
    options ( warn = -1)
    n = if (length(args)) as.integer(args[[1]]) else 200L
    n_mod8 = n %% 8L
    pads <- if (n_mod8) rep.int(0, 8L - n_mod8) else integer(0)
    p <- rep(as.integer(rep.int(2, 8) ^ (7:0)), length.out=n)

    cat("P4\n")
    cat(n, n, "\n")
    for (y in 0:(n-1)) {
        c <- 2 * 0:(n-1) / n - 1.5 + 1i * (2 * y / n - 1)
        z <- rep(0+0i, n)
        i <- 0L
        while (i < 50) {  # faster than for loop
            z <- z * z + c
            i <- i + 1L
        }
        bits <- as.integer(abs(z) <= 2)
        bytes <- as.raw(colSums(matrix(c(bits * p, pads), 8L)))
    }
}

if (!exists("i_am_wrapper"))
    mandelbrot_noout(commandArgs(trailingOnly=TRUE))
