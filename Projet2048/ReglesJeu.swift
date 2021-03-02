//
//  ReglesJeu.swift
//  Projet2048
//
//  Created by Doryan on 17/02/2021.
//

import Foundation
import UIKit

class ReglesJeu {
    var score: Int = 0
    var nbLignes: Int
    var nbColones: Int
    var won: Bool = false
    
    required init?(coder aDecoder: NSCoder, nombreLigne: Int, nombreColones: Int) {
        self.nbLignes = nombreLigne;
        self.nbColones = nombreColones;
    }
    
    fileprivate func isCellOnBoard (_ i: Int, _ j: Int, _ y: Int,  _ x: Int) -> Bool {
        
        let isCellOnBoard = ((i+y) >= 0) && ((i + y) < nbLignes) && ((x + j) >= 0) && ((x + j) < nbColones)
        return isCellOnBoard
    }
    
    fileprivate func addCells(_ i: Int, _ j: Int, _ y: Int, _ x: Int, _ cellules: [[CelluleJeu?]]) -> Bool {
        return isCellOnBoard(i, j, y, x) && moveCell(cellule: cellules[i][j], destination: cellules[i+y][j+x])
    }
    
    func mouvement(x: Int, y: Int, cellules:[[CelluleJeu?]]) -> Bool {
        var mouvementMade: Bool = false
        if x < 0 || y < 0{
            for i in 0...nbLignes-1 {
                for j in 0...nbColones-1 {
                    var newI = i
                    var newJ = j
                    while addCells(newI, newJ, y, x, cellules)  {
                        mouvementMade = true
                            newI += y
                            newJ += x
                        
                    }
                }
            }
        }
        if y > 0 {
            for i in stride(from: nbLignes-1, to: -1, by: -1) {
                for j in 0...nbColones-1 {
                    var newI = i
                    var newJ = j
                    while addCells(newI, newJ, y, x, cellules)   {
                        mouvementMade = true
                            newI += y
                            newJ += x
                        
                    }
                }
            }
        }
        if x > 0 {
            for i in 0...nbLignes {
                for j in stride(from: nbColones-1, to: -1, by: -1) {
                    var newI = i
                    var newJ = j
                    while addCells(newI, newJ, y, x, cellules)   {
                        mouvementMade = true
                            newI += y
                            newJ += x
                        
                    }
                }
            }
        }
        
        return mouvementMade
        
    }
    
    func isLost(cellules:[[CelluleJeu?]]) -> Bool {
        var canMove: Bool = false
        for i in 0...nbLignes-1 {
            for j in 0...nbColones-1 {
                canMove = canMove || self.canMove(i, j, 0, -1, cellules)
                canMove = canMove || self.canMove(i, j, -1, 0, cellules)
            }
        }
        for i in stride(from: nbLignes-1, to: -1, by: -1) {
            for j in 0...nbColones-1 {
                canMove = canMove || self.canMove(i, j, 1, 0, cellules)
            }
        }
        for i in 0...nbLignes {
            for j in stride(from: nbColones-1, to: -1, by: -1) {
                canMove = canMove || self.canMove(i, j, 0, 1, cellules)
            }
        }
        print("in is lost : \(!canMove)")
        return !canMove
        
    }
    
    func canMove(_ i: Int, _ j: Int, _ y: Int, _ x: Int, _ cellules: [[CelluleJeu?]]) -> Bool {
        return isCellOnBoard(i, j, y, x) && (cellules[i][j]!.valeur != 0 && (cellules[i+y][j+x]!.valeur == 0 || cellules[i+y][j+x]!.valeur == cellules[i][j]!.valeur))
    }
    
    
    func moveCell (cellule:CelluleJeu?, destination: CelluleJeu?) -> Bool{
        if cellule!.valeur != 0 {
            
            
            if destination!.valeur == 0 || destination!.valeur == cellule!.valeur {
                destination!.valeur += cellule!.valeur
                cellule!.valeur = 0
                return true
            }
        }
        return false
    }
    
    func getScore(cellules:[[CelluleJeu?]]) -> Int {
        var score = 0
        for i in 0...nbLignes-1 {
            for j in 0...nbColones-1 {
                score += cellules[i][j]!.valeur
                if cellules[i][j]!.valeur == 2048 {
                    self.won = true
                }
            }
        }
        return score
    }
    
    
    
    func generateNewCell(cellules:[[CelluleJeu?]]) {
        var generated: Bool = false
        let valeur_possible = [2, 4]
        while !generated {
            let randX = Int.random(in: 0...nbColones-1)
            let randY = Int.random(in: 0...nbLignes-1)
            
            if (cellules[randX][randY]!.valeur == 0) {
                generated = true
                cellules[randX][randY]!.valeur = valeur_possible.randomElement()!
            }
        }
    }
    
}
