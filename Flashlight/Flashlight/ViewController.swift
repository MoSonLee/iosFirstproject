//
//  ViewController.swift
//  Flashlight
//
//  Created by 이승후 on 2021/08/16.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {

    @IBOutlet weak var flashImageView: UIImageView!
    @IBOutlet weak var switchButton: UIButton!
    
    var isOn = false
    var soundPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareSound()
    }

    func prepareSound() {
        
        let path = Bundle.main.path(forResource: "switch.wav", ofType:nil)!
        let url = URL(fileURLWithPath: path)

        do {
            soundPlayer = try AVAudioPlayer(contentsOf: url)
            soundPlayer?.prepareToPlay()
        } catch {
            // couldn't load file :(
        }
    }
    func toggleTorch(on: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }

        if device.hasTorch {
            do {
                try device.lockForConfiguration()

                if on == true {
                    device.torchMode = .on
                } else {
                    device.torchMode = .off
                }

                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
    @IBAction func switchTapped(_ sender: Any) {
        
        isOn  = !isOn
        
        soundPlayer?.play()
        toggleTorch(on: isOn)
//        if isOn == true {
//            switchButton.setImage(#imageLiteral(resourceName: "onSwitch"), for: .normal)
//            flashImageView.image = #imageLiteral(resourceName: "onBG")
//    }
//
//        else {
//            switchButton.setImage(#imageLiteral(resourceName: "offSwitch"), for: .normal)
//            flashImageView.image = #imageLiteral(resourceName: "offBG")
//}
    
        flashImageView.image = isOn ? #imageLiteral(resourceName: "onBG") : #imageLiteral(resourceName: "offBG")
        switchButton.setImage(isOn ? #imageLiteral(resourceName: "onSwitch") : #imageLiteral(resourceName: "offSwitch"), for: .normal)
}

}
