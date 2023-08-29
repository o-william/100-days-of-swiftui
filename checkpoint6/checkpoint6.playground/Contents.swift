import UIKit

//
/* Structs sit at the core of every SwiftUI app, so it’s really important you take some extra time to make sure you understand what they do and how they work.
 
 To check your knowledge, here’s a small task for you: create a struct to store information about a car, including its model, number of seats, and current gear, then add a method to change gears up or down. Have a think about variables and access control: what data should be a variable rather than a constant, and what data should be exposed publicly? Should the gear-changing method validate its input somehow?
 */

struct Car {
    let model: String
    let seats: Int
    private var currentGearName: String
    private var currentGear: Int {
        willSet {
            printGearChangingMessage(from: currentGear, to: newValue)
        }
        didSet {
            currentGearName = getGearName(currentGear: currentGear)
            printGearChangedMessage(from: oldValue, to: currentGear)
        }
    }
    
    
    init (model: String, seats: Int) {
        self.model = model
        self.seats = seats
        self.currentGear = 0 // always start on gear 0 upon creation
        self.currentGearName = "park" // gross bad coding, setting this property in this way. Isn't used, apart from the line below.
        print("\(self.model) created with \(self.seats) seats, currrently on \(self.currentGearName) ...") // bit of cheating, because you know what the first gear will be always, so you have formmatted the String conveniently.
        printLineSeparator()
    }
    
    
    
    
    // errors of the gear struct
    enum GearSelectionError: Error {
        case tooHigh // a gear increase above 6
        case tooLow // a gear decrease below 1
        case illegalGearChange // a gear increase or decrease of more than 1
        // use message: too High,
    }

    // function to return the String name of the current gear
    func getGearName(currentGear: Int) -> String {
        switch (currentGear) {
        case 1:
            return "one"
        case 2:
            return "two"
        case 3:
            return "three"
        case 4:
            return "four"
        case 5:
            return "five"
        case 6:
            return "six"
        case 0:
            return "park" // no "neutral" gear implementation
        case -1:
            return "reverse"
        default:
            return "unknown" // handle this with an error
        }
    }
    
    // function to print a line and a number of dashes to separate the print statements. Using a function for consistency.
    private func printLineSeparator() {
        print("\n------")
    }

    // gear change message. Used by printGearChangingMessage() and printGearChangedMessage()
    func gearChangeMessage(gear:Int) -> String {
        // Maybe should be named somthing other than "gearChangeMessage", because it is used in other scenarios.
        return gear > 0 ? "gear \(getGearName(currentGear: gear))" : "\(getGearName(currentGear: gear)) gear"
    }

    // gear changing message
    func printGearChangingMessage(from gear1: Int, to gear2: Int) {
        print("\(model) moving from \(gearChangeMessage(gear: gear1)) to \(gearChangeMessage(gear: gear2)) ...")
    }

    // gear changed message
    func printGearChangedMessage(from gear1: Int, to gear2: Int) {
        print("\(model) moved from \(gearChangeMessage(gear: gear1)) to \(gearChangeMessage(gear: gear2))")
        printLineSeparator()
    }
    
    // print the car's current state.
    func printCarState() { print("The \(model) is on \(gearChangeMessage(gear: currentGear))") }
    
    
    mutating func increaseGear() throws {
        // put error checking: should not be able to go above gear 6
        if (currentGear == 6) {
            throw GearSelectionError.tooHigh
        }
        if (currentGear < 0) {
            throw GearSelectionError.illegalGearChange // you cant increase from reverse. Put in park first.
        } else {
            currentGear += 1
        }
    }

    mutating func decreaseGear() throws {
        // put error checking : should not be able to go below gear 1. However, we can have current gear to be below 1, but by using another function.
        if (currentGear == 1) {
            throw GearSelectionError.tooLow
        } else {
            currentGear -= 1
        }
    }
    
    mutating func putInReverse() throws {
        // should not be able to go from a gear other than "one" or "park", to reverse
        if (currentGear > 0) {
            throw GearSelectionError.illegalGearChange
        } else {
            currentGear = -1
        }
    }
    
    mutating func putInPark() throws {
        // should not be able to go from a gear other than "one" or "park", to reverse
        if (currentGear > 1) {
            throw GearSelectionError.illegalGearChange
        } else {
            currentGear = 0 // thus, only possible from reverse or first gear.
        }
    }
}




// usage of the struct
//var car = Car(model: "Rivian", seats: 5)

//// increase
//do { try car.increaseGear() } catch { print("Unknown Error") }

//// decrease
//do { try car.dereaseGear() } catch { print("Unknown Error") }

//// put in park gear (must be done before moving from gear 1 to reverse and vice versa)
//do { try car.putInPark() } catch { print("Unknown Error") }

// put in reverse gear (can only be done from park)
//do { try car.putInReverse() } catch { print("Unknown Error") }

//// print car state
//car.printCarState()


// testing the function
var car = Car(model: "Rivian", seats: 5)
for _ in 0...6 {
    do { try car.increaseGear() } catch { print("Unknown Error") } // willl give an error for the last iteration
}
do { try car.increaseGear() } catch { print("Unknown Error") }

car.printCarState()

for _ in 0...6 {
    do { try car.decreaseGear() } catch { print("Unknown Error") } // will give an error for the last iteration
}
do { try car.decreaseGear() } catch { print("Unknown Error") } // will give an error

car.printCarState()
do { try car.putInPark() } catch { print("Unknown Error") }
car.printCarState()
do { try car.putInReverse() } catch { print("Unknown Error") }
car.printCarState()

