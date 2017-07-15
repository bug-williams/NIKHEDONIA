import SpriteKit
import GameplayKit




class GameScene: SKScene {
    
    
    // GLOBAL VARIABLES
    
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    var tiles:[SKSpriteNode] = [] // Array containing all tiles in the board/grid.
    var player1BuilderButton = SKSpriteNode()
    var player1FighterButton = SKSpriteNode()
    
    // Booleans that check which type of unit is going to be placed on a tile when you tap a tile.
    var builderButtonPressed = false;
    var fighterButtonPressed = false;
    
    
    // FUNCTIONS
    
    
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
                // Tile interaction.
                let nameStartIndex = name.index(name.endIndex, offsetBy: -2)
                if builderButtonPressed == true && name.substring(to: nameStartIndex) == "tile" {
                    let nameEndIndex = name.index(name.startIndex, offsetBy: 4)
                    let tileNum = Int(name.substring(from: nameEndIndex))
                    tiles[tileNum!].texture = SKTexture(imageNamed: "tile-building-blue")
                    builderButtonPressed = false
                    player1BuilderButton.texture = SKTexture(imageNamed: "button-builder-blue")
                    animateButtonPress(buttonSprite: player1BuilderButton, isReversed: true)
                }
                // Player 1 builder button.
                if name == "player1BuilderButton" {
                    if builderButtonPressed {
                        builderButtonPressed = false
                        player1BuilderButton.texture = SKTexture(imageNamed: "button-builder-blue")
                        animateButtonPress(buttonSprite: player1BuilderButton, isReversed: true)
                    }
                    else {
                        builderButtonPressed = true
                        player1BuilderButton.texture = SKTexture(imageNamed: "button-builder-pressed")
                        animateButtonPress(buttonSprite: player1BuilderButton, isReversed: false)
                    }
                }
                // Player 1 fighter button.
                if name == "player1FighterButton" {
                    if fighterButtonPressed {
                        fighterButtonPressed = false
                        player1FighterButton.texture = SKTexture(imageNamed: "button-fighter-blue")
                        animateButtonPress(buttonSprite: player1FighterButton, isReversed: true)
                    }
                    else {
                        fighterButtonPressed = true
                        player1FighterButton.texture = SKTexture(imageNamed: "button-fighter-pressed")
                        animateButtonPress(buttonSprite: player1FighterButton, isReversed: false)
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
        player1FighterButton = self.childNode(withName: "player1FighterButton") as! SKSpriteNode
        
    }
    
    
    func animateButtonPress(buttonSprite: SKSpriteNode, isReversed: Bool) {
        
        let buttonScale = SKAction.scale(to: 0.9, duration: 0.1)
        let buttonRotate = SKAction.rotate(byAngle: 0.5, duration: 0.1)
        
        let inverseButtonScale = SKAction.scale(to: 1.0, duration: 0.1)
        let inverseButtonRotate = SKAction.rotate(byAngle: -0.5, duration: 0.1)
        
        let buttonPressAction = SKAction.group([buttonScale, buttonRotate])
        let inverseButtonPressAction = SKAction.group([inverseButtonScale, inverseButtonRotate])
        
        if isReversed {
            buttonSprite.run(inverseButtonPressAction)
        }
        else {
            buttonSprite.run(buttonPressAction)
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
