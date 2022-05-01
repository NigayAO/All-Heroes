//
//  MainCollectionViewController.swift
//  All Heroes
//
//  Created by Alik Nigay on 26.04.2022.
//

import UIKit

private let reuseIdentifier = "hero"

class HeroesCollection: UICollectionViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty || searchBarScopeIsFiltering)
    }
    
    private var viewModel: HeroCollectionViewModelProtocol! {
        didSet {
            viewModel.fetchHeroes { [unowned self] in
                self.collectionView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HeroCollectionViewModel()
        setupCell()
        setupSearchController()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? HeroDetails else { return }
        detailVC.viewModel = sender as? HeroDetailsViewModelProtocol
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getHero(isFiltering: isFiltering).count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HeroCell
        cell.activityIndicator.startAnimating()
        cell.activityIndicator.hidesWhenStopped = true
        cell.imageView.layer.cornerRadius = 15
        cell.heroCellViewModel = viewModel.heroCellViewModel(isFiltering: isFiltering, indexPath: indexPath)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let heroDetailsViewModel = viewModel.heroDetailsViewModel(at: indexPath, isFiltering: isFiltering)
        performSegue(withIdentifier: "showDetail", sender: heroDetailsViewModel)
    }
}

//MARK: - Private methods
extension HeroesCollection {
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
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.scopeButtonTitles = ["All Heroes", "Publisher", "Alignment"]
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

//MARK: - UISearchController
extension HeroesCollection: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        viewModel.filterContentForSearchText(for: searchController.searchBar.text!, scope: scope) {
            self.collectionView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        viewModel.filterContentForSearchText(for: searchController.searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope]) {
            self.collectionView.reloadData()
        }
    }
}


