import UIKit

//make a class hierarchy for animals, starting with Animal at the top, then Dog and Cat as subclasses, then Corgi and Poodle as subclasses of Dog, and Persian and Lion as subclasses of Cat.
//
//But there’s more:
//
//The Animal class should have a legs integer property that tracks how many legs the animal has.
//The Dog class should have a speak() method that prints a generic dog barking string, but each of the subclasses should print something slightly different.
//The Cat class should have a matching speak() method, again with each subclass printing something different.
//The Cat class should have an isTame Boolean property, provided using an initializer.


// parent class: Animal
class Animal {
    let legs: Int
    
    init(legs: Int = 4) {
        self.legs = legs
    }
}


// Dog subclass of Animal
class Dog: Animal {
    
//    init(legs: Int) {
//        super.init(legs: legs)
//    }
    func speak(dogBreed: String) {
        print("\(dogBreed) barking: woof woof!")
    }
}

// Corgi subclass of Dog
class Corgi: Dog {
    let dogBreed: String
    
    init() {
        self.dogBreed = "Corgi"
    }
    
    func bark() {
        speak(dogBreed: dogBreed)
    }
}
// Poodle subclass of Dog
class Poodle: Dog {
    let dogBreed: String
    
    init() {
        self.dogBreed = "Poodle"
    }
    
    func bark() {
        speak(dogBreed: dogBreed)
    }
}


// Cat subclass of Animal
class Cat: Animal {
    func speak(catBreed: String) {
        print("\(catBreed) meowing: meow, meow.")
    }
}

// Persion subclass of Cat
class Persian: Cat {
    let catBreed: String
    
    init() {
        self.catBreed = "Persian"
    }
    
    func meow() {
        speak(catBreed: catBreed)
    }
}
// Cat subclass of Animal
class Lion: Cat {
    let catBreed: String
    
    init() {
        self.catBreed = "Lion"
    }
    
    func meow() {
        speak(catBreed: catBreed)
    }
}


// Test Program
/*
 Animal can be created with a number of legs e.g. Animal(2)
 Animal can also be created without specifying a number of legs. default is 4
 
 */
var myDog = Corgi()
var myNeighboursDog = Poodle()

var myCat = Persian()
var myNeighboursCat = Lion()

myDog.bark()
myNeighboursDog.bark()
myCat.meow()
myNeighboursCat.meow()
