import SwiftUI

struct ContentView: View {
    
    @ObservedObject var myList = ObservableArray<CardData>(array: [])
        
    //initialize ViewModel class which we will use to requests for data
    let viewModel = ViewModel()

    init() {
        // pass viewupdateprotocol to viewmodel
        self.viewModel.viewUpdate = self
    }
    
    var body: some View {
        
        List(0..<5) { item in
            CardView(card: CardData(imgUrl: "athenal", points: 120, comment_count: 70, favorite_count: 56))
        }
    }
}

extension ContentView: ViewUpdateProtocol{
    func appendData(list: [CardData]?) {
        
    }

}

protocol ViewUpdateProtocol{
    func appendData(list: [CardData]?)
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
            Image(card.imgUrl)
                .resizable()
                .aspectRatio(contentMode: .fit)
 
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
    }
}
