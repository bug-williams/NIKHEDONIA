
import Foundation
import SceneKit




class Tile {
    
    
    // ATTRIBUTES
    
    
    /// The x-coordinate of the tile
    var xCoordinate:Int
    
    /// The y-coordinate of the tile
    var yCoordinate:Int
    
    /// The name of the desired image for the tile
    var image:String
    
    
    // INITIALIZERS
    
    
    init(x:Int, y:Int, image:String) {
        
        xCoordinate = x
        yCoordinate = y
        
        self.image = image
        
    }
    
    
}




class BasicTile: Tile {
    
    
    // INITIALIZERS
    
    
    init(x:Int, y:Int) {
        
        super.init(x: x, y: y, image: "tile-empty")
        
    }
    
    
}




class BuildingTile: Tile {
    
    
    // ATTRIBUTES
    
    
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
        super.init(x: x, y: y, image: image)
        
    }
    
    
}
