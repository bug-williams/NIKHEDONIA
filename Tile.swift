
import Foundation
import SceneKit




/// Defines variables 
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




class BuildingTile: Tile {
    
    
    // ATTRIBUTES
    var x: Int
    
    var y: Int
    
    var image: String
    
    /// The player that owns the building (1 for player 1, 2 for player 2)
    var owner:Int
    
    
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
    
    
}
