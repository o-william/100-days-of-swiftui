import UIKit

//Your challenge is this: make a protocol that describes a building, adding various properties and methods, then create two structs, House and Office, that conform to it. Your protocol should require the following:
//
//A property storing how many rooms it has.
//A property storing the cost as an integer (e.g. 500,000 for a building costing $500,000.)
//A property storing the name of the estate agent responsible for selling the building.
//A method for printing the sales summary of the building, describing what it is along with its other properties.


// Building protocol
protocol Building {
    var rooms: Int {get}
    var cost: Int {get set}
    var estateAgent: String {get set}
    func printSalesSummary()
}

// creating an extension on the Building protocol for the cost proprty. Adding a number formatter to format this cost so that it'll read well in the print function.
extension Building {
    func printSalesSummary() {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        var formattedCost = formatter.string(from: NSNumber(value: cost))! // Why do you have to force the optional?
        print("This house has \(rooms) rooms, and costs $\(formattedCost). It was sold by \(estateAgent)")
    }
}

// House struct
struct House: Building {
    let rooms: Int
    var cost: Int
    var estateAgent: String
    
    init(noOfRooms rooms: Int, costs cost: Int, soldBy estateAgent: String) {
        self.rooms = rooms
        self.cost = cost
        self.estateAgent = estateAgent
    }
}


// Office struct
struct Office: Building {
    let rooms: Int
    var cost: Int
    var estateAgent: String
    
    init(noOfRooms rooms: Int, costs cost: Int, soldBy estateAgent: String) {
        self.rooms = rooms
        self.cost = cost
        self.estateAgent = estateAgent
    }
}


// Use
var house1 = House(noOfRooms: 4, costs: 210_000, soldBy: "Antoine Levenér")
house1.printSalesSummary()

var office1 = Office(noOfRooms: 4, costs: 1_220_000, soldBy: "Antoinette Olsch")
office1.printSalesSummary()
