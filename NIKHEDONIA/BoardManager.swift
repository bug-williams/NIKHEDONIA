//
//  BoardManager.swift
//  NIKHEDONIA
//
//  Created by Zachary Williams on 11/9/17.
//  Copyright © 2017 Zachary Williams. All rights reserved.
//



import GameplayKit
import SpriteKit
import Foundation



class BoardManager {
    
    
    
    /*
     CLASS ATTRIBUTES
     The attributes for BoardManager.
    */
    
    
    
    /// A 2D array containing all the tiles on the board.
    private static var tiles = [[Tile]]()
    
    /// The total number of turns played this game.
    private static var numberOfTurnsTaken
    
    
    
    /*
     GIVETHS & TAKETHS
     (Getters and setters)
    */
    
    
    
    /**
     Gets a tile from a given column and row.
     
     - Parameter column: The column of the desired tile.
     - Parameter row: The row of the desired tile.
     
     - Returns: The tile from the given column and row.
    */
    static func getTile(column: int, row: int) -> Tile {
        
        return tiles[column][row]
        
    }
    
    
    
    /**
     Gets who's turn it currently is.
     
     - Returns: Returns an int. 1 for player one and 2 for player two.
    */
    static func getCurrentPlayer() -> int {
        
        if numberOfTurnsTaken % 2 == 0 { return 2 }
        
        // Otherwise...
        return 1
        
    }
    
    
    
    /*
     CONSTRUCTORS & INIT METHODS
     Used to set up the BoardManager and the board.
    */
    
    
    
    /**
     Initiates the board with Tile objects, sets up attributes, etc.
     
     - Returns: None.
    */
    static func initBoardManager() {
        
        // Initiate attributes
        
        numberOfTurnsTaken = 0
        
        // Set up the game board.
    
        for column in size(tiles) {
            
            for row in size(tiles[column]) {
                
                var tile = Tile(column: column, row: row, owner: getCurrentPlayer(), image: ThemeManager.getBuildingTexture())
                
            }
            
        }
    
    }
    
    
    
    /*
     BOARD MANAGEMENT FUNCTIONS
     These functions manage the game board.
    */
    
    
    
    
    
    
    
}
