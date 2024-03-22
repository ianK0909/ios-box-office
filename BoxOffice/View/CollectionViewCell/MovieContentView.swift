
import UIKit

class MovieContentView: UIView, UIContentView {
    
    private let rankLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.textAlignment = .center
        return label
    }()
    
    private let newMovieLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle:  .caption1)
        label.textAlignment = .center
        return label
    }()
    
    private var rankStackView = UIStackView()

    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    private let movieAudienceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = .systemGray
        return label
    }()
    
    private var movieStackView = UIStackView()
        
    var configuration: UIContentConfiguration {
        didSet {
            apply(configuration)
        }
    }
    
    init(configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        
        apply(configuration)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func apply(_ configuration: UIContentConfiguration) {
        guard let configuration = configuration as? MovieConfiguration else {
            return
        }
        
        guard let audienceCount = configuration.audienceCount,
                let audienceAccumulation = configuration.audienceAccumulation,
                let rankFluctuation = configuration.rankFluctuation else {
            return
        }
        
        rankLable.text = configuration.rank
        movieNameLabel.text = configuration.movieName
        movieAudienceLabel.text = "오늘 \(audienceCount) / 총 \(audienceAccumulation) "
        if configuration.rankOldAndNew?.rawValue == "NEW" {
            newMovieLabel.text = "신작"
            newMovieLabel.textColor = .red
        } else if rankFluctuation == "0" {
            newMovieLabel.text = "-"
        } else if rankFluctuation.hasPrefix("-") {
            newMovieLabel.text = "▼\(rankFluctuation.replacingOccurrences(of: "-", with: ""))"
            newMovieLabel.textColor = .blue
        } else {
            newMovieLabel.text = "▲\(rankFluctuation)"
            newMovieLabel.textColor = .red
        }
    }
    
    func configureUI() {
        addSubview(rankStackView)
        addSubview(movieNameLabel)
        addSubview(movieAudienceLabel)
        
        rankLable.adjustsFontForContentSizeCategory = true
        newMovieLabel.adjustsFontForContentSizeCategory = true
        
        rankStackView.translatesAutoresizingMaskIntoConstraints = false
        rankStackView.axis = .vertical
        rankStackView.alignment = .center
        rankStackView.addArrangedSubview(rankLable)
        rankStackView.addArrangedSubview(newMovieLabel)
        
        movieNameLabel.adjustsFontForContentSizeCategory = true
        movieNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        movieAudienceLabel.adjustsFontForContentSizeCategory = true
        movieAudienceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        autoLayout()
    }
    
    func autoLayout() {
        
        rankStackView.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        rankStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
        rankStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        rankStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2).isActive = true
        
        movieNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10).isActive = true
            movieNameLabel.leadingAnchor.constraint(equalTo: rankStackView.trailingAnchor, constant: 10).isActive = true
            movieNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        movieAudienceLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor).isActive = true
        movieAudienceLabel.leadingAnchor.constraint(equalTo: movieNameLabel.leadingAnchor).isActive = true
        movieAudienceLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
