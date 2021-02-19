//
//  Cellule.swift
//  Projet2048
//
//  Created by Doryan on 17/02/2021.
//

import Foundation
import UIKit

class CelluleJeu: UICollectionViewCell {
    var valeur: Int = 0 {
        didSet {
            dessineCellule()
        }
    }
    var hasMoved: Bool = false;
    
    
    var texte: UILabel! = nil;
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func dessineCellule() {
        if texte == nil {
            texte = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height));
            texte.numberOfLines = 1;
            texte.textAlignment = .center;
            texte.textColor = UIColor.white;
        }
        switch valeur {
        case let x where x >= 2 && x <= 16:
            texte.text = "\(x)";
            self.backgroundColor = UIColor.lightGray;
        case let x where x >= 32 && x <= 256:
            texte.text = "\(x)";
            self.backgroundColor = UIColor.yellow;
        case let x where x >= 512 && x <= 2048:
            texte.text = "\(x)";
            self.backgroundColor = UIColor.brown;
        case let x where x > 2048 :
            texte.text = "\(x)";
            self.backgroundColor = UIColor.red;
        default:
            texte.text = "";
            self.backgroundColor = UIColor.darkGray;
        }
        self.contentView.addSubview(texte);
    }
}



