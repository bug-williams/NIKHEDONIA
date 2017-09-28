import SpriteKit
import GameplayKit


class GameScene: SKScene {
    
    
    /**
	
	GLOBAL VARIABLES
	I think this is pretty self-explanitory.
	
	*/
    
    
	/// Stuff that's nessisary for SpriteKit:
	var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
	/// Array of the tiles that make up the board:
	var tiles:[SKSpriteNode] = []
	
	/// Variable that holds the number of turns that have been taken:
	var numberOfTurnsTaken = 1
	
	// Custom colors:
	var default_p1Active = UIColor(red: 0.40, green: 0.84, blue: 0.82, alpha: 1.00)
	var default_p2Active = UIColor(red: 0.99, green: 0.47, blue: 0.33, alpha: 1.00)
	var default_inactive = UIColor(red: 0.18, green: 0.23, blue: 0.24, alpha: 1.00)
    
	// Player buttons:
    var player1BuilderButton = SKSpriteNode()
    var player1FighterButton = SKSpriteNode()
    var player2BuilderButton = SKSpriteNode()
    var player2FighterButton = SKSpriteNode()
	
	// Player labels:
	var player1TitleLabel = SKLabelNode()
	var player2TitleLabel = SKLabelNode()
	var player1TurnLabel = SKLabelNode()
	var player2TurnLabel = SKLabelNode()
    
	// Booleans telling tiles which button has been pressed:
    var builderButton1Pressed = false
    var builderButton2Pressed = false
    var fighterButton1Pressed = false
    var fighterButton2Pressed = false
	
	
	/**
	
	INITIATION FUNCTIONS
	Functions used to initiate the scene, view, tiles, and buttons.

	*/
	
	/// Called right before the scene is presented, used here to set up the scene's contents.
    override func didMove(to view: SKView) {
	
		
		initTiles()
        initButtons()
		initUIElements()
		
		updatePlayersUI()
        
    }
    
    /// Called immidiately after the scene is loaded into view.
    override func sceneDidLoad() {
	
		
    }
    
    /// Initiates tiles of the game.
    func initTiles() {
        
        // Initiates tiles and add them to the tiles array.
        for _ in 0...80 {
            let tile = SKSpriteNode()
            tiles.append(tile)
        }
        
        // Sets each tile as a child node of self, with a procedurally generated name.
        for index in 0...80 {
            if index < 10 {
                tiles[index] = self.childNode(withName: "tile0\(index)") as! SKSpriteNode
            } else {
                tiles[index] = self.childNode(withName: "tile\(index)") as! SKSpriteNode
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
	
	
//
//
//    SETTERS & GETTERS
//    Change and grab this class's values.
//
//
	
	
    func setTileTexture(tileNumber: Int, texture: SKTexture) {
	// This function takes a tile number, sets it to a given texture, and animates the tile placement.
		
		tiles[tileNumber].texture = texture
		animateTilePlacement(tile: tiles[tileNumber])
		
	}

    
    /**
	
	FUNCTIONS
	This class's standard functions.
	
	*/
	
	/// Designed to run after every player action in game and controls turns.
	func gameTick() {
		
		numberOfTurnsTaken += 1
		updatePlayersUI()
		
	}
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in (touches) {
            let positionInScene = touch.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            if let name = touchedNode.name {
                let nameStartIndex = name.index(name.endIndex, offsetBy: -2)
                // Blue tile interaction.
                if builderButton1Pressed == true && name.substring(to: nameStartIndex) == "tile" {
				// If player 1's builder button is pressed and the thing that was tapped was a tile...
                    let nameEndIndex = name.index(name.startIndex, offsetBy: 4)
                    let tileNum = Int(name.substring(from: nameEndIndex))
					if tiles[tileNum!].texture!.name != "tile-building-blue" && tiles[tileNum!].texture!.name != "tile-building-orange" {
						animateTilePlacement(tile: tiles[tileNum!])
						for _ in 0...1 {
							// This repeats twice because sometimes placed tiles would normally be dead but should live becuase they killed other tiles.
							tiles[tileNum!].texture = SKTexture(imageNamed: "tile-building-blue")
							removeDeadTiles()
						}
						builderButton1Pressed = false
						player1BuilderButton.texture = SKTexture(imageNamed: "button-builder-blue")
						gameTick()
					}
                }
                // Orange tile interaction.xz
                if builderButton2Pressed == true && name.substring(to: nameStartIndex) == "tile" {
				// If player 2's builder button is pressed and the thing that was tapped was a tile...
                    let nameEndIndex = name.index(name.startIndex, offsetBy: 4)
                    let tileNum = Int(name.substring(from: nameEndIndex))
					if tiles[tileNum!].texture!.name != "tile-building-blue" && tiles[tileNum!].texture!.name != "tile-building-orange" {
						animateTilePlacement(tile: tiles[tileNum!])
						for _ in 0...1 {
							// This repeats twice because sometimes placed tiles would normally be dead but should live becuase they killed other tiles.
							tiles[tileNum!].texture = SKTexture(imageNamed: "tile-building-orange")
							removeDeadTiles()
						}
						builderButton2Pressed = false
						player2BuilderButton.texture = SKTexture(imageNamed: "button-builder-orange")
						gameTick()
					}
                }
                // Player 1 builder button.
                if name == "player1BuilderButton" {
                    if builderButton1Pressed && getCurrentTurn() == "p1" {
                        builderButton1Pressed = false
                        player1BuilderButton.texture = SKTexture(imageNamed: "button-builder-blue")
                        animateButtonPress(buttonSprite: player1BuilderButton)
                    }
                    else {
                        builderButton1Pressed = true
                        player1BuilderButton.texture = SKTexture(imageNamed: "button-builder-pressed")
                        animateButtonPress(buttonSprite: player1BuilderButton)
                    }
                }
                // Player 1 fighter button.
                if name == "player1FighterButton" && getCurrentTurn() == "p1" {
                    if fighterButton1Pressed {
                        fighterButton1Pressed = false
                        player1FighterButton.texture = SKTexture(imageNamed: "button-fighter-blue")
                        animateButtonPress(buttonSprite: player1FighterButton)
                    }
                    else {
                        fighterButton1Pressed = true
                        player1FighterButton.texture = SKTexture(imageNamed: "button-fighter-pressed")
                        animateButtonPress(buttonSprite: player1FighterButton)
                    }
                }
                // Player 2 builder button.
                if name == "player2BuilderButton" && getCurrentTurn() == "p2" {
                    if builderButton2Pressed {
                        builderButton2Pressed = false
                        player2BuilderButton.texture = SKTexture(imageNamed: "button-builder-orange")
                        animateButtonPress(buttonSprite: player2BuilderButton)
                    }
                    else {
                        builderButton2Pressed = true
                        player2BuilderButton.texture = SKTexture(imageNamed: "button-builder-pressed")
                        animateButtonPress(buttonSprite: player2BuilderButton)
                    }
                }
                // Player 2 fighter button.
                if name == "player2FighterButton" && getCurrentTurn() == "p2" {
                    if fighterButton2Pressed {
                        fighterButton2Pressed = false
                        player2FighterButton.texture = SKTexture(imageNamed: "button-fighter-orange")
                        animateButtonPress(buttonSprite: player2FighterButton)
                    }
                    else {
                        fighterButton2Pressed = true
                        player2FighterButton.texture = SKTexture(imageNamed: "button-fighter-pressed")
                        animateButtonPress(buttonSprite: player2FighterButton)
                    }
                }
            }
        }
        
    }
	
	
	/**

	SPRITE ANIMATIONS
	These functions handle the animations of buttons, tiles, etc.
	
	*/
    
    /// Controls the animations for button presses.
    func animateButtonPress(buttonSprite: SKSpriteNode) {

		
		let animationTime = 0.13
        
        let buttonScale1 = SKAction.scale(to: 0.8, duration: animationTime)
        let buttonScale2 = SKAction.scale(to: 1.0, duration: animationTime)
		
		buttonSprite.run(buttonScale1, completion: { buttonSprite.run(buttonScale2) })
        
    }
    
    /// Controlls the animations for tile placements.
    func animateTilePlacement(tile: SKSpriteNode) {
	
		
		let animationTime = 0.13
        
        let tileScale1 = SKAction.scale(to: 0.8, duration: animationTime)
        let tileScale2 = SKAction.scale(to: 1.0, duration: animationTime)
		
		tile.run(tileScale1, completion: { tile.run(tileScale2) })
        
    }
	
	/// Controlls the animations for turn labels when they appear.
	func animateLabelWiggle(label: SKLabelNode) {
	
		
		let animationTime = 0.6
		
		let labelWiggle1 = SKAction.rotate(byAngle: 0.02, duration: animationTime)
		let labelWiggle2 = SKAction.rotate(byAngle: -0.04, duration: animationTime)
		let labelWiggle3 = SKAction.rotate(byAngle: 0.02, duration: animationTime)
		
		label.run(labelWiggle1, completion: { label.run(labelWiggle2, completion: { label.run(labelWiggle3) }) })
		
	}
	
	
	/**
	
	TURN SYSTEM FUNCTIONS
	These are functions pertaining to the current turn system.
	
	*/
	
	
    /// Obtains the current turn using turn# % 2; If it is odd, it will be player 1's turn, else it is player 2's turn
    ///
    /// - Returns: returns a string which is 'p1' or 'p2' dependent on the turn#%2
	func getCurrentTurn() -> String {
	
		if numberOfTurnsTaken % 2 == 0 {
			// If the turn number is even...
			return "p2"
		}
		else {
			// If the number of turns is odd...
			return "p1"
		}
		
	}
	
	/// Updates each player's buttons and labels to reflect who's turn it is.
	func updatePlayersUI() {
	
		
		// Hide everything.
		// TODO: Fix the fact that the player turn labels won't show or hide.
		player1TurnLabel.isHidden = true
		player2TurnLabel.isHidden = true
		player1BuilderButton.isHidden = true
		player1FighterButton.isHidden = true
		player2BuilderButton.isHidden = true
		player2FighterButton.isHidden = true
		
		//Show what's needed.
		if getCurrentTurn() == "p1" {
			player1TurnLabel.isHidden = false
			player1BuilderButton.isHidden = false
			player1FighterButton.isHidden = false
		}
		else if getCurrentTurn() == "p2" {
			player2TurnLabel.isHidden = false
			player2BuilderButton.isHidden = false
			player2FighterButton.isHidden = false
		}
		
		// Animate.
		animateLabelWiggle(label: player1TurnLabel)
		animateLabelWiggle(label: player2TurnLabel)
	
	}
	
	
	/**

	TILE MANAGMENT FUNCTIONS
	These functions manage the tile/grid/board system for the game.
	
	*/
    
    /// Removes tiles which are no longer in use
    func removeDeadTiles() {
        
		/// This variable contains all the tiles that are determined to be "living", so that the others can be removed.
		var livingTiles:[Int] = []
        
        /// Loop to add all living tiles to the livingTiles array:
		var previousLivingTilesSize = -1
		while previousLivingTilesSize != livingTiles.count {
			previousLivingTilesSize = livingTiles.count
			for index in 0...80 {
				if canBreatheThroughTile(index: index, livingTiles: livingTiles) {
					// If the tile is a building of any color next to a living tile.
					if !livingTiles.contains(index) {
						livingTiles.append(index)
					}
				}
			}
		}
		
        /// Loop to clear all dead tiles:
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
	
	/// Takes the tile at the given index and checks all four directions for living tiles of the same color.
	func canBreatheThroughTile(index: Int, livingTiles: [Int]) -> Bool {
	
		
		// Variable with the indexed tile's building color, and if it is a building:
		let currentTileTexture = tiles[index].texture!.name
		
		// Variable that stores wheather or not the current tile is a building:
		var currentTileIsBuilding = false
		if currentTileTexture == "tile-building-blue" || currentTileTexture == "tile-building-orange" { currentTileIsBuilding = true }
		
		// Variables to store which directions to be checked:
		var checkAbove = false
		var checkBelow = false
		var checkLeft = false
		var checkRight = false
		
		// Set which directions should be checked:
		switch getTilePositionType(index: index) {
		case "top edge tile":
			checkBelow = true
			checkLeft = true
			checkRight = true
		case "bottom edge tile":
			checkAbove = true
			checkLeft = true
			checkRight = true
		case "left edge tile":
			checkAbove = true
			checkBelow = true
			checkRight = true
		case "right edge tile":
			checkAbove = true
			checkBelow = true
			checkLeft = true
		case "top left corner tile":
			checkBelow = true
			checkRight = true
		case "top right corner tile":
			checkBelow = true
			checkLeft = true
		case "bottom left corner tile":
			checkAbove = true
			checkRight = true
		case "bottom right corner tile":
			checkAbove = true
			checkLeft = true
		default:
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
		
		// Otherwise, return false.
		return false
		
	}
	
	
}
