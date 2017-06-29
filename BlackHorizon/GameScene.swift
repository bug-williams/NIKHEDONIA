import SpriteKit
import GameplayKit




class GameScene: SKScene {
    
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    
    override func sceneDidLoad() {
        
        self.lastUpdateTime = 0
        
    }

    
    override func update(_ currentTime: TimeInterval) {
        
        // Called before each frame is rendered.
        
        // Initialize _lastUpdateTime if it has not already been initialized.
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update.
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities.
        for entity in self.entities {
            
            entity.update(deltaTime: dt)
            
        }
        
        self.lastUpdateTime = currentTime
        
    }
    
    
    
    
}
