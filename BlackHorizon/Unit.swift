
import Foundation
import SceneKit



protocol Unitable {
    
    
    
}

class SoldierUnit: Unitable {

    
    //Assumption is that there will be a NEW control view for the soldier units....
    
    var x: Int
    var y: Int
    var image: String
    var owner: String
    var buildTime: Int = 1
    
    init(x: Int, y: Int, image: String, owner: String, damage: Int ) {
        
        self.x = x
        self.y = y
        self.image = image
        self.owner = owner
        var damage: String
        
        var health: Int
        
        
    }
    
    func defend(from damage: Int) -> Int{
        
        self.health -= damage
        
    }
    
    
    
}
