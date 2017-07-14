import SpriteKit
import GameplayKit




class GameScene: SKScene {
    
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    
    var player1BuilderButton = SKSpriteNode()
    var player1CollectorButton = SKSpriteNode()
    var tiles:[SKSpriteNode] = [] // Array containing all tiles in the board/grid.
    
    
    // Booleans that check which type of unit is going to be placed on a tile when you tap a tile.
    var builderButtonPressed = false;
    var collectorButtonPressed = false;
    
    
    override func didMove(to view: SKView) {
        
        // Called right before the scene is presented, used here to set up the scene's contents.
        
        initTiles()
        initButtons()
        
        // Add test tiles:
        generatePetrolium(amountToGenerate:5) // Test resource tiles.
        tiles[47].texture = SKTexture(imageNamed:"tile-building-blue") // Test building.
        
    }
    
    
    override func sceneDidLoad() {
        
        // Called immidiately after the scene is loaded into view.
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in (touches) {
            let positionInScene = touch.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            if let name = touchedNode.name {
                // This code gets the number at the end of the tile name, converts it to an Integer, and uses it to access the tile sprite in the tiles array.
                let nameStartIndex = name.index(name.endIndex, offsetBy: -2)
                if builderButtonPressed == true && name.substring(to: nameStartIndex) == "tile" {
                    let nameEndIndex = name.index(name.startIndex, offsetBy: 4)
                    let tileNum = Int(name.substring(from: nameEndIndex))
                    tiles[tileNum!].texture = SKTexture(imageNamed: "tile-building-blue")
                    builderButtonPressed = false
                }
                if name == "player1BuilderButton" {
                    print("builder button pressed!")
                    if builderButtonPressed == true {
                        builderButtonPressed = false
                    }
                    else {
                        builderButtonPressed = true
                    }
                }
            }
        }
        
    }
    
    
    func initTiles() {
        
        // Initiate tiles and add them to the tiles array.
        for _ in 0...80 {
            let tile = SKSpriteNode()
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
    
    
    func initButtons() {
        
        player1BuilderButton = self.childNode(withName: "player1BuilderButton") as! SKSpriteNode
        player1CollectorButton = self.childNode(withName: "player1CollectorButton") as! SKSpriteNode
        
    }
    
    
    func generatePetrolium(amountToGenerate: Int) {
        
        // For testing, in the real game the placement of all resource tiles needs to be symmetrical.
        
        for _ in 0...amountToGenerate {
            let index = Int(arc4random_uniform(81))
            tiles[index].texture = SKTexture(imageNamed:"tile-petrolium")
        }
        
    }
    
    
}
