import UIKit

class VideoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var videoThumbnail: UIImageView?
    @IBOutlet weak var videoTitle: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static var cellVideoIdentifier: String { return "VideoCollectionViewCell" }


    var url: URL? {
        didSet{
            videoThumbnail?.af_setImage(
                withURL: url!,
                placeholderImage: #imageLiteral(resourceName: "img-not-found"),
                filter: nil,
                progress: nil,
                progressQueue: DispatchQueue.main,
                imageTransition: UIImageView.ImageTransition.crossDissolve(0.1),
                runImageTransitionIfCached: true,
                completion: { _ in
            })
        }
    }

    
}