import Foundation

struct GalleryResponse: Codable {
    let data: [GalleryContent]
    let success: Bool
    let status: Int
}
