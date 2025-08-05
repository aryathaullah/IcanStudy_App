import Foundation
import AVFoundation

class AudioHelper {
    static var audioPlayer: AVAudioPlayer?

    static func playSound(named fileName: String, withExtension fileExtension: String = "mp3") {
        if let soundURL = Bundle.main.url(forResource: fileName, withExtension: fileExtension) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
            } catch {
                print("Gagal memutar audio: \(error.localizedDescription)")
            }
        } else {
            print("File audio tidak ditemukan")
        }
    }
}
