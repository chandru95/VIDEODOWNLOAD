//
//  VideoDownloadTableViewCellModel.swift
//  VideoDownloadTask
//
//  Created by Alen c james on 22/09/23.
//

import Foundation
class VideoDownloadTableViewCellModel: NSObject {
    var identifier = "video.tablecell.download"
    var response: VideoPlayerResponse?
    var sampleVideos: SampleVideos? = SampleVideos(dict: [:])
    var downloadProgress: Float = 0.0
    
    init(response: SampleVideos?){
        self.sampleVideos = response
    }
    func getFileName() -> String {
        sampleVideos?.Filename ?? ConstantString.k_EMPTY
    }
    func getVideo() -> String {
        sampleVideos?.video ?? ConstantString.k_EMPTY
    }
    
}
