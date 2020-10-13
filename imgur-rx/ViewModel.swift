import Foundation
import RxSwift

enum GalleryStatus {
    case success
    case loading
    case error(error: Error)
}

protocol MainGalleryViewModelProtocol {
    func fetch()
}

class ViewModel: MainGalleryViewModelProtocol, ObservableObject {
    
    let title = "Top Weekly"

    private let galleryRepository: GalleryRepositoryProtocol?
    private let disposeBag = DisposeBag()
    private let _state = BehaviorSubject<GalleryStatus>(value: .loading)
    @Published var content = [GalleryContent]()
    var state: Observable<GalleryStatus> { return _state.asObserver() }
    
    init(repository: GalleryRepositoryProtocol = GalleryRepository()) {
        self.galleryRepository = repository
        self.setup()
    }
    
    private func setup() {
        galleryRepository?.state.subscribe(onNext: {
            [weak self] (value) in
            switch value {
            case .success(content: let content):
                self?.content.removeAll()
                self?.content.append(contentsOf: content)
                self?._state.onNext(.success)
            case .loading:
                self?._state.onNext(.loading)
            case .error(error: let error):
                self?._state.onNext(.error(error: error))
            }
        }, onError: {_ in }, onCompleted: {}, onDisposed: {})
    }
    
    func fetch() {
        galleryRepository?.fetch()
    }
  
}
