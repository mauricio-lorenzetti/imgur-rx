import SwiftUI
import URLImage
import AVKit
import SwiftyGif
import SDWebImage
import SDWebImageSwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    init() {
        UITableView.appearance().separatorStyle = .none
        viewModel.fetch()
    }
    
    var body: some View {
        
        NavigationView {
            List(viewModel.content) { item in
                CardView(card: CardData(imgUrl: item.availableMediaLink, points: (item.ups - item.downs), comment_count: item.commentCount, favorite_count: item.favoriteCount, media_type: item.mediaType ?? .image)
                ).navigationTitle("Top Weekly")
            }.background(Color.gray)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

struct CardView: View {
    
    var card : CardData
    @State var isAnimating: Bool = true
    
    var body: some View {
        VStack {
            switch card.mediaType {
            case .image:
                URLImage(URL(string: card.imgUrl)!, placeholder: Image(systemName: "circle")) { proxy in
                    proxy.image
                        .resizable()
                        .clipped()
                        .scaledToFill()
                }
                .frame(width: 339, height: 178, alignment: .top)
                .clipped()
            case .gif:
                AnimatedImage(url: URL(string: card.imgUrl)!, isAnimating: $isAnimating)
                    .maxBufferSize(.max)
                    .indicator(SDWebImageActivityIndicator.medium)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 339, height: 178, alignment: .top)
                    .clipped()
            case .video:
                VideoPlayer(player: AVPlayer(url: URL(string: card.imgUrl)!))
                    .scaledToFill()
                    .frame(width: 339, height: 178, alignment: .top)
                    .clipped()
            }
            
            HStack(spacing: 45.0) {
                HStack(spacing: 8.0) {
                    Image("uparrow")
                    Text(String(card.points))
                        .font(.body)
                        .fontWeight(.ultraLight)
                }
                HStack(spacing: 8.0) {
                    Image("comment")
                    Text(String(card.comment_count))
                        .font(.body)
                        .fontWeight(.ultraLight)
                }
                HStack(spacing: 8.0) {
                    Image("eye")
                    Text(String(card.favorite_count))
                        .font(.body)
                        .fontWeight(.ultraLight)
                }
                .layoutPriority(100)
            }
            .padding()
        }
        .cornerRadius(6)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
        )
        .padding([.top, .horizontal])
        .frame(width: 339, height: 234, alignment: .center)
    }
}
