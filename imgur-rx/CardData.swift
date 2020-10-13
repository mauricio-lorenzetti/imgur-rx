import Foundation

struct CardData: Identifiable {
    
    var id = UUID()
    
    var imgUrl: String
    var points: Int
    var comment_count: Int
    var favorite_count: Int
    
    init(imgUrl: String, points: Int, comment_count: Int, favorite_count: Int) {
        self.imgUrl = imgUrl
        self.points = points
        self.comment_count = comment_count
        self.favorite_count = favorite_count
    }
}

