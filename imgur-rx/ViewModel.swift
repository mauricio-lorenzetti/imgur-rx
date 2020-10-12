import Foundation
import RxSwift

class ViewModel {

  let repo : RepoProtocol
  var viewUpdate: ViewUpdateProtocol? = nil
  let disposeBag = DisposeBag()

  init (repo : RepoProtocol = Repository()){

    self.repo = repo

    // subscribe and start listening for changes in our data
    self.repo.getDataArray().subscribe({ [weak self] newList in
                                                      
    }).disposed(by: disposeBag)

  }
    

  func getNewItems(currentListSize: Int){

    // fetch new list items
    repo.fetchListItems(currentListSize: currentListSize)

  }
  
  func updateListItems(newList: [CardData]?){
    if newList != nil && !newList!.isEmpty{
      // append new lists to the bottom of the list we already have
    }
  }
  
}
