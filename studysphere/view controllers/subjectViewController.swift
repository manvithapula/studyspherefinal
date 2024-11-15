//
//  subjectViewController.swift
//  studysphere
//
//  Created by admin64 on 05/11/24.
//

import UIKit

class subjectViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var cards: [Card] = [
        Card(title: "English Literature", subtitle: "1 more to go", isCompleted: false),
        Card(title: "Maths Literature", subtitle: "1 more to go", isCompleted: false),
        Card(title: "Chemistry Literature", subtitle: "1 more to go", isCompleted: false),
        Card(title: "Biology Literature", subtitle: "1 more to go", isCompleted: false),
        Card(title: "Biology Literature", subtitle: "1 more to go", isCompleted: true)
    ]
   
    var isSearching = false
    
    @IBOutlet weak var Subject: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        
        Subject.dataSource = self
        Subject.setCollectionViewLayout(generateLayout(), animated: true)
    }

   

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subject", for: indexPath)
        let card = cards[indexPath.item]
        if let cell = cell as? SummaryCollectionViewCell {
            cell.titleLabel.text = card.title
            cell.subTitleLabel.text = card.subtitle
            
            if card.isCompleted {
                cell.continueButton.setTitle("Review", for: .normal)
            } else {
                cell.continueButton.setTitle("Continue Studying", for: .normal)
            }
            
            
            cell.buttonTapped = {
                print("Button tapped for: \(card.title)")
               
            }
        }
        
        
        return cell
    }
    func generateLayout() -> UICollectionViewLayout {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.22))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)

            return UICollectionViewCompositionalLayout(section: section)
        }
}


