//
//  SearchController.swift
//  TestTask
//
//  Created by Vasiliy Matveev on 30.06.2020.
//  Copyright © 2020 Vasiliy Matveev. All rights reserved.
//

import UIKit

class SearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    let cellId = "cellId"
    var results = [Image]()
    let searchController = UISearchController(searchResultsController: nil)
    
    let activityIndicator: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.color = .darkGray
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Error loading data"
        label.font = .systemFont(ofSize: 28)
        label.textColor = UIColor(white: 0.5, alpha: 0.5)
        label.alpha = 0
        
        return label
    }()
    
    let enterSearhTermLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter search term above..."
        label.font = .systemFont(ofSize: 28)
        label.textColor = UIColor(white: 0.5, alpha: 0.5)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(ResultImageCell.self, forCellWithReuseIdentifier: cellId)
        navigationItem.title = "Search"
        
        collectionView.addSubview(activityIndicator)
        activityIndicator.centerInSuperview()
        
        collectionView.addSubview(errorLabel)
        errorLabel.centerInSuperview()
        collectionView.addSubview(enterSearhTermLabel)
        enterSearhTermLabel.centerInSuperview()
        
        
        setupSearchBar()
        
    }
    
    fileprivate func setupSearchBar() {
        navigationItem.searchController = self.searchController
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        enterSearhTermLabel.alpha = 0
        errorLabel.alpha = 0
        if let searchTerm = searchBar.searchTextField.text {
            activityIndicator.startAnimating()
            Service.shared.fetchImages(seatchTerm: searchTerm) { (searchResult: SearchResult?, err) in
                if let err = err {
                    print("Failed to load data:", err)
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.errorLabel.alpha = 1
                        self.collectionView.reloadData()
                    }
                    return
                }
                
                 self.results = searchResult?.images_results ?? []
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
                
            }
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let presentViewController = DetailImageController(images: results, currentNumber: indexPath.item)
        presentViewController.modalPresentationStyle = .fullScreen
        navigationController?.present(presentViewController, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return errorLabel.alpha == 0 ? results.count : 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ResultImageCell
        cell.image = self.results[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size: CGFloat = (view.frame.width / 4) - 10
        return .init(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
