import Foundation
import RxSwift

protocol RepoProtocol{
    
    func getDataArray() -> BehaviorSubject<[CardData]>
    func fetchListItems(currentListSize: Int)
    
}

class Repository : RepoProtocol{
  
    // this is an observable which holds our data
    private let listObservable = BehaviorSubject<[CardData]>(value: [])
    
    func getDataArray() -> BehaviorSubject<[CardData]>{
        return listObservable
    }

        
    func fetchListItems(currentListSize: Int){
        var dummyList : [CardData] = []
        let limit = 20
        
        // we calculate the next page's number with the size of the list we currently have
        let page = currentListSize/limit + 1
        
        // create an array of dummy data
        for index in 1...limit {
        dummyList.append(CardData(imgUrl: "string", points: 120, comment_count: 70, favorite_count: 56))
        }
        // update observable with new data
        listObservable.onNext(dummyList)
    }
  
}
