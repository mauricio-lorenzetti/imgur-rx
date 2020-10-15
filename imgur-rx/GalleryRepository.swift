import Foundation
import RxSwift

enum GalleryRepositoryStatus {
    case success(content: [GalleryContent])
    case loading
    case error(error: Error)
}

protocol GalleryRepositoryProtocol {
    var state: Observable<GalleryRepositoryStatus> { get }
    func fetch()
    func fetch(page:Int)
}

class GalleryRepository: GalleryRepositoryProtocol {

    private let _api: APIRequest
    private let _state = BehaviorSubject<GalleryRepositoryStatus>(value: .loading)
    var state: Observable<GalleryRepositoryStatus> { return _state.asObserver() }

    init(api: APIRequest = AFRequest()) {
        _api = api
    }

    func fetch() {
        _state.onNext(.loading)

        let resource = ImgurAPI.resourceURL.gallery(section: .top,
                                                sort: .top,
                                                window: .week,
                                                showViral: false,
                                                mature: false,
                                                albumPreviews: false)

        _api.get(url: resource.URLValue,
                onSuccess: { [weak self] (data) in
                    if let object = data.mapObject(GalleryResponse.self) {
                        self?._state.onNext(.success(content: object.data))
                        return
                    }
                    self?._state.onNext(.error(error: CustomError.mappingResponse))
        })
    }
    
    func fetch(page:Int) {
        _state.onNext(.loading)

        let resource = ImgurAPI.resourceURL.gallery(section: .top,
                                                sort: .top,
                                                window: .week,
                                                showViral: false,
                                                mature: false,
                                                albumPreviews: false)

        _api.get(url: resource.URLValue(page: page),
                onSuccess: { [weak self] (data) in
                    if let object = data.mapObject(GalleryResponse.self) {
                        self?._state.onNext(.success(content: object.data))
                        return
                    }
                    self?._state.onNext(.error(error: CustomError.mappingResponse))
        })
    }

}
