import UIKit

enum MovieSection {
    case main
}

class MainView: UIView {
    
    private lazy var addDateLabel: UILabel = {
        let label = UILabel()
        label.text = getYesterdayDate(format: "yyyy-MM-dd")
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var boxofficeCollectionView: UICollectionView = {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        let boxofficeCollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        return boxofficeCollectionView
    }()
    
    private var networkManger = NetworkManager()
    private var movieList: [DailyBoxOfficeList] = []
    private var dataSource: UICollectionViewDiffableDataSource<MovieSection, DailyBoxOfficeList>?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureDataSourece()
        fetchData()
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fetchData() {
        let date = getYesterdayDate(format: "yyyyMMdd")
        let modifyUrl = networkManger.modifyUrlComponent(path: MovieOffice.DailyUrl)
        guard let url = modifyUrl?.appending("targetDt", value: date)?.absoluteString else {
            return
        }
        networkManger.fetchData(url: url, type: BoxOfficeData.self) { (result: Result<BoxOfficeData,  Error>) in
            switch result {
                case .success(let data):
                self.movieList = data.boxOfficeResult.dailyBoxOfficeList
                DispatchQueue.main.async {
                    self.applySnapshot()
                    self.boxofficeCollectionView.refreshControl?.endRefreshing()
                }
                case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @objc func handleRefresh() {
        fetchData()
    }
    
    private func configureDataSourece() {
        let cellRegistration = UICollectionView.CellRegistration<MoiveCollectionViewCell, DailyBoxOfficeList> { cell, indexPath, itemIdentifier in
            cell.movie = itemIdentifier
        }
        
        dataSource = UICollectionViewDiffableDataSource<MovieSection, DailyBoxOfficeList>(collectionView: boxofficeCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<MovieSection, DailyBoxOfficeList>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movieList, toSection: .main)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    private func configureUI() {
        boxofficeCollectionView.refreshControl = UIRefreshControl()
        boxofficeCollectionView.refreshControl?.addTarget(
            self,
            action: #selector(handleRefresh),
            for: .valueChanged
        )
        self.addSubview(addDateLabel)
        self.addSubview(boxofficeCollectionView)
        self.backgroundColor = .systemBackground

        autoLayout()
    }
    
    private func autoLayout() {
        
        addDateLabel.translatesAutoresizingMaskIntoConstraints = false
        addDateLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        addDateLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        boxofficeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        boxofficeCollectionView.topAnchor.constraint(equalTo: addDateLabel.topAnchor, constant: 30).isActive = true
        boxofficeCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        boxofficeCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        boxofficeCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        
    }
                                
    private func getYesterdayDate(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let yesterdayDate = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else {
            return "0000-00-00"
        }
        let convertDate = dateFormatter.string(from: yesterdayDate)
        return convertDate
    }
}
