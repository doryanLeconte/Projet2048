//
//  ViewController.swift
//  Projet2048
//
//  Created by Doryan on 17/02/2021.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet
    var cells: UICollectionView!;
    
    @IBOutlet
    var score: UILabel!;
    
    @IBOutlet
    var button: UIButton!;
    
    var nbLignes: Int = 4;
    var nbColones: Int = 4;
    
    let espacementCellules = 10;
    
    var cellules: [[CelluleJeu?]];
    
    var reglesJeu: ReglesJeu
    
    required init?(coder aDecoder: NSCoder) {
        self.nbLignes = 4;
        self.nbColones = 4;
        cellules = [[]];
        cellules = ([[CelluleJeu?]](repeating: [], count: self.nbLignes))
        for j in 1...self.nbLignes {
            let ligne = [CelluleJeu?](repeating: nil, count: self.nbColones)
            cellules[j-1] = ligne
        }
        reglesJeu = ReglesJeu(coder: aDecoder, nombreLigne: self.nbLignes, nombreColones: self.nbColones)!
        super.init(coder: aDecoder);
    }
    
    init?(coder aDecoder: NSCoder, nombreLignes: Int, nombreColonnes: Int){
        self.nbLignes = nombreLignes;
        self.nbColones = nombreColonnes;
        cellules = [[]];
        cellules = ([[CelluleJeu?]](repeating: [], count: nombreLignes))
        for j in 1...nombreLignes {
            let ligne = [CelluleJeu?](repeating: nil, count: nombreColonnes)
            cellules[j-1] = ligne
        }
        reglesJeu = ReglesJeu(coder: aDecoder, nombreLigne: self.nbLignes, nombreColones: self.nbColones)!
        super.init(coder: aDecoder);
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nbLignes;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return nbColones;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        cellules[indexPath.section][indexPath.row]!.dessineCellule()
        return cellules[indexPath.section][indexPath.row]!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: CGFloat(espacementCellules));
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (cells.frame.width - CGFloat(espacementCellules * (nbColones+2)))/CGFloat(nbColones), height: (cells.frame.height - CGFloat(espacementCellules * (nbLignes+2)))/CGFloat(nbColones));
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        cells.delegate = self;
        cells.dataSource = self;
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout();
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: CGFloat(espacementCellules), bottom: 0, right: CGFloat(espacementCellules))
        
        layout.minimumLineSpacing = CGFloat(espacementCellules)
        
        cells.setCollectionViewLayout(layout, animated: false)
        
        for i in 0...3 {
            for j in 0...3 {
                cellules[i][j] = cells.dequeueReusableCell(withReuseIdentifier: "cell2048", for: NSIndexPath(row: i, section: j) as IndexPath) as? CelluleJeu
            }
        }
        cells.backgroundColor = UIColor.gray;
        
        let detectionMouvementR: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.mouvement))
        detectionMouvementR.direction = .right
        view.addGestureRecognizer(detectionMouvementR)
        
        let detectionMouvementL: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.mouvement))
        detectionMouvementL.direction = .left
        view.addGestureRecognizer(detectionMouvementL)
        
        let detectionMouvementH: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.mouvement))
        detectionMouvementH.direction = .up
        view.addGestureRecognizer(detectionMouvementH)
        
        let detectionMouvementB: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.mouvement))
        detectionMouvementB.direction = .down
        view.addGestureRecognizer(detectionMouvementB)
    }
    
    @objc func mouvement(sender: UISwipeGestureRecognizer) {
        score.text = "Score : \(reglesJeu.getScore(cellules: cellules))"
        var mouvementMade: Bool = false
        switch sender.direction {
        case UISwipeGestureRecognizer.Direction.right:
            mouvementMade = reglesJeu.mouvement(x: 1, y: 0, cellules: cellules)
            
        case UISwipeGestureRecognizer.Direction.left:
            mouvementMade = reglesJeu.mouvement(x: -1, y: 0, cellules: cellules)
            
        case UISwipeGestureRecognizer.Direction.up:
            mouvementMade = reglesJeu.mouvement(x: 0, y: -1, cellules: cellules)
            
        case UISwipeGestureRecognizer.Direction.down:
            mouvementMade = reglesJeu.mouvement(x: 0, y: 1, cellules: cellules)
            
        default:
            break
        }
        
        if mouvementMade {
            reglesJeu.generateNewCell(cellules: cellules)
        }
    }

    
    
    
    @IBAction func rempli() {
        for i in 0...nbLignes-1 {
            for j in 0...nbColones-1 {
                cellules[i][j]!.valeur = 0
            }
        }
        reglesJeu.generateNewCell(cellules: cellules)
        
        button.setTitle("Recommencer", for: .normal)
       
    }

}

