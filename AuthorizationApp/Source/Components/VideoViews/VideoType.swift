import Foundation

enum VideoType {
    case mp4

    var stringValue: String {
        switch self {
        case .mp4:
            return ".mp4"
        }
    }
}
