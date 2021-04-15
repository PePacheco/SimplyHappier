// Code inside modules can be shared between pages and other source files.
import AVFoundation

open class Player {
    public var audioPlayer: AVAudioPlayer?
    
    public init(_ music: String = "zen2") {
        if let path = Bundle.main.path(forResource: music, ofType: "m4a") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.numberOfLoops = -1
                audioPlayer?.volume = 0.2
            } catch {
                print("ERROR")
     
            }
        }
    }
    
    public func play() {
        audioPlayer?.play()
    }
}
