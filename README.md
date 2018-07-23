Write two MIPS Assembly Programs:
For these programs you are expected to follow some approximation of standard conventions (e.g. pass arguments in $aX) and to have decent code formatting. There are style points to lose.

Program 1: 4-function Calculator: (calculator.asm)
Sample interaction:

    Select operation (+, -, *, or /): -
    First number: 5
    Second number: 2
    answer = 3
    -- program terminated successfully --
First, read in the operator as a string.
Then call one of four functions, to add subtract, multiply or divide as appropriate.
Each function should read in two integers (possibly using a helper function) and then return the result of the calcuation.
The main function should then print out the answer and exit.

Program 2: Fibonacci (fib.asm)
This program should read in an integer and print the corresponding Fibonacci number.

Your program should use the naive recursion strategy (a fib function that calls itself twice).

The Fibonacci function is defined as:
fib(0) = 0
fib(1) = 1
fib(x) = fib(x-1) + fib(x-2) when x > 1
