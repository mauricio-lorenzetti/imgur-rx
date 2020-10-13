import SwiftUI
import URLImage

struct ContentView: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    init() {
        viewModel.fetch()
    }
    
    var body: some View {
        
        List(viewModel.content) { item in
            CardView(card: CardData(imgUrl: item.availableMediaLink, points: (item.ups - item.downs), comment_count: item.commentCount, favorite_count: item.favoriteCount))
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
    
    var body: some View {
        VStack {
            URLImage(URL(string: card.imgUrl)!, placeholder: Image(systemName: "circle")) { proxy in
                proxy.image
                    .resizable()
                    .clipped()
                    .scaledToFill()
            }
            .frame(minWidth: 339, idealWidth: 339, maxWidth: 339, minHeight: 178, idealHeight: 178, maxHeight: 356, alignment: .top)
            HStack {
                HStack() {
                    Text(String(card.points))
                        .font(.headline)
                    Text(String(card.comment_count))
                        .font(.headline)
                    Text(String(card.favorite_count))
                        .font(.headline)
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
        .frame(minWidth: 339, idealWidth: 339, maxWidth: 339, minHeight: 234, idealHeight: 234, maxHeight: 702, alignment: .topLeading)
    }
}
