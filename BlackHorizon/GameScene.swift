import SpriteKit
import GameplayKit




class GameScene: SKScene {
    
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    
    var tiles:[SKSpriteNode] = [] // Array containing all tiles in the board/grid.
    
    
    override func didMove(to view: SKView) {
        
        // Called right before the scene is presented, used here to set up the scene's contents.
        
        initTiles()
        
        // Add test tiles:
        generatePetrolium(amountToGenerate:5) // Test resource tiles.
        tiles[17].texture = SKTexture(imageNamed:"tile-building-blue") // Test building.
        
    }
    
    
    override func sceneDidLoad() {
        
        // Called immidiately after the scene is loaded into view.
        
    }
    
    
    func initTiles() {
        
        // Initiate tiles and add them to the tiles array.
        for index in 0...80 {
            var tile = SKSpriteNode()
            tiles.append(tile)
        }
        
        // Set each tile as a child node of self, with procedurally generated name.
        for index in 0...80 {
            if index < 10 {
                tiles[index] = self.childNode(withName: "tile0\(index)") as! SKSpriteNode
            } else {
                tiles[index] = self.childNode(withName: "tile\(index)") as! SKSpriteNode
            }
        }
        
    }
    
    
    func generatePetrolium(amountToGenerate: Int) {
        
        // For testing, in the real game the placement of all resource tiles needs to be symmetrical.
        
        for _ in 0...amountToGenerate {
            let index = Int(arc4random_uniform(81))
            tiles[index].texture = SKTexture(imageNamed:"tile-petrolium")
        }
        
    }
    
    
}
