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
    
    required init?(coder aDecoder: NSCoder, nombreLigne: Int, nombreColones: Int) {
        self.nbLignes = nombreLigne;
        self.nbColones = nombreColones;
    }
    
    fileprivate func isCellOnBoard (_ i: Int, _ j: Int, _ y: Int,  _ x: Int) -> Bool {
        
        let isCellOnBoard = ((i+y) >= 0) && ((i + y) < nbLignes) && ((x + j) >= 0) && ((x + j) < nbColones)
        return isCellOnBoard
        //        return (y != 0 && ((i == 0 && y > 0) || (i == nbLignes-1 && y < 0) || (i>0 && i<nbLignes-1))) || (x != 0 && ((j == 0 && x > 0) || (j == nbColones-1 && x < 0) || (j>0 && j<nbColones-1)))
    }
    
    func mouvement(x: Int, y: Int, cellules:[[CelluleJeu?]]) {
        if x < 0 || y < 0{
            for i in 0...nbLignes-1 {
                for j in 0...nbColones-1 {
                    var newI = i
                    var newJ = j
                    while isCellOnBoard(newI, newJ, y, x) && moveCell(cellule: cellules[newI][newJ], destination: cellules[newI+y][newJ+x])  {
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
                    while isCellOnBoard(newI, newJ, y, x) && moveCell(cellule: cellules[newI][newJ], destination: cellules[newI+y][newJ+x])  {
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
                    while isCellOnBoard(newI, newJ, y, x) && moveCell(cellule: cellules[newI][newJ], destination: cellules[newI+y][newJ+x])  {
                            newI += y
                            newJ += x
                        
                    }
                }
            }
        }
        
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
            }
        }
        return score
    }
    
}
