
import Foundation
import SceneKit



protocol Unitable {
    
    var x: Int { get set }
    var y: Int { get set }
    var image: String { get set }
    var owner: String { get set }
    var damage: Int { get set }
    var health: Int { get set }
    var buildTime: Int { get set }
    
    init ( x: Int, y: Int, image: String, owner: String, damage: Int )
    
    func attack (_ damage: Int, a: Tile)
    
    
    
    
}

class SoldierUnit: Unitable {

    //Assumption is that there will be a NEW control view for the soldier units....
    
    var x: Int
    var y: Int
    var image: String
    var owner: String
    var damage: Int
    var health: Int
    var buildTime: Int
    
    required init(x: Int, y: Int, image: String, owner: String, damage: Int ) {
        
        self.x = x
        self.y = y
        self.image = image
        self.owner = owner
        self.damage = damage
        self.health = 100
        self.buildTime = 1
     
    }
    
    func attack (_ damage: Int, a: Tile) {
        
        print("Oh")
    }
    
    
    
    
    
    
}
