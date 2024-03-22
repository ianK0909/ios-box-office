import UIKit

final class MovieCustomCell: UICollectionViewListCell {
    
    var movie: DailyBoxOfficeList2?
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        var newConfiguration = 
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
