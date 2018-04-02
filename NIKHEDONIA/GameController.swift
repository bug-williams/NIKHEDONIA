//
//  GameController.swift
//  NIKHEDONIA
//
//  Created by Zachary Williams on 1/13/18.
//  Copyright © 2018 Zachary Williams. All rights reserved.
//

import Foundation

class GameController {
   
    // this class should be initiated at the same time as the GameViewController.
    
    private var board : Board
    private var turnCounter : Int
    
    // init with no given board
    init() {
        board = Board(boardType: "first board")
        turnCounter = 0
    }
    
    // init with a specific board
    init(boardType: String) {
        board = Board(boardType: "first board")
        turnCounter = 0
    }
    
    // returns 1 for player 1, and 2 for player 2
    func getCurrentPlayer() -> Int {
        if ( turnCounter % 2 == 0 ) { return 1 }
        else { return 2 }
    }
    
    // gets a structure on the board
    func getStructure(row: Int, column: Int) -> Structure {
        return board.getStructure(row: row, column: column)
    }
    
    // FUNCTIONS TO BE CALLED BY THE VIEW
    
    func makeTurn(row: Int, column: Int, owner: Int) {

        board.requestStructure(row: row, column: column, owner: owner)
        turnCounter += 1
        
    }
    
}
