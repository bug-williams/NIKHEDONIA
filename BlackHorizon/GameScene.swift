import SpriteKit
import GameplayKit




class GameScene: SKScene {
    
    
    // GLOBAL VARIABLES
    
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    var tiles:[SKSpriteNode] = [] // Array containing all tiles in the board/grid.
    
    // Player conrol buttons.
    var player1BuilderButton = SKSpriteNode()
    var player1FighterButton = SKSpriteNode()
    var player2BuilderButton = SKSpriteNode()
    var player2FighterButton = SKSpriteNode()
    
    // Booleans telling tiles which button has been pressed.
    var builderButton1Pressed = false
    var builderButton2Pressed = false
    var fighterButton1Pressed = false
    var fighterButton2Pressed = false
    
    
    // FUNCTIONS
    
    
    override func didMove(to view: SKView) {
        
        // Called right before the scene is presented, used here to set up the scene's contents.
        
        initTiles()
        initButtons()
        
    }
    
    
    override func sceneDidLoad() {
        
        // Called immidiately after the scene is loaded into view.
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in (touches) {
            let positionInScene = touch.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            if let name = touchedNode.name {
                let nameStartIndex = name.index(name.endIndex, offsetBy: -2)
                // Blue tile interaction.
                if builderButton1Pressed == true && name.substring(to: nameStartIndex) == "tile" {
                    let nameEndIndex = name.index(name.startIndex, offsetBy: 4)
                    let tileNum = Int(name.substring(from: nameEndIndex))
                    if tileSurrounded(tileNumber: tileNum!, tileColor: "orange") == false {
                        tiles[tileNum!].texture = SKTexture(imageNamed: "tile-building-blue")
                        builderButton1Pressed = false
                        player1BuilderButton.texture = SKTexture(imageNamed: "button-builder-blue")
                        animateButtonPress(buttonSprite: player1BuilderButton, isReversed: true)
                        animateTilePlacement(tile: tiles[tileNum!], isReversed: false)
                    }
                }
                // Orange tile interaction.
                if builderButton2Pressed == true && name.substring(to: nameStartIndex) == "tile" {
                    let nameEndIndex = name.index(name.startIndex, offsetBy: 4)
                    let tileNum = Int(name.substring(from: nameEndIndex))
                    tiles[tileNum!].texture = SKTexture(imageNamed: "tile-building-orange")
                    builderButton2Pressed = false
                    player2BuilderButton.texture = SKTexture(imageNamed: "button-builder-orange")
                    animateButtonPress(buttonSprite: player2BuilderButton, isReversed: true)
                    animateTilePlacement(tile: tiles[tileNum!], isReversed: false)
                }

                // Player 1 builder button.
                if name == "player1BuilderButton" {
                    if builderButton1Pressed {
                        builderButton1Pressed = false
                        player1BuilderButton.texture = SKTexture(imageNamed: "button-builder-blue")
                        animateButtonPress(buttonSprite: player1BuilderButton, isReversed: true)
                    }
                    else {
                        builderButton1Pressed = true
                        player1BuilderButton.texture = SKTexture(imageNamed: "button-builder-pressed")
                        animateButtonPress(buttonSprite: player1BuilderButton, isReversed: false)
                    }
                }
                // Player 1 fighter button.
                if name == "player1FighterButton" {
                    if fighterButton1Pressed {
                        fighterButton1Pressed = false
                        player1FighterButton.texture = SKTexture(imageNamed: "button-fighter-blue")
                        animateButtonPress(buttonSprite: player1FighterButton, isReversed: true)
                    }
                    else {
                        fighterButton1Pressed = true
                        player1FighterButton.texture = SKTexture(imageNamed: "button-fighter-pressed")
                        animateButtonPress(buttonSprite: player1FighterButton, isReversed: false)
                    }
                }
                // Player 2 builder button.
                if name == "player2BuilderButton" {
                    if builderButton2Pressed {
                        builderButton2Pressed = false
                        player2BuilderButton.texture = SKTexture(imageNamed: "button-builder-orange")
                        animateButtonPress(buttonSprite: player2BuilderButton, isReversed: true)
                    }
                    else {
                        builderButton2Pressed = true
                        player2BuilderButton.texture = SKTexture(imageNamed: "button-builder-pressed")
                        animateButtonPress(buttonSprite: player2BuilderButton, isReversed: false)
                    }
                }
                // Player 2 fighter button.
                if name == "player2FighterButton" {
                    if fighterButton2Pressed {
                        fighterButton2Pressed = false
                        player2FighterButton.texture = SKTexture(imageNamed: "button-fighter-orange")
                        animateButtonPress(buttonSprite: player2FighterButton, isReversed: true)
                    }
                    else {
                        fighterButton2Pressed = true
                        player2FighterButton.texture = SKTexture(imageNamed: "button-fighter-pressed")
                        animateButtonPress(buttonSprite: player2FighterButton, isReversed: false)
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
        player2BuilderButton = self.childNode(withName: "player2BuilderButton") as! SKSpriteNode
        player2FighterButton = self.childNode(withName: "player2FighterButton") as! SKSpriteNode
        
    }
    
    
    // SPRITE ANIMATIONS (SKACTIONS)
    
    
    func animateButtonPress(buttonSprite: SKSpriteNode, isReversed: Bool) {
        
        let buttonScale1 = SKAction.scale(to: 0.6, duration: 0.1)
        let buttonScale2 = SKAction.scale(to: 0.8, duration: 0.1)
        
        let inverseButtonScale1 = SKAction.scale(to: 1.2, duration: 0.1)
        let inverseButtonScale2 = SKAction.scale(to: 1.0, duration: 0.1)
        
        let buttonPressAction1 = SKAction.group([buttonScale1])
        let buttonPressAction2 = SKAction.group([buttonScale2])
        let inverseButtonPressAction1 = SKAction.group([inverseButtonScale1])
        let inverseButtonPressAction2 = SKAction.group([inverseButtonScale2])
        
        if isReversed {
            buttonSprite.run(inverseButtonPressAction1, completion: {buttonSprite.run(inverseButtonPressAction2)})
        }
        else {
            buttonSprite.run(buttonPressAction1, completion: {buttonSprite.run(buttonPressAction2)})
        }
        
    }
    
    
    func animateTilePlacement(tile: SKSpriteNode, isReversed: Bool) {
        
        let tileScale = SKAction.scale(to: 1.2, duration: 0.1)
        let inverseTileScale = SKAction.scale(to: 1.0, duration: 0.1)
        
        if isReversed {
            tile.run(inverseTileScale)
        }
        else {
            tile.run(tileScale, completion: {
                self.animateTilePlacement(tile: tile, isReversed: true)
            })
        }
        
    }
    
    
    // TILE MANAGEMENT FUNCTIONS
    
    
    func tileSurrounded(tileNumber: Int, tileColor: String) -> Bool {
        
        var upIsCovered = false
        var downIsCovered = false
        var leftIsCovered = false
        var rightIsCovered = false
        
        if tileColor == "blue" {
            // Check if tile above is covered.
            if tiles[tileNumber - 9].texture!.name == "tile-building-blue" {
                upIsCovered = true
            }
            // Check if tile below is covered.
            if tiles[tileNumber + 9].texture!.name == "tile-building-blue" {
                downIsCovered = true
            }
            // Check if tile left is covered.
            if tiles[tileNumber - 1].texture!.name == "tile-building-blue" {
                leftIsCovered = true
            }
            // Check if tile right is covered.
            if tiles[tileNumber + 1].texture!.name == "tile-building-blue" {
                rightIsCovered = true
            }
        }
        
        if tileColor == "orange" {
            // Check if tile above is covered.
            if tiles[tileNumber - 9].texture!.name == "tile-building-orange" {
                upIsCovered = true
            }
            // Check if tile below is covered.
            if tiles[tileNumber + 9].texture!.name == "tile-building-orange" {
                downIsCovered = true
            }
            // Check if tile left is covered.
            if tiles[tileNumber - 1].texture!.name == "tile-building-orange" {
                leftIsCovered = true
            }
            // Check if tile right is covered.
            if tiles[tileNumber + 1].texture!.name == "tile-building-orange" {
                rightIsCovered = true
            }
        }
        
        if upIsCovered && downIsCovered && leftIsCovered && rightIsCovered {
            return true
        }
        else {
            return false
        }
        
    }
    
    
}
