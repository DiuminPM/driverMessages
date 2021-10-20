//
//  ListViewController.swift
//  driverMessages
//
//  Created by DiuminPM on 17.10.2021.
//

import UIKit

struct MChat: Hashable, Decodable {
    var userName: String
    var userImageString: String
    var lastMessage: String
    var id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: MChat, rhs: MChat) -> Bool {
        return lhs.id == rhs.id
    }
    
}

class ListViewController: UIViewController {
    
    let waitingChats = Bundle.main.decode([MChat].self, from: "activeChats.json")
    let activeChats = Bundle.main.decode([MChat].self, from: "waitingChats.json")
    
    enum Section: Int, CaseIterable {
        case waitingChat, activeChats
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, MChat>?
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupSearcBar()
        createDataSource()
        realoadData()
    }
    
    private func setupSearcBar() {
        navigationController?.navigationBar.barTintColor = .mainWhite()
        navigationController?.navigationBar.shadowImage = UIImage()
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
    }
}

// MARK: - Setup ColectionView
extension ListViewController {
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .mainWhite()
        view.addSubview(collectionView)
        
        collectionView.register(ActiveClassCell.self, forCellWithReuseIdentifier: ActiveClassCell.reuseId)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId2")

    }
    
    private func realoadData() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, MChat>()
        snapShot.appendSections([.waitingChat, .activeChats])
        snapShot.appendItems(waitingChats, toSection: .waitingChat)
        snapShot.appendItems(activeChats, toSection: .activeChats)

        dataSource?.apply(snapShot, animatingDifferences: true)
    }
    
   
}

//MARK: - Data source
extension ListViewController {
    
    private func configure<T: SelfConfiguringCell>(cellType: T.Type, with value: MChat, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as?  T else {
            fatalError("Unable ti dequeue \(cellType)")
        }
        cell.configure(with: value)
        return cell
    }
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, MChat>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, chat) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("Unknow section kind")
            }
            
            switch section {
            
            case .activeChats:
                return self.configure(cellType: ActiveClassCell.self, with: chat, for: indexPath)
            case .waitingChat:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId2", for: indexPath)
                cell.backgroundColor = .systemRed
                return cell
            }
        })
    }
}

//MARK: - Setup layouts
extension ListViewController {
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnviroment) -> NSCollectionLayoutSection? in
            guard let section = Section(rawValue: sectionIndex) else {
                fatalError("Unknow section kind")
            }
            
            switch section {
            
            case .waitingChat:
                return self.createWaitingChat()
            case .activeChats:
                return self.createActiveChat()

            }
        }
        return layout
    }
    private func createWaitingChat() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(88), heightDimension: .absolute(88))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    private func createActiveChat() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(78))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
//        group.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 8, trailing: 0)

        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)
        return section
    }
}


//MARK: - UISearchBarDelegate
extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}


// MARK: - SwiftUI
import SwiftUI

struct ListViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let tabBarVC = MainTabBarController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ListViewControllerProvider.ContainerView>) -> MainTabBarController {
            return tabBarVC
        }
        
        func updateUIViewController(_ uiViewController: ListViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ListViewControllerProvider.ContainerView>) {
            
        }
    }
}
