//
//  VideoDownloadTableViewCell.swift
//  VideoDownloadTask
//
//  Created by Alen c james on 22/09/23.
//

import UIKit
import AVFoundation
import AVKit

protocol VideoDownloadTableViewCellDelegate {
    func didTapDownload(cellModel: VideoDownloadTableViewCellModel, index: Int)
    func didTapDelete(cellModel: VideoDownloadTableViewCellModel, index: Int)
}
class VideoDownloadTableViewCell: UITableViewCell {
    
    //MARK: -  OutLets
    @IBOutlet weak var lblFileName: UILabel?
    @IBOutlet weak var progressBar: UIProgressView?
    @IBOutlet weak var lblPercentage: UILabel?
    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    
    
    //MARK: - Variables
    var delegate: VideoDownloadTableViewCellDelegate?
    var cellModel: VideoDownloadTableViewCellModel!{
        didSet {
            configureCell()
        }
    }
    var player: AVPlayer?
    
    //MARK: - ViewLifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        progressBar?.progress = 0
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    //MARK: - Functions
    func configureCell() {
        lblFileName?.text = cellModel.getFileName()
    }
    func getVideoURL() -> URL? {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let videoFileName = "\(cellModel.getFileName()).mp4"
        let videoURL = documentsUrl?.appendingPathComponent(videoFileName)
        return videoURL
    }
    
    //MARK: - Actions
    
    @IBAction func btnDownloadCLicked(_ sender: UIButton) {
        delegate?.didTapDownload(cellModel: cellModel, index: sender.tag)
    }
    
    
    @IBAction func btnDeleteClicked(_ sender: UIButton) {
        delegate?.didTapDelete(cellModel: cellModel, index: sender.tag)
    }
    
    @IBAction func btnPlayClicked(_ sender: UIButton) {
        guard let videoURL = getVideoURL() else {
            return
        }
        let playerItem = AVPlayerItem(url: videoURL)
        player = AVPlayer(playerItem: playerItem)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        if let viewController = UIApplication.shared.keyWindow?.rootViewController {
            viewController.present(playerViewController, animated: true) {
                self.player?.play()
            }
        }
    }
}

