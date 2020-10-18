//
//  ViewController.swift
//  PHPickerViewController
//
//  Created by Cooper on 2020/10/18.
//

import UIKit
import PhotosUI

class ViewController: UIViewController {
    @IBOutlet var imageViews: [UIImageView]!
    
    
    @IBAction func selectPhotos(_ sender: Any) {
        var configuration = PHPickerConfiguration ()
        configuration.filter = .images
        
        configuration.selectionLimit = 3
        
        let picker = PHPickerViewController(configuration: configuration)
        
        picker.delegate = self
        present(picker, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
}

extension ViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        //below is for "Multi-photos selection"
        let itemProviders = results.map(\.itemProvider)
        for (i, itemProvider) in itemProviders.enumerated() where itemProvider.canLoadObject(ofClass: UIImage.self) {
            
            let previousImage = self.imageViews[i].image
            itemProvider.loadObject(ofClass: UIImage.self) {[weak self] (image, error) in
                DispatchQueue.main.async {
                    guard let self = self, let image = image as? UIImage, self.imageViews[i].image == previousImage else { return }
                    self.imageViews[i].image = image
                }
            }
        }
    }
        //below is for "Single photo selection"
//        let itemProviders = results.map(\.itemProvider)
//        if let itemProvider = itemProviders.first, itemProvider.canLoadObject(ofClass: UIImage.self) {
//            let previousImage = self.imageViews.first?.image
//            itemProvider.loadObject(ofClass: UIImage.self){[weak self] (image, error) in
//                DispatchQueue.main.async {
//                    guard let self = self, let image = image as? UIImage, self.imageViews.first?.image == previousImage else {
//                        return}
//                    self.imageViews.first?.image = image
//                }
//            }
//        }
//    }
        
}




