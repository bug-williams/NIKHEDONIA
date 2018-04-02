
import SpriteKit
import GameplayKit
import Foundation


class GameScene: SKScene {
    
    
    // GLOBAL VARIABLES
    
    
    /// Stuff that's nessisary for SpriteKit:
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    /// Board Tiles:
    private let BoardSize = 9
    var tileNodes : [[SKSpriteNode]] = []
    
    /// Player buttons:
    var player1BuilderButton = SKSpriteNode()
    var player1FighterButton = SKSpriteNode()
    var player2BuilderButton = SKSpriteNode()
    var player2FighterButton = SKSpriteNode()
    
    /// Player labels:
    var player1TitleLabel = SKLabelNode()
    var player2TitleLabel = SKLabelNode()
    var player1TurnLabel = SKLabelNode()
    var player2TurnLabel = SKLabelNode()
    
    /// Booleans telling tiles which button has been pressed:
    var builderButton1Pressed = false
    var builderButton2Pressed = false
    var fighterButton1Pressed = false
    var fighterButton2Pressed = false
    
    /// Game Controller
    var gameController = GameController()
    
    
    // INIT METHODS
    
    
    /// Called right before the scene is presented, used here to set up the scene's contents.
    override func didMove(to view: SKView) {
        
        initButtons()
        initUIElements()
        initGame(boardType: "")
        initTiles()
        
        updatePlayersUI()
        
    }
    
    
    /// Called immidiately after the scene is loaded into view.
    override func sceneDidLoad() { }
    
    
    /// Initiates all board tile nodes
    func initTiles() {
        for row in 0 ..< BoardSize {
            tileNodes.append([])
            for column in 0 ..< BoardSize {
                let name = "tile\(row)\(column)"
                if let node = self.childNode(withName: name) as? SKSpriteNode {
                    tileNodes[row].append(node)
                }
                else {
                    print("DOES NOT EXIST!")
                }
            }
        }
        
    }
    
    
    /// Initiates all buttons
    func initButtons() {
        
        player1BuilderButton = self.childNode(withName: "player1BuilderButton") as! SKSpriteNode
        player1FighterButton = self.childNode(withName: "player1FighterButton") as! SKSpriteNode
        player2BuilderButton = self.childNode(withName: "player2BuilderButton") as! SKSpriteNode
        player2FighterButton = self.childNode(withName: "player2FighterButton") as! SKSpriteNode
        
    }
    
    
    /// Initiates all the UI elements for the game scene, to make sure they're displayed correctly.
    func initUIElements() {
        
        // Player title labels:
        player1TitleLabel = self.childNode(withName: "player1TitleLabel") as! SKLabelNode
        player2TitleLabel = self.childNode(withName: "player2TitleLabel") as! SKLabelNode
        
        // Player turn labels:
        player1TurnLabel = self.childNode(withName: "player1TurnLabel") as! SKLabelNode
        player2TurnLabel = self.childNode(withName: "player2TurnLabel") as! SKLabelNode
        
    }
    
    
    func initGame(boardType: String) {
        
        // If the board is blank, use the default. Otherwise pass in the board.
        if boardType != "" { gameController = GameController() }
        else { gameController = GameController(boardType: boardType) }
        
    }
    
    
    // HELPER METHODS
    
    
    /// Updates each player's buttons and labels to reflect who's turn it is.
    func updatePlayersUI() {
        
        // Hide everything.
        player1TurnLabel.isHidden = true
        player2TurnLabel.isHidden = true
        player1BuilderButton.isHidden = true
        player1FighterButton.isHidden = true
        player2BuilderButton.isHidden = true
        player2FighterButton.isHidden = true
        
        //Show what's needed.
        if gameController.getCurrentPlayer() == 1 {
            player1TurnLabel.isHidden = false
            player1BuilderButton.isHidden = false
            player1FighterButton.isHidden = false
        }
        else if gameController.getCurrentPlayer() == 2 {
            player2TurnLabel.isHidden = false
            player2BuilderButton.isHidden = false
            player2FighterButton.isHidden = false
        }
        
        // Update Button Textures
        
        if !builderButton1Pressed {
            player1BuilderButton.texture = SKTexture(imageNamed: "button-builder-blue")
        }
        else {
            player1BuilderButton.texture = SKTexture(imageNamed: "button-builder-pressed")
        }
        
        if !builderButton2Pressed {
            player2BuilderButton.texture = SKTexture(imageNamed: "button-builder-orange")
        }
        else {
            player2BuilderButton.texture = SKTexture(imageNamed: "button-builder-pressed") 
        }
        
        // Update board tiles.
        updateBoardTiles()
        
        // Animate.
        AnimationController.animate(label: player1TurnLabel)
        AnimationController.animate(label: player2TurnLabel)
        
    }
    
    
    func updateBoardTiles() {
        
        for row in 0 ..< BoardSize { for column in 0 ..< BoardSize {
            
            let currentTexture = tileNodes[row][column].texture
            let p1Texture = SKTexture(imageNamed: "tile-building-blue")
            let p2Texture = SKTexture(imageNamed: "tile-building-orange")
            let blankTexture = SKTexture(imageNamed: "tile-empty")
            
            if currentTexture == p1Texture && gameController.getStructure(row: row, column: column).getOwner() != 1 {
                switch gameController.getStructure(row: row, column: column).getOwner() {
                    case 2  :
                        tileNodes[row][column].texture = SKTexture(imageNamed: "tile-building-orange")
                        AnimationController.animate(tile: tileNodes[row][column])
                    default :
                        tileNodes[row][column].texture = SKTexture(imageNamed: "tile-empty")
                        AnimationController.animate(tile: tileNodes[row][column])
                }
            }
            else if currentTexture == p2Texture && gameController.getStructure(row: row, column: column).getOwner() != 2 {
                switch gameController.getStructure(row: row, column: column).getOwner() {
                    case 1  :
                        tileNodes[row][column].texture = SKTexture(imageNamed: "tile-building-blue")
                        AnimationController.animate(tile: tileNodes[row][column])
                    default :
                        tileNodes[row][column].texture = SKTexture(imageNamed: "tile-empty")
                        AnimationController.animate(tile: tileNodes[row][column])
                }
            }
            else if currentTexture == blankTexture && gameController.getStructure(row: row, column: column).getOwner() != 0 {
                switch gameController.getStructure(row: row, column: column).getOwner() {
                    case 1 :
                        tileNodes[row][column].texture = SKTexture(imageNamed: "tile-building-blue")
                        AnimationController.animate(tile: tileNodes[row][column])
                    case 2 :
                        tileNodes[row][column].texture = SKTexture(imageNamed: "tile-building-orange")
                        AnimationController.animate(tile: tileNodes[row][column])
                    default:
                        tileNodes[row][column].texture = SKTexture(imageNamed: "tile-blank")
                        AnimationController.animate(tile: tileNodes[row][column])
                }
            }
            else {
                switch gameController.getStructure(row: row, column: column).getOwner() {
                    case 1  : tileNodes[row][column].texture = SKTexture(imageNamed: "tile-building-blue")
                    case 2  : tileNodes[row][column].texture = SKTexture(imageNamed: "tile-building-orange")
                    default : tileNodes[row][column].texture = SKTexture(imageNamed: "tile-empty")
                }
                //AnimationController.animate(tile: tileNodes[row][column])
            }
            
        }}
        
    }
    
    
    // Takes in a tile name and return the coordinates stored within.
    // format: tile(row,column)
    // returns array with [row,column]
    func getTilePositionFromName(name: String) -> [Int] {
        
        let index = name.index(name.endIndex, offsetBy: -2)
        let substring = Array(name[index...])
        
        var coordinates : [Int] = []
        for i in 0...1 {
            coordinates.append(Int(String(substring[i]))!)
        }
        
        return coordinates
        
    }
    
    
    // TOUCH MANAGER
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let positionInScene = touch.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            // BLUE TILE INTERACTION
            if builderButton1Pressed == true && (touchedNode.name?.contains("tile"))! {
                builderButton1Pressed = false
                let row = getTilePositionFromName(name: touchedNode.name!)[0]
                let column = getTilePositionFromName(name: touchedNode.name!)[1]
                gameController.makeTurn(row: row, column: column, owner: 1)
            }
            // ORANGE TILE INTERACTION
            if builderButton2Pressed == true && (touchedNode.name?.contains("tile"))! {
                builderButton2Pressed = false
                let row = getTilePositionFromName(name: touchedNode.name!)[0]
                let column = getTilePositionFromName(name: touchedNode.name!)[1]
                gameController.makeTurn(row: row, column: column, owner: 2)
            }
            // BLUE FIGHTER TILE
            if fighterButton1Pressed == true && (touchedNode.name?.contains("tile"))! {
                // fighter unit handling
            }
            // ORANGE FIGHTER TILE
            if fighterButton2Pressed == true && (touchedNode.name?.contains("tile"))! {
                // fighter unit handling
            }
            // PLAYER 1 BUILDER BUTTON
            if touchedNode.name! == "player1BuilderButton" && gameController.getCurrentPlayer() == 1 {
                if builderButton1Pressed {
                    builderButton1Pressed = false
                    player1BuilderButton.texture = SKTexture(imageNamed: "button-builder-blue")
                    AnimationController.animate(button: player1BuilderButton)
                }
                else {
                    // 'un-press' all other buttons
                    fighterButton1Pressed = false
                    player1FighterButton.texture = SKTexture(imageNamed: "button-fighter-blue")
                    AnimationController.animate(button: player1FighterButton)
                    // handle the builder button
                    builderButton1Pressed = true
                    player1BuilderButton.texture = SKTexture(imageNamed: "button-builder-pressed")
                    AnimationController.animate(button: player1BuilderButton)
                }
            }
            // PLAYER 1 FIGHTER BUTTON
            if touchedNode.name! == "player1FighterButton" && gameController.getCurrentPlayer() == 1 {
                if fighterButton1Pressed {
                    fighterButton1Pressed = false
                    player1FighterButton.texture = SKTexture(imageNamed: "button-fighter-blue")
                    AnimationController.animate(button: player1FighterButton)
                }
                else {
                    // 'un-press' all other buttons
                    builderButton1Pressed = false
                    player1BuilderButton.texture = SKTexture(imageNamed: "button-builder-blue")
                    AnimationController.animate(button: player1BuilderButton)
                    // handle the fighter button
                    fighterButton1Pressed = true
                    player1FighterButton.texture = SKTexture(imageNamed: "button-fighter-pressed")
                    AnimationController.animate(button: player1FighterButton)
                    
                }
            }
            // PLAYER 2 BUILDER BUTTON
            if touchedNode.name! == "player2BuilderButton" && gameController.getCurrentPlayer() == 2 {
                if builderButton2Pressed {
                    builderButton2Pressed = false
                    player2BuilderButton.texture = SKTexture(imageNamed: "button-builder-orange")
                    AnimationController.animate(button: player2BuilderButton)
                }
                else {
                    // 'un-press' all other buttons
                    fighterButton2Pressed = false
                    player2FighterButton.texture = SKTexture(imageNamed: "button-fighter-orange")
                    AnimationController.animate(button: player2FighterButton)
                    // handle the builder button
                    builderButton2Pressed = true
                    player2BuilderButton.texture = SKTexture(imageNamed: "button-builder-pressed")
                    AnimationController.animate(button: player2BuilderButton)
                }
            }
            // PLAYER 2 FIGHTER BUTTON
            if touchedNode.name! == "player2FighterButton" && gameController.getCurrentPlayer() == 2 {
                if fighterButton2Pressed {
                    fighterButton2Pressed = false
                    player2FighterButton.texture = SKTexture(imageNamed: "button-fighter-orange")
                    AnimationController.animate(button: player2FighterButton)
                }
                else {
                    // 'un-press' all other buttons
                    builderButton2Pressed = false
                    player2BuilderButton.texture = SKTexture(imageNamed: "button-builder-orange")
                    AnimationController.animate(button: player2BuilderButton)
                    // handle the fighter button
                    fighterButton2Pressed = true
                    player2FighterButton.texture = SKTexture(imageNamed: "button-fighter-pressed")
                    AnimationController.animate(button: player2FighterButton)
                }
            }
        }

        updatePlayersUI()
        
    }
    

}
