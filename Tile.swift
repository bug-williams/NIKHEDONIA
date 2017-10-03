
import Foundation
import SceneKit




/// Defines the x and y coordinate for the tiles and provides an image String
protocol Tile {

    // ATTRIBUTES
    
    /// The x-coordinate of the tile
    var x:Int {get set}
    
    /// The y-coordinate of the tile
    var y:Int {get set}
    
    /// The name of the desired image for the tile
    var image:String {get set}
    
    // INITIALIZERS

}




/// Basic tile which is a square box without anything occupying the box.
class BasicTile: Tile {
    
    var x: Int
    
    var y: Int
    
    var image: String
    
    
    /// Initializes the basic tile. image is forced to be "tile-empty"
    ///
    /// - Parameters:
    ///   - x: the xCordinate
    ///   - y: the yCordinate
    init(x:Int, y:Int) {
        
        image = "tile-empty"
        self.x = x
        self.y = y
        
    }
    
    
}




/// A defined by a building. Includes the owner of the building now.
class BuildingTile: Tile {
    
    
    // ATTRIBUTES
    var x: Int
    
    var y: Int
    
    var image: String
    
    /// The player that owns the building (1 for player 1, 2 for player 2)
    var owner:Int
    
    var health: Int = 100
    // INITIALIZERS
    
    
    /// The initializer for a BuildingTile
    ///
    /// - Parameters:
    ///   - x: The x-coordinate of the BuildingTile (an int).
    ///   - y: The y-coordinate of the BuildingTile (an int).
    ///   - image: A string with the name of the building tile image.
    ///   - owner: The owner of the building as an int (1 for player 1, 2 for player 2).
    init(x:Int, y:Int, image:String, owner:Int) {
        
        self.owner = owner
        self.x = x
        self.y = y
        self.image = image
        
    }
    
    func tickHealth(by damage: Int){
        
        self.health -= damage
        
    }
    
}




class SoliderTile: Tile {
    
    var x: Int
    var y: Int
    var image: String
    var owner: String
    
    init(x: Int, y: Int, image: String, owner: String) {
        
        self.owner = owner
        self.x = x
        self.y = y
        self.image = image
        
    }
    
    func attack(_ building: BuildingTile, by damage: Int) {
        
        building.tickHealth(by: damage)
        
    }
}
