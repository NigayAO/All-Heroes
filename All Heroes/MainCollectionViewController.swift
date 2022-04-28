//
//  MainCollectionViewController.swift
//  All Heroes
//
//  Created by Alik Nigay on 26.04.2022.
//

import UIKit

private let reuseIdentifier = "hero"

class MainCollectionViewController: UICollectionViewController {
    
    private var heroes: [Hero] = []
    private var senderHero: Hero!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCell()
        fetchStartData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController else { return }
        detailVC.hero = senderHero
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        heroes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HeroCell
        let hero = heroes[indexPath.item]
        cell.activityIndicator.startAnimating()
        cell.activityIndicator.hidesWhenStopped = true
        cell.imageView.layer.cornerRadius = 15
        cell.backgroundColor = .gray
        cell.initialSetup(hero: hero)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        senderHero = heroes[indexPath.item]
        performSegue(withIdentifier: "showDetail", sender: self)
    }
}

//MARK: - Private methods
extension MainCollectionViewController {
    private func setupCell() {
        title = "Heroes and Villains"
        
        let width = UIScreen.main.bounds.width / 2 - 20
        let height = UIScreen.main.bounds.height / 2.5
        
        collectionView.backgroundColor = .gray
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        flowLayout.itemSize = CGSize(width: width, height: height)
        collectionView.collectionViewLayout = flowLayout
    }
    
    private func fetchStartData() {
        NetworkManager.shared.fetchData { result in
            switch result {
            case .success(let receivedHeroes):
                self.heroes = receivedHeroes
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

