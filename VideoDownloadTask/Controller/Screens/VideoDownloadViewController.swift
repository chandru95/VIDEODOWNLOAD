//
//  ViewController.swift
//  VideoDownloadTask
//
//  Created by Alen c james on 22/09/23.
//

import UIKit
import SJFrameSwift

class VideoDownloadViewController: SJViewController {
    
    //MARK: - OutLets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables
    var cellModel = [VideoDownloadTableViewCellModel]()
    var response: VideoPlayerResponse = VideoPlayerResponse(dict: [:])
    var downloadTask: URLSessionDownloadTask?
    var download_urls = [String]()
    var selectedIndex: Int = 0
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        callServicesAPI()
        
    }
    
    //MARK: - Actions
    @IBAction func btnDownloadClicked(_ sender: UIButton) {
        downloadAllVideos()
    }
    
    @IBAction func btnDeleteClicked(_ sender: Any) {
        deleteAllVideos()
    }
    
    //MARK: - Functions
    func createCellModel() {
        cellModel = []
        for data in response.sampleVideos {
            cellModel.append(VideoDownloadTableViewCellModel(response: data))
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func downloadVideoAndSaveToFile(videoURL: String, videoName: String) {
        let documentsUrl: URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationFileUrl = documentsUrl.appendingPathComponent("\(videoName).mp4")
        let fileURL = URL(string: videoURL)
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: self, delegateQueue: nil)
        let request = URLRequest(url: fileURL!)
        downloadTask = session.downloadTask(with: request)
        downloadTask?.resume()
    }
    
    func deleteVideoFile(cellModel: VideoDownloadTableViewCellModel, index: Int) {
        let documentsUrl: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileUrlToDelete = documentsUrl.appendingPathComponent("\(cellModel.getFileName()).mp4")
        
        do {
            try FileManager.default.removeItem(at: fileUrlToDelete)
            DispatchQueue.main.async {
                cellModel.downloadProgress = 0.0
                self.tableView.reloadData()
            }
            print("Video Deleted successfully.")
        } catch {
            print("Error deleting video")
        }
    }
    
    func videoIsDownloaded(videoName: String) -> Bool {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileUrl = documentsUrl.appendingPathComponent("\(videoName).mp4")
        return FileManager.default.fileExists(atPath: fileUrl.path)
    }
    
    func deleteVideoFile(videoName: String) {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileUrlToDelete = documentsUrl.appendingPathComponent("\(videoName).mp4")
        
        do {
            try FileManager.default.removeItem(at: fileUrlToDelete)
            print("Video Deleted")
        } catch {
            print("Error deleting video")
        }
    }
    
    func downloadAllVideos() {
        let queue = DispatchQueue(label: "videoDownloadQueue", qos: .background, attributes: .concurrent)
        
        for (index, cellModel) in cellModel.enumerated() {
            let videoURL = cellModel.getVideo()
            let videoName = cellModel.getFileName()
            if videoIsDownloaded(videoName: videoName) {
                DispatchQueue.main.async {
                    self.showAlert(message: "Some Videos are already downloaded.")
                }
            } else {
                if !download_urls.contains(videoURL) {
                    download_urls.append(videoURL)
                }
                queue.async {
                    self.downloadVideoAndSaveToFile(videoURL: videoURL, videoName: videoName)
                    DispatchQueue.main.async {
                        self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
                    }
                }
            }
        }
    }

    func deleteAllVideos() {
        for cellModel in cellModel {
            let videoName = cellModel.getFileName()
            deleteVideoFile(videoName: videoName)
            cellModel.downloadProgress = 0.0
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
//MARK: - Extensions - Tableview DataSource and Delegate Methods
extension VideoDownloadViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = cellModel[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.identifier, for: indexPath) as! VideoDownloadTableViewCell
        cell.cellModel = cellModel
        cell.delegate = self
        cell.btnDownload.tag = indexPath.row
        cell.btnDelete.tag = indexPath.row
        DispatchQueue.main.async {
            cell.progressBar?.progress = cellModel.downloadProgress
            cell.lblPercentage?.text = "\(Int(cellModel.downloadProgress * 100))%"
        }
        return cell
    }
}

//MARK: - Extensions - ApiCall
extension VideoDownloadViewController {
    func callServicesAPI() {
        let networkController = APINetworkController()
        let objRequest = AppBaseRequest(ConstantAPI.k_GET_SERVICES, ConstantAPI.k_REQUEST_TYPE_GET)
        self.showLoader()
        networkController.callWebserviceRequest(objRequest) { objResponse in
            if objResponse.api_status {
                if let result = objResponse.resultData as? [String:Any], objResponse.api_status == true {
                    print("result====", result)
                    self.response = VideoPlayerResponse(dict: result)
                    self.createCellModel()
                }
                else {
                    if let errorDetails = objResponse.errors as? String {
                        DispatchQueue.main.async {
                            if errorDetails.count != 0 {
                                self.showAlert(message:errorDetails)
                            }
                        }
                    }
                    else {
                        var errorMsg = objResponse.errorMsg
                        if errorMsg.count == 0 {
                            errorMsg = SJLocalisedString["key_Server_busy"]
                        }
                        DispatchQueue.main.async {
                            self.showAlert(message:errorMsg)
                        }
                    }
                }
            }
            self.hideLoader()
        }
    }
}
//MARK: - Extensions - VideoDownloadTableViewCellDelegate
extension VideoDownloadViewController: VideoDownloadTableViewCellDelegate {
    func didTapDownload(cellModel: VideoDownloadTableViewCellModel, index: Int) {
        selectedIndex = index
        if !download_urls.contains(cellModel.getVideo()){
            download_urls.append(cellModel.getVideo())
        }
        let videoName = cellModel.getFileName()
        let videoUrl = cellModel.getVideo()
        if videoIsDownloaded(videoName: videoName) {
            DispatchQueue.main.async {
                self.showAlert(message: "Video is already downloaded")
            }
        } else {
            downloadVideoAndSaveToFile(videoURL: videoUrl, videoName: videoName)
        }
    }
    
    func didTapDelete(cellModel: VideoDownloadTableViewCellModel, index: Int) {
        selectedIndex = index
        deleteVideoFile(cellModel: cellModel, index: index)
    }
}

//MARK: - Extensions - UrlSessionDownloadDelegateMethods
extension VideoDownloadViewController: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        if let statusCode = (downloadTask.response as? HTTPURLResponse)?.statusCode {
            print("Successfully downloaded:",statusCode)
        }
        let documentsUrl: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        for url in download_urls{
            guard let index = cellModel.firstIndex(where: {$0.sampleVideos?.video == url}) else {return}
            guard let fileName = cellModel[index].sampleVideos?.Filename else {return}
            let destinationFileUrl = documentsUrl.appendingPathComponent("\(String(describing: fileName)).mp4")
            
            do {
                try FileManager.default.moveItem(at: location, to: destinationFileUrl)
            } catch {
                print("Error")
            }
            self.downloadTask = nil
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        if let index = cellModel.firstIndex(where: { $0.sampleVideos?.video == downloadTask.originalRequest?.url?.absoluteString }) {
            cellModel[index].downloadProgress = progress
            DispatchQueue.main.async {
                let indexPath = IndexPath(row: index, section: 0)
                self.tableView.reloadRows(at: [indexPath], with: .none)
            }
        }
    }
}
