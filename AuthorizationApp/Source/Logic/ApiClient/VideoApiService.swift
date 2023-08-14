import Foundation
import FirebaseStorage
import Firebase

protocol VideoApiService: AnyObject {
    func getData(onSucces: @escaping ([Video]) -> ())
}

class VideoApiServiceImp {
    let storage = Storage.storage()
    let reference = Storage.storage().reference()
    let group = DispatchGroup()
}

extension VideoApiServiceImp: VideoApiService {
    
    func getData(onSucces: @escaping ([Video]) -> ()) {
        let path = "videos/countries"
        let downloadRef = reference.child(path)
        var videoURL: [Video] = []
        
        downloadRef.listAll { result, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let result = result else { return }
            for item in result.items {
                self.group.enter()
                item.downloadURL { url, error in
                    
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    
                    guard let url = url else { return }
                    videoURL.append(Video(url: url, title: item.name))
                    self.group.leave()
                }
            }
            self.group.notify(queue: .main) {
                onSucces(videoURL)
            }
        }
    }
}
