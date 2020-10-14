import SwiftUI
import URLImage
import SDWebImage
import SDWebImageSwiftUI
import VideoPlayer

struct ContentView: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    let myGray = UIColor(red: 0.28, green: 0.29, blue: 0.32, alpha: 1.00)
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = myGray
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        viewModel.fetch()
    }
    
    var body: some View {
        
        NavigationView {
            
            List(viewModel.content) { item in
                ZStack {
                    CardView(card: CardData(imgUrl: item.availableMediaLink, points: (item.ups - item.downs), comment_count: item.commentCount, favorite_count: item.favoriteCount, media_type: item.mediaType ?? .image))
                        .navigationTitle("Top Weekly")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

struct CardView: View {
    
    let myGray = UIColor(red: 0.28, green: 0.29, blue: 0.32, alpha: 1.00)
    var card : CardData
    @State private var play: Bool = true
    
    var body: some View {
        VStack {
            switch card.mediaType {
            case .image:
                URLImage(URL(string: card.imgUrl)!, placeholder: { _ in
                    Image(uiImage: UIImage(named: "dislike")!)
                        .frame(width: 339, height: 178, alignment: .center)
                    })
                { proxy in
                    proxy.image
                        .resizable()
                        .clipped()
                        .scaledToFill()
                }
                .frame(width: 339, height: 178, alignment: .top)
                .clipped()
                
            case .gif:
                AnimatedImage(url: URL(string: card.imgUrl)!, isAnimating: $play)
                    .maxBufferSize(.max)
                    .indicator(SDWebImageActivityIndicator.medium)
                    .resizable()
                    
                    
            case .video:
                VideoPlayer(url: URL(string: card.imgUrl)!, play: $play)
                    .autoReplay(true)
                    .scaledToFill()
                    .frame(width: 339, height: 178, alignment: .center)
                    .clipped()
                    
            }
            
            HStack(spacing: 45.0) {
                HStack(spacing: 8.0) {
                    Image("uparrow")
                    Text(String(card.points))
                        .font(.body)
                        .foregroundColor(Color(UIColor(red: 0.69, green: 0.69, blue: 0.69, alpha: 1.00)))
                        .fontWeight(.light)
                }
                HStack(spacing: 8.0) {
                    Image("comment")
                    Text(String(card.comment_count))
                        .font(.body)
                        .foregroundColor(Color(UIColor(red: 0.69, green: 0.69, blue: 0.69, alpha: 1.00)))
                        .fontWeight(.light)
                }
                HStack(spacing: 8.0) {
                    Image("eye")
                    Text(String(card.favorite_count))
                        .font(.body)
                        .foregroundColor(Color(UIColor(red: 0.69, green: 0.69, blue: 0.69, alpha: 1.00)))
                        .fontWeight(.light)
                }
                .layoutPriority(100)
            }
            .padding()
        }
        .clipped()
        .background(Color(myGray))
        .cornerRadius(6)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 2)
        )
        .padding([.top, .horizontal])
        .frame(width: 339, height: 234, alignment: .center)
    }
}
