
struct DailyBoxOfficeList: Codable, Hashable{
    let rankNumber: String
    let rank: String
    let rankChanged: String
    let movieCode: String
    let movieName: String
    let openDate: String
    let salesAmount: String
    let salesShare: String
    let salesChanged: String
    let salesAccumulated: String
    let screenCount: String
    let showCount: String
    let rankOldAndNew: RankOldAndNew
    let audienceCount: String
    let audienceAccumulation: String
    
    enum CodingKeys: String, CodingKey {
        case rankNumber = "rnum"
        case rank
        case rankChanged = "rankInten"
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
        case salesAmount = "salesAmt"
        case salesShare
        case salesChanged = "salesInten"
        case salesAccumulated = "salesAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
        case rankOldAndNew
        case audienceCount = "audiCnt"
        case audienceAccumulation = "audiAcc"
    }
}
