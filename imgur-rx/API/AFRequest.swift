import Foundation
import Alamofire

class AFRequest: APIRequest {

    func get(url: URL, onSuccess: @escaping APIResponseSuccess) {//, onError: @escaping ErrorClosure) {
        print("Request to \(url)")

        let headers: HTTPHeaders = [
            "Authorization": ImgurAPI.authorization,
            "Accept": "application/json"
        ]

        AF.request(url, headers: headers).responseData { (response) in
                if let error = response.error {
                    //onError(error)
                    return
                }
                guard let data = response.value else {
                    //onError(CustomError.serverError(details: "Empty Response for \(url)"))
                    return
                }
                onSuccess(data)
        }
    }
}
