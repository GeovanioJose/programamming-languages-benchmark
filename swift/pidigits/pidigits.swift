import BigInt

// Get command line options
let n: UInt
if CommandLine.argc > 1 {
    n = UInt(CommandLine.arguments[1]) ?? 50
} else {
    n = 50
}

// Allocate numbers and defer their destruction
var acc = BigInt(0)
var den = BigInt(1)
var num = BigInt(1)

func extractDigit(_ n: UInt) -> UInt {
    let tmp1 = num * BigInt(n)
    let tmp2 = tmp1 + acc
    return tmp2.quotientAndRemainder(dividingBy: den).quotient.toUIntMax()
}

func eliminateDigit(_ d: UInt) {
    acc -= BigInt(d) * den
    acc *= BigInt(10)
    num *= BigInt(10)
}

func nextTerm(_ k: UInt) {
    let k2 = 2 * k + 1
    acc += num * BigInt(2)
    acc *= BigInt(k2)
    den *= BigInt(k2)
    num *= BigInt(k)
}

var d: UInt
var d4: UInt
var k: UInt = 0
var i: UInt = 0

// Generate digits
for i in 1...n {
    repeat {
        repeat {
            k += 1
            nextTerm(k)
        } while num > acc

        d = extractDigit(3)
        d4 = extractDigit(4)
    } while d != d4

    // Output digit
    print("\(d)", terminator: "")
    if i % 10 == 0 {
        print("\t:\(i)")
    }

    eliminateDigit(d)
}

if n % 10 != 0 {
    for _ in 0..<(10 - (n % 10)) {
        print(" ", terminator: "")
    }
    print("\t:\(n)")
}
