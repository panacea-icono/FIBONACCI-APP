import Foundation

// Simple demo script that shows Fibonacci functionality
print("=== FIBONACCI MEDICAL CALCULATOR DEMO ===")
print("PANACEA ICONO SA - PANAS-APP Integration")

// Manual implementation for demo (since we can't import the module directly in script)
func fibonacciAt(position: Int) -> Int {
    if position <= 1 { return position }
    var a = 0, b = 1
    for _ in 2...position {
        let temp = a + b
        a = b
        b = temp
    }
    return b
}

func fibonacciSequence(count: Int) -> [Int] {
    if count <= 0 { return [] }
    if count == 1 { return [0] }
    var sequence = [0, 1]
    for i in 2..<count {
        sequence.append(sequence[i-1] + sequence[i-2])
    }
    return sequence
}

func isFibonacci(_ number: Int) -> Bool {
    if number <= 1 { return true }
    var a = 0, b = 1
    while b < number {
        let temp = a + b
        a = b
        b = temp
    }
    return b == number
}

// Demo calculations
print("\n🏥 MEDICAL FIBONACCI CALCULATIONS")
print("Individual calculations:")
for pos in [0, 5, 10, 15] {
    print("  Position \(pos): \(fibonacciAt(position: pos))")
}

print("\nSequence for medical analysis:")
let sequence = fibonacciSequence(count: 10)
print("  \(sequence.map(String.init).joined(separator: ", "))")

print("\nPattern recognition for medical values:")
let medicalValues = [8, 13, 21, 34, 60, 89]
for value in medicalValues {
    print("  \(value): \(isFibonacci(value) ? "Natural pattern" : "Non-Fibonacci")")
}

print("\n✅ Demo complete - Ready for PANAS-APP integration!")