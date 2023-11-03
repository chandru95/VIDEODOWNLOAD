//
//  ExtensionManager.swift
//  VideoDownloadTask
//
//  Created by Alen c james on 22/09/23.
//

import Foundation
import UIKit
import SJFrameSwift
extension UIView {
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
}
extension UIViewController {
    func showAlert(message:String,completion:((Bool)->())? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title:  "Alert", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                completion?(true)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showAlert(title:String,message:String,completion:((Bool)->())? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title:  title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"Ok", style: .default, handler: { _ in
                completion?(true)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showAlertWithDismiss(title:String,message:String,completion:((Bool)->())? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title:  title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                completion?(true)
            }))
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { cancel in
                completion?(false)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

//func downloadAllVideosAndSaveToFile(videoURL: String, videoName: String, completion: @escaping (Bool) -> Void) {
//    let documentsUrl: URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//    let destinationFileUrl = documentsUrl.appendingPathComponent("\(videoName).mp4")
//    let fileURL = URL(string: videoURL)
//    let sessionConfig = URLSessionConfiguration.default
//    let session = URLSession(configuration: sessionConfig, delegate: self, delegateQueue: nil)
//    let request = URLRequest(url: fileURL!)
//    let downloadTask = session.downloadTask(with: request) { (url, response, error) in
//        if let error = error {
//            print("Download completed with error: \(error.localizedDescription)")
//            completion(false)
//        } else {
//            do {
//                try FileManager.default.moveItem(at: url!, to: destinationFileUrl)
//                completion(true)
//            } catch {
//                print("Error moving video file: \(error.localizedDescription)")
//                completion(false)
//            }
//        }
//    }
//    downloadTask.resume()
//}
//

