//
//  ImageSaver.swift
//  HotProspects
//
//  Created by Dev Patel on 7/11/23.
//

import UIKit

class ImageSaver: NSObject {
    var successHandler: (() -> Void)?
    var failureHandler: ((Error) -> Void)?
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            failureHandler?(error)
        } else {
            successHandler?()
        }
    }
}
