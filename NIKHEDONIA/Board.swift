//
//  Board.swift
//  NIKHEDONIA
//
//  Created by Zachary Williams on 12/29/17.
//  Copyright © 2017 Zachary Williams. All rights reserved.
//

import Foundation
import SpriteKit

class Board {
    
    // DEBUG CODE
    
    var inDebugMode = true
    
    func debug(message: String) {
        if inDebugMode {
            print("DEBUG: " + message)
        }
    }
    
    // REGULAR CODE
    
    private let BoardSize = 9
    
    // 2D array holding all structures on the board.
    private var board : [[Structure]]
    
    // int holding who's turn it currently is (1 for player 1 and 2 for player 2)
    private var currentTurn : Int
  
    // initiate all positions on the board with a blank structure
    init(boardType: String) {
        currentTurn = 1
        board = []
        // loop through all rows and columns of the board
        for _ in 0 ..< BoardSize {
            var tempArray : [Structure] = []
            for _ in 0 ..< BoardSize {
                tempArray.append(Structure())
            }
            board.append(tempArray)
        }
        switch (boardType) {
            case ("first board"): debug(message: "first board selected") // resources for this board should be added here
            default: debug(message: "no board selected")
        }
    }
    
    // create a strucutre in a given position and animate it
    func buildStructure(structure: Structure, row: Int, column: Int) {
        if board[row][column].getOwner() == 0 {
            // this is repeated twice to ensure that the structure being placed has priority in structure life checking
            for _ in 0...1 {
                board[row][column] = structure
                removeDeadStructures()
            }
        }
    }
    
    func getStructure(row: Int, column: Int) -> Structure {
        return board[row][column]
    }
    
    // find all stuctures that should be removed and remove them
    func removeDeadStructures() {
        var deadStructures : [[Bool]] = []
        // init deadStructures with false values
        for _ in 0 ..< BoardSize {
            var tempArray : [Bool] = []
            for _ in 0 ..< BoardSize{
                tempArray.append(false)
            }
            deadStructures.append(tempArray)
        }
        // check what structures cannot breathe, and add them to array
        for row in 0 ..< BoardSize { for column in 0 ..< BoardSize {
            if !canBreathe(row: row, column: column) {
                deadStructures[row][column] = true
            }
        }}
        // set all the 'dead' structures to new blank structures
        for row in 0 ..< BoardSize { for column in 0 ..< BoardSize {
            if deadStructures[row][column] == true {
                // build a structure using the default constructor, so it should be a blank tile
                buildStructure(structure: Structure(), row: row, column: column)
            }
        }}
    }
    
    // algorithm that checks if a structure should be alive or dead
    func canBreathe(row: Int, column: Int) -> Bool {
        
        // check above
        if row + 1 < BoardSize {
            if board[row + 1][column].getOwner() == 0 {
                return true
            }
        }
        
        // check below
        if row - 1 >= 0 {
            if board[row - 1][column].getOwner() == 0 {
                return true
            }
        }
        
        // check right
        if column + 1 < BoardSize {
            if board[row][column + 1].getOwner() == 0 {
                return true
            }
        }
        
        // check left
        if column - 1 >= BoardSize {
            if board[row][column - 1].getOwner() == 0 {
                return true
            }
        }
        
        // otherwise
        return false
    }
    
    // METHODS FOR USE BY THE VIEW
    
    func requestStructure(row: Int, column: Int, owner: Int) {
        
        if board[row][column].getOwner() == 0 {
            buildStructure(structure: Structure(owner: owner), row: row, column: column)
        }
        
    }
        
}
