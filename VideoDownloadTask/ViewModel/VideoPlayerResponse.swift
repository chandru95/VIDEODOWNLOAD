//
//  VideoPlayerResponse.swift
//  VideoDownloadTask
//
//  Created by Alen c james on 22/09/23.
//

import Foundation
import Foundation
class VideoPlayerResponse: NSObject {
    var sampleVideos: [SampleVideos] = []
    init(dict:[String:Any]) {
        if let videoPlayer = dict["SampleVideos"] as? [[String:Any]] {
            for sampleVideosData in videoPlayer {
                self.sampleVideos.append(SampleVideos(dict: sampleVideosData))
            }
        }
    }
}
class SampleVideos: NSObject {
    var video: String = ConstantString.k_EMPTY
    var Filename: String = ConstantString.k_EMPTY
    init(dict:[String:Any]) {
        self.video = dict.getString(key: "video")
        self.Filename = dict.getString(key: "Filename")
    }
}
