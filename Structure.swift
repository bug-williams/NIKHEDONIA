
import Foundation
import SpriteKit

class Structure {
    
    // 0 for nobody, 1 for p1 and 2 for p2
    private var owner : Int
    
    // INIT FUNCTIONS
    
    // init if no owner is given
    init() {
        owner = 0
    }
    
    // init if an owner is provided
    init(owner: Int) {
        self.owner = owner
    }
    
    // SETTERS & GETTERS
    
    func getOwner() -> Int {
        return owner
    }
    
}
