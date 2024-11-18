//
//  SummaryViewController.swift
//  studysphere
//
//  Created by admin64 on 07/11/24.
//

import UIKit

class SummaryListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
 
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var summaryList: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
            enum FilterState {
                case ongoing, completed
            }
        var cards: [Topics] = []
        var filteredCards: [Topics] {
                return cards.filter { card in
                   
                    let matchesSegment = filterState == .ongoing ? !card.completed : card.completed
                    let matchesSearch = searchBar.text?.isEmpty ?? true || card.title.lowercased().contains(searchBar.text!.lowercased())
                    return matchesSegment && matchesSearch
                }
            }
            var filterState: FilterState = .ongoing
            override func viewDidLoad() {
                super.viewDidLoad()
                print(summaryDb.findAll())
                summaryList.dataSource = self
                summaryList.delegate = self
                summaryList.setCollectionViewLayout(generateLayout(), animated: true)
                segmentControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
                searchBar.delegate = self
                cards = topicsDb.findAll(where: ["type": TopicsType.summary])
                print(cards)
            }
           
            @objc func segmentChanged() {
                filterState = segmentControl.selectedSegmentIndex == 0 ? .ongoing : .completed
                summaryList.reloadData()
            }
            
            func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                summaryList.reloadData()
            }
            
          
            func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                return cards.count
            }
            
            func numberOfSections(in collectionView: UICollectionView) -> Int {
                return 1
            }
            
            func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "summary", for: indexPath)
                let card = cards[indexPath.item]
                
                if let cell = cell as? SummaryCollectionViewCell {
                    cell.titleLabel.text = card.title
                    cell.subTitleLabel.text = card.subtitle
                    
                    if card.completed {
                        cell.continueButton.setTitle("Review", for: .normal)
                    } else {
                        cell.continueButton.setTitle("Continue Studying", for: .normal)
                    }
                    
                    cell.continueButton.tag = indexPath.item // Use the tag to identify
                    cell.continueButton.addTarget(self, action: #selector(detailButtonTapped(_:)), for: .touchUpInside)
                }
                
                return cell
            }
            
            func generateLayout() -> UICollectionViewLayout {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.27))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                
                return UICollectionViewCompositionalLayout(section: section)
            }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toSummary",
               let destinationVC = segue.destination as? SummariserViewController,
               let selectedIndex = sender as? Int {
                let selectedCard = filteredCards[selectedIndex]
                destinationVC.topic = selectedCard
            }
        }

        @objc func detailButtonTapped(_ sender: UIButton) {
            performSegue(withIdentifier: "toSummary", sender: sender.tag)
        }
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            cards = topicsDb.findAll(where: ["type": TopicsType.summary])
            summaryList.reloadData()
        }

    }
