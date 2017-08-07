import SpriteKit
import GameplayKit




class GameScene: SKScene {
    
    
    // GLOBAL VARIABLES
    
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    var tiles:[SKSpriteNode] = [] // Array containing all tiles in the grid.
    
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
    
    
    // INIT FUNCTIONS
    
    
    override func didMove(to view: SKView) {
        
        // Called right before the scene is presented, used here to set up the scene's contents.
        
        initTiles()
        initButtons()
        
    }
    
    
    override func sceneDidLoad() {
        
        // Called immidiately after the scene is loaded into view.
        
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

    
    // FUNCTIONS
    
    
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
                    tiles[tileNum!].texture = SKTexture(imageNamed: "tile-building-blue")
                    builderButton1Pressed = false
                    player1BuilderButton.texture = SKTexture(imageNamed: "button-builder-blue")
                    animateButtonPress(buttonSprite: player1BuilderButton, isReversed: true)
                    animateTilePlacement(tile: tiles[tileNum!], isReversed: false)
                    removeDeadTiles()
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
                    removeDeadTiles()
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
    
    
    func removeDeadTiles() {
        
        var livingTiles:[Int] = []
        
        // Loop to add all living tiles to the livingTiles array:
		
		var previousLivingTilesSize = -1
		while previousLivingTilesSize != livingTiles.count {
			previousLivingTilesSize = livingTiles.count
			for index in 0...80 {
				if canBreatheThroughTile(index: index, livingTiles: livingTiles) {
					// If the tile is a building of any color next to a living tile.
					if !livingTiles.contains(index) {
						livingTiles.append(index)
					}
					print(String(index) + ":" + String(describing:livingTiles))
				}
			}
			print(previousLivingTilesSize)
			print(livingTiles.count)
		}
		
		print("")
		
        // Loop to clear all dead tiles:
		
        for index in 0...80 {
            if !livingTiles.contains(index) {
                tiles[index].texture = SKTexture(imageNamed: "tile-empty")
            }
        }
		
    }
	
	
	func getTilePositionType(index: Int) -> String {
		
		// Arrays and variables containing the values of the tiles on the edges and corners:
		
		let topEdgeTiles = [1, 2, 3, 4, 5, 6, 7]
		let bottomEdgeTiles = [73, 74, 75, 76, 77, 78, 79]
		let leftEdgeTiles = [9, 18, 27, 36, 45, 54, 63]
		let rightEdgeTiles = [17, 26, 35, 44, 53, 63]
		
		let topLeftCornerTile = 0
		let topRightCornerTile = 8
		let bottomLeftCornerTile = 72
		let bottomRightCornerTile = 80
		
		// Tests to see what directions should be checked:
		
		if topEdgeTiles.contains(index) {
			return "top edge tile"
		}
		else if bottomEdgeTiles.contains(index) {
			return "bottom edge tile"
		}
		else if leftEdgeTiles.contains(index) {
			return "left edge tile"
		}
		else if rightEdgeTiles.contains(index) {
			return "right edge tile"
		}
		else if index == topLeftCornerTile {
			return "top left corner tile"
		}
		else if index == topRightCornerTile {
			return "top right corner tile"
		}
		else if index == bottomLeftCornerTile {
			return "bottom left corner tile"
		}
		else if index == bottomRightCornerTile {
			return "bottom right corner tile"
		}
		else {
			return "normal tile"
		}
		
	}
	
	
	func canBreatheThroughTile(index: Int, livingTiles: [Int]) -> Bool {
		
		// Takes the tile at the given index and checks all four directions for living tiles of the same color.
		
		// Variable with the indexed tile's building color, and if it is a building.:
		
		let currentTileTexture = tiles[index].texture!.name
		var currentTileIsBuilding = false
		
		if currentTileTexture == "tile-building-blue" || currentTileTexture == "tile-building-orange" { currentTileIsBuilding = true }
		
		// Variables to store which directions to be checked:
		
		var checkAbove = false
		var checkBelow = false
		var checkLeft = false
		var checkRight = false
		
		// Set which directions should be checked:
		
		if getTilePositionType(index: index) == "top edge tile" {
			checkBelow = true
			checkLeft = true
			checkRight = true
		}
		else if getTilePositionType(index: index) == "bottom edge tile"	{
			checkAbove = true
			checkLeft = true
			checkRight = true
		}
		else if getTilePositionType(index: index) == "left edge tile" {
			checkAbove = true
			checkBelow = true
			checkRight = true
		}
		else if getTilePositionType(index: index) == "right edge tile" {
			checkAbove = true
			checkBelow = true
			checkLeft = true
		}
		else if getTilePositionType(index: index) == "top left corner tile" {
			checkBelow = true
			checkRight = true
		}
		else if getTilePositionType(index: index) == "top right corner tile" {
			checkBelow = true
			checkLeft = true
		}
		else if getTilePositionType(index: index) == "bottom left corner tile" {
			checkAbove = true
			checkRight = true
		}
		else if getTilePositionType(index: index) == "bottom right corner tile" {
			checkAbove = true
			checkLeft = true
		}
		else if getTilePositionType(index: index) == "normal tile" {
			checkAbove = true
			checkBelow = true
			checkLeft = true
			checkRight = true
		}
		
		// Ensure that the tile being checked is a building:
		
		if !currentTileIsBuilding {
			return false
		}
		
		// Check the set directions:
		
		if checkAbove {
			if tiles[index - 9].texture!.name == "tile-empty" {
				// If the tile above is blank...
				return true
			}
			else if tiles[index - 9].texture!.name == currentTileTexture && livingTiles.contains(index - 9) {
				// If the tile above is a building of the same color, and is in the livingTiles array...
				return true
			}
		}
		if checkBelow {
			if tiles[index + 9].texture!.name == "tile-empty" {
				// If the tile below is blank...
				return true
			}
			else if tiles[index + 9].texture!.name == currentTileTexture && livingTiles.contains(index + 9) {
				// If the tile below is a building of the same color, and is in the livingTiles array...
				return true
			}
		}
		if checkLeft {
			if tiles[index - 1].texture!.name == "tile-empty" {
				// If the tile to the left is blank...
				return true
			}
			else if tiles[index - 1].texture!.name == currentTileTexture && livingTiles.contains(index - 1) {
				// If the tile to the left is a building of the same color, and is in the livingTiles array...
				return true
			}
		}
		if checkRight {
			if tiles[index + 1].texture!.name == "tile-empty" {
				// If the tile to the right is blank...
				return true
			}
			else if tiles[index + 1].texture!.name == currentTileTexture && livingTiles.contains(index + 1) {
				// If the tile to the right is a building of the same color, and is in the livingTiles array...
				return true
			}
		}
		
		return false // Otherwise, return false.
		
	}
	
	
}
