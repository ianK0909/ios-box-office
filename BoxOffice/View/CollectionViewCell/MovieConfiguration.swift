
import UIKit

struct MovieConfiguration: UIContentConfiguration {
    var rank: String?
    var rankFluctuation: String?
    var movieName: String?
    var audienceCount: String?
    var audienceAccumulation: String?
    var rankOldAndNew: RankOldAndNew?
    
    func makeContentView() -> UIView & UIContentView {
        return MovieContentView(configuration: self)
    }
    
    func updated(for state: UIConfigurationState) -> MovieConfiguration {
        return self
    }
}
