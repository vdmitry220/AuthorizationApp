import Foundation
import Rswift
import AVKit

class HomeViewModel {
    
    private weak var coordinator: Coordinator?
    private weak var authorizationService: AuthorizationService?
    private weak var videoApiService: VideoApiService?
    var videos = Observable([Video]())
    var updateCopletion: (() -> ())?

    init(
        coordinator: Coordinator,
        authorizationService: AuthorizationService,
        videoApiService: VideoApiService
    ){
        self.coordinator = coordinator
        self.authorizationService = authorizationService
        self.videoApiService = videoApiService
        generateVideoURL()
    }
}

// MARK: - HomeViewModel

extension HomeViewModel {
    
    func generateVideoURL() {
        videoApiService?.getData(onSucces: { videos in
            videos.forEach({ self.videos.value.append(Video(
                url: $0.url,
                title: self.removeWord(word: $0.title))) })
            self.updateCopletion?()
        })
    }
    
    func updateData(completion: @escaping () -> ()) {
        updateCopletion = completion
    }
    
    func removeWord(word: String) -> String {
        var sentence = word
        let wordToRemove = ".mp4"
        if let range = sentence.range(of: wordToRemove) {
            sentence.removeSubrange(range)
        }
        
        return sentence
    }
}

// MARK: - Navigate

extension HomeViewModel {
    func playFullScreenVideo(_ player: AVPlayer) {
        coordinator?.navigate(.fullScreen(player: player))
    }
}



