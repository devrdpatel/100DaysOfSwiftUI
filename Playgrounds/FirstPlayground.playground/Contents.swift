//import UIKit
//
//for i in 1...100 {
//    if i % 15 == 0 {
//        print("FizzBuzz")
//    }
//    else if i % 5 == 0 {
//        print("Buzz")
//    }
//    else if i % 3 == 0 {
//        print("Fizz")
//    }
//    else {
//        print("\(i)")
//    }
//}

/*
enum NumError: Error {
    case outOfRange, hasNoRoot
}

func calculateRoot(_ number: Int) throws -> Int {
    if number <= 0 || number > 10_000 {
        throw NumError.outOfRange
    }
    
    for i in 1...100 {
        if i * i == number {
            return i
        }
    }
    
    throw NumError.hasNoRoot
}

let x = 10000
let y = 1
let z = -1
let k = 169
let invalid = 8
do {
    print("Square Root of \(x) is : \(try calculateRoot(x))")
    print("Square Root of \(x) is : \(try calculateRoot(y))")
    // print("Square Root of \(x) is : \(try calculateRoot(z))")
    print("Square Root of \(x) is : \(try calculateRoot(k))")
    print("Square Root of \(x) is : \(try calculateRoot(invalid))")
} catch NumError.outOfRange {
    print("The number must be in the range of 1 to 10,000")
} catch NumError.hasNoRoot {
    print("This number doesn't have an Integer square root")
}
*/

/*
var luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

print(luckyNumbers.filter { !$0.isMultiple(of: 2)}
    .sorted().map {"\($0) is a lucky number"}.joined(separator: "\n"))
*/

//struct Car {
//    let model: String
//    let numSeats: Int
//    private(set) var curGear: Int = 1
//
//    init(model: String, numSeats: Int) {
//        self.model = model
//        self.numSeats = numSeats
//    }
//
//    mutating func changeGear(gear newGear: Int) {
//        if newGear <= 0 || newGear > 10 {
//            print("That's not a valid gear")
//        } else if curGear == newGear {
//            print("Same gear")
//        } else {
//            self.curGear = newGear
//            print("Gear changed to \(newGear) successfully!")
//        }
//    }
//}
//
//var car1 = Car(model: "Honda", numSeats: 4)
//print(car1.curGear)
//
//car1.changeGear(gear: 1)
//car1.changeGear(gear: 2)
//car1.changeGear(gear: 0)
//car1.changeGear(gear: 11)

//class Animal {
//    let legs: Int
//
//    init(numLegs: Int) {
//        self.legs = numLegs
//    }
//}
//
//class Dog: Animal {
//    func speak() {
//        print("BARK")
//    }
//}
//
//class Corgi: Dog {
//    override func speak() {
//        print("WOOF")
//    }
//}
//
//class Poodle: Dog {
//
//    override func speak() {
//        print("WUF")
//    }
//}
//
//class Cat: Animal {
//    var isTame: Bool
//
//    init(isTame: Bool, numLegs: Int) {
//        self.isTame = isTame
//        super.init(numLegs: numLegs)
//    }
//
//    func speak() {
//        print("Meow")
//    }
//}
//
//class Persian: Cat {
//    override func speak() {
//        print("Purrr")
//    }
//}
//
//class Lion: Cat {
//    override func speak() {
//        print("ROAR")
//    }
//}
//
//var lion = Lion(isTame: false, numLegs: 4)
//print(lion.legs)
//lion.speak()
//
//var animal = Animal(numLegs: 4)
//print(animal.legs)
//
//var corgi = Poodle(numLegs: 4)
//corgi.speak()
//
//var persian = Persian(isTame: true, numLegs: 4)
//persian.speak()
//
//var cat = Cat(isTame: true, numLegs: 4)
//cat.speak()

//protocol Building {
//    var rooms: Int { get }
//    var cost: Int {get set}
//    var estateAgent: String {get set}
//    func printSummary() -> Void
//}
//
//struct House: Building {
//    var rooms: Int
//    var cost: Int
//    var estateAgent: String
//
//    func printSummary() {
//        print("This house is on sale")
//    }
//}
//
//struct Office: Building {
//    var rooms: Int
//    var cost: Int
//    var estateAgent: String
//
//    func printSummary() {
//        print("This office is on sale")
//    }
//}
//
//var house = House(rooms: 1, cost: 100000, estateAgent: "Jeff")
//house.printSummary()
//
//var office = Office(rooms: 1, cost: 100000, estateAgent: "Beth")
//office.printSummary()
//

func returnRandom(from array: [Int]?) -> Int {
    array?.randomElement() ?? Int.random(in: 1...100)
}

let array: [Int]? = nil
var randInt = returnRandom(from: array)
print(randInt)
