//
//  main.swift
//  Closure
//
//  Created by Kaden Kim on 2020-05-12.
//  Copyright © 2020 CICCC. All rights reserved.
//

import Foundation

// Closure?
// - block of code you can execute - function without a name
// - ref type

func sun(numbers: [Int]) -> Int {
    var res = 0
    for num in numbers {
        res += num
    }
    return res
}

let sumClosure = { (numbers: [Int]) -> Int in
    var res = 0
    for num in numbers {
        res += num
    }
    return res
}

let randomNumberClosure = { (minVal: Int, maxVal: Int) -> Int in
    return Int.random(in: minVal...maxVal)
}

// 1. type inference
let simplifiedClosure1 = { (minVal, maxVal) in
    return Int.random(in: minVal...maxVal)
}

// 2. syntactic sugar
let simplifiedClosure2: ((Int, Int) -> Int) = { Int.random(in: $0...$1)}


// Collection functions using closures - higher order function
// - map
// - filter
// - reduce

// 1. map
let firstNames = ["Johnny", "Aaron", "Rachel", "Nellie"] // "{} Smith"

var fullNames = [String]()
for name in firstNames {
    fullNames.append("\(name) Smith")
}
print(fullNames)

fullNames = firstNames.map { (name) -> String in
    return name + " Smith"
}
print(fullNames)

fullNames = firstNames.map { $0 + " Smith" }
print(fullNames)

// 2. filter
let numbers = [4, 8, 15, 16, 23, 42]

var numbersLessThan20 = [Int]()

for num in numbers {
    if num < 20 {
        numbersLessThan20.append(num)
    }
}
print(numbersLessThan20)

numbersLessThan20 = numbers.filter { (num) -> Bool in
    return num < 20
}
print(numbersLessThan20)

numbersLessThan20 = numbers.filter { $0 < 20 }
print(numbersLessThan20)

// 3. reduce
let nums = [8, 6, 7, 5, 3, 0, 9]
var total = 0
for num in nums {
    total += num
}
print(total)

total = nums.reduce(0) { (currentTotal, newValue) -> Int in
    return currentTotal + newValue
}
print(total)

total = nums.reduce(0) { return $0 + $1 }
print(total)
