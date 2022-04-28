//
//  MainCollectionViewController.swift
//  All Heroes
//
//  Created by Alik Nigay on 26.04.2022.
//

import UIKit

private let reuseIdentifier = "hero"

class MainCollectionViewController: UICollectionViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredArray: [Hero] = []
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty || searchBarScopeIsFiltering)
    }
    
    private var heroes: [Hero] = []
    private var senderHero: Hero!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCell()
        fetchStartData()
        setupSearchController()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController else { return }
        detailVC.hero = senderHero
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        isFiltering ? filteredArray.count : heroes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HeroCell
        let hero = isFiltering ? filteredArray[indexPath.row] : heroes[indexPath.row]
        cell.activityIndicator.startAnimating()
        cell.activityIndicator.hidesWhenStopped = true
        cell.imageView.layer.cornerRadius = 15
        cell.initialSetup(hero: hero)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        senderHero = isFiltering ? filteredArray[indexPath.row] : heroes[indexPath.row]
        performSegue(withIdentifier: "showDetail", sender: self)
    }
}

//MARK: - Private methods
extension MainCollectionViewController {
    private func setupCell() {
        title = "Heroes and Villains"
        
        let width = UIScreen.main.bounds.width / 2 - 20
        let height = UIScreen.main.bounds.height / 2.5
        
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

//MARK: - UISearchController
extension MainCollectionViewController: UISearchResultsUpdating, UISearchBarDelegate {
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.scopeButtonTitles = ["Среди всех", "Издательство", "Сторона"]
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(for: searchController.searchBar.text!, scope: scope)
    }
    
    private func filterContentForSearchText(for searchText: String, scope: String = "All") {
        filteredArray = heroes.filter({ hero in
            guard let name = hero.name else { return false }
            guard let publisher = hero.biography?.publisher else { return false }
            guard let alignment = hero.biography?.alignment else { return false }
            switch scope {
            case "Alignment":
                return alignment.lowercased().contains(searchText.lowercased())
            case "Publisher":
                return publisher.lowercased().contains(searchText.lowercased())
            default:
                return name.lowercased().contains(searchText.lowercased())
            }
        })
        collectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(for: searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}


