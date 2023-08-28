import UIKit

// Author: Oluwapelumi Williams
// XCode: 14.3.1
// MacOS: 13.5
// 100 Days of Swift with Paul Hudson
// Checkpoint 4
/*
 The challenge is this: write a function that accepts an integer from 1 through 10,000, and returns the integer square root of that number. That sounds easy, but there are some catches:
 
 You can’t use Swift’s built-in sqrt() function or similar – you need to find the square root yourself.
 If the number is less than 1 or greater than 10,000 you should throw an “out of bounds” error.
 You should only consider integer square roots – don’t worry about the square root of 3 being 1.732, for example.
 If you can’t find the square root, throw a “no root” error.
 As a reminder, if you have number X, the square root of X will be another number that, when multiplied by itself, gives X. So, the square root of 9 is 3, because 3x3 is 9, and the square root of 25 is 5, because 5x5 is 25.
 */


// define a function
// use the halving method to check the number's square root. like binary search. If half of the number is times it self is greater than the square root, then go the other direction.
enum RootError: Error {
    case outOfBounds, noRoot
}

func squareRoot(_ number: Int) throws -> Int {
    // the square of odd numbers is always odd, and the square of even numbers is always even.
    if (number < 1 || number > 10_000) {
        throw RootError.outOfBounds
    }
    
//    let isEven: Bool = (number % 2 == 0)
    
    var potentialRoot: Int = number
    var half: Int = number
    var halfSquare: Int = number + 1 // this is for the while loop to be activated the first time
    
    while (halfSquare > number) {
        potentialRoot = half
        half = potentialRoot / 2
        halfSquare = half * half

        if (halfSquare == number) {
            potentialRoot = half // entering this condition means it wont enter the next loop, and it won't enter the loop below
            // we could also return here
        }
    }
    // do this when the halfSquare is less than the number. If it is equal, it won't enter the loop below.
    // a way to optimize this would be to reduce the halving size. eg from half every iteration to a quarter and check for the equality
    while (halfSquare < number) {
        // loop from half to potentialRoot
        half += 1
        halfSquare = half * half
        if (halfSquare == number) {
            // squareRoot found
            potentialRoot = half
            break
            // we could also return here
        }
        if (half == potentialRoot) {
            // if at this point we haven't found the root, then we don't have an integer root.
            break
            // we could also return here
        }
    }
    // check if potentialRoot * potentialRoot == number. This is necessary because it could have passed after the first while loop and not entered the second. At that point, potentialRoot is the actual root. Also, if it passed at the second while loop, this is the case. However, if it exits from the second condition in the second while loop, potentialRoot is not the real root, but we do not have a valid integer root.
    // Actually, the comment above is not necessary. We don't need to do it this way, but this way works as well. We could just directly throw the noRoot error, because if the code reaches here without having a root already, then there is not root. However, we would need to have returned at the other places I commented "we could also return here"
    if (potentialRoot * potentialRoot == number) {
        // actual root found
        return potentialRoot
    } else {
        // we don't have an actual root.
        throw RootError.noRoot
    }
}


// Test the code by using the function.
var number = 225
do {
    let root = try squareRoot(number)
    print("Root of \(number): \(root).")
} catch RootError.outOfBounds {
    print("Number is out of bounds.")
} catch RootError.noRoot {
    print("The number \(number) does not have an integer root.")
} catch {
    print("Unknown error.")
}
