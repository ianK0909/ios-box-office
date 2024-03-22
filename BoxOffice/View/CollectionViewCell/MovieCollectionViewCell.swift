//
//  CollectionViewCell.swift
//  BoxOffice
//
//  Created by MAC2020 on 3/18/24.
//

import UIKit

class MoiveCollectionViewCell: UICollectionViewCell {
    var movie: DailyBoxOfficeList?
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        var newConfiguration = MovieConfiguration().updated(for: state)
        newConfiguration.rank = movie?.rank
        newConfiguration.rankFluctuation = movie?.rankChanged
        newConfiguration.movieName = movie?.movieName
        newConfiguration.audienceCount = movie?.audienceCount
        newConfiguration.audienceAccumulation = movie?.audienceAccumulation
        newConfiguration.rankOldAndNew = movie?.rankOldAndNew
        
        contentConfiguration = newConfiguration
    }
}
