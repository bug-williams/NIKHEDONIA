//
//  TextureManager.swift
//  NIKHEDONIA
//
//  Created by Zachary Williams on 11/10/17.
//  Copyright © 2017 Zachary Williams. All rights reserved.
//



import Foundation
import SpriteKit



class TextureManager {
    
    
    
    private var currentTheme = default
    
    
    
    private var default: [string:SKTexture] = [
        
        // Tiles
        
        "p1Building" : new SKTexture(imageNamed: #imageLiteral(resourceName: "default_tile-building-player1")),
        "tile-building-player2" : new SKTexture(imageNamed: #imageLiteral(resourceName: "default_tile-building-player2")),
        
        "tile_empty" : new SKTexture(imageNamed: default_tile-#imageLiteral(resourceName: "default_tile-empty")),
        "tile-petrolium" : SKTexture(imageNamed: default_tile-#imageLiteral(resourceName: "default_tile-petrolium")),
        
        // Buttons
        
        "button-builder-player1" : new SKTexture(imageNamed: #imageLiteral(resourceName: "default_button-builder-player1")),
        "button-builder-player2" : new SKTexture(imageNamed: #imageLiteral(resourceName: "default_button-builder-player2")),
        "button-builder-pressed" : new SKTexture(imageNamed: #imageLiteral(resourceName: "default_button-builder-pressed")),
        
        "button-fighter-player1" : new SKTexture(imageNamed: #imageLiteral(resourceName: "default_button-fighter-player1")),
        "button-fighter-player2" : new SKTexture(imageNamed: #imageLiteral(resourceName: "default_button-fighter-player2")),
        "button-fighter-pressed" : new SKTexture(imageNamed: #imageLiteral(resourceName: "default_button-fighter-pressed")),
        
        // Units
        
        "unit-builder-player1" : new SKTexture(imageNamed: "default_" + "unit_builder_player1"),
        "unit-builder-player2" : new SKTexture(imageNamed: #imageLiteral(resourceName: "default_unit-builder-player2"))
        
    ]
    
    
    
    func getTextureWithName(imageName: string) -> SKTexture {
        
        return currentTheme[imageName]
        
    }
    
    
    
}
