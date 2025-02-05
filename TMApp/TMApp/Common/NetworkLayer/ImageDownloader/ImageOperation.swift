import UIKit

final class ImageOperation: Operation {
    
    var imageDownloadCompletionHandler: ((Result<UIImage, NetworkError>) -> Void)?
    
    public let imageURL: URL
    private let network: NetworkService
    private var downloadTask: URLSessionDownloadTask?
    private let size: CGSize
    private let scale: CGFloat

    init(imageURL: URL, size: CGSize, scale: CGFloat, network: NetworkService) {
        self.imageURL = imageURL
        self.size = size
        self.scale = scale
        self.network = network
    }
    
    private enum OperationState: String, Equatable {
        case ready = "isReady"
        case executing = "isExecuting"
        case finished = "isFinished"
    }
    
    private var _state = OperationState.ready {
        willSet {
            willChangeValue(forKey: newValue.rawValue)
            willChangeValue(forKey: _state.rawValue)
        }
        didSet {
            didChangeValue(forKey: oldValue.rawValue)
            didChangeValue(forKey: _state.rawValue)
        }
    }
    
    private var state: OperationState {
        get {
            return _state
        }
        set {
            _state = newValue
        }
    }
    
    // MARK: - Various `Operation` properties
    
    override var isReady: Bool {
        return state == .ready && super.isReady
    }
    
    override var isExecuting: Bool {
        return state == .executing
    }
    
    override var isFinished: Bool {
        return state == .finished
    }
    
    
    // MARK: - Start
    
    override func start() {
        if isCancelled {
            finish()
            return
        }

        if !isExecuting {
            state = .executing
        }

        main()
    }
    
    // MARK: - Finish
    
    func finish() {
        if isExecuting {
            state = .finished
        }
    }
    
    // MARK: - Cancel
    
    override func cancel() {
        downloadTask?.cancel()
        finish()
        super.cancel()
    }
    
    //MARK: - Main
    override func main() {
        downloadImage()
    }
    
    private func downloadImage() {
        downloadTask = network.downloadRequest(imageURL, size: size, scale: UIScreen.main.scale, completion: { [weak self] (result: Result<UIImage, NetworkError>) in
            self?.imageDownloadCompletionHandler?(result)
            self?.finish()
        })
    }
}
