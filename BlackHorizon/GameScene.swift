import SpriteKit
import GameplayKit




class GameScene: SKScene {
    
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    var tileArray:[SKSpriteNode] = []
    
    
    override func didMove(to view: SKView) {
        
        // Called right before the scene is presented, used here to set up the scene's contents.
        
        initTiles()
        
    }
    
    
    override func sceneDidLoad() {
        
        // Called immidiately after the scene is loaded into view.
        
    }
    
    
    // UTILITY FUNCTIONS
    
    
    func initTiles() {
        
        var i = 0;
        while(i < 81) {
            var tile = SKSpriteNode()
            tile = self.childNode(withName: "tile + \(i)") as! SKSpriteNode
            self.tileArray.append(tile)
            i += 1
        }
        
    }
    
    
}
