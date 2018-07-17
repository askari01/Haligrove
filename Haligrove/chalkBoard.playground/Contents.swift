import UIKit

func add1(_ x: Int, _ y: Int) -> Int {
    return x + y
}

func add2(_ x: Int) -> ((Int) -> Int) {
    return { y in x + y }
}

func add3(_ x: Int) -> (Int) -> Int {
    return { y in x + y }
}
add2(1)(2)
add3(1)(2)
