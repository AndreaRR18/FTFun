import UIKit

class CoverTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var thumbnail: UIImageView?
    @IBOutlet weak private var name: UILabel?
    @IBOutlet weak private var ratingProgressView: UIProgressView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnail?.layer.cornerRadius = 30
    }
    
    func configureCoverTableViewCell(_ cover: Cover?, _ title: String, _ rating: Int?) {
        thumbnail?.af_setImage(
            withURL: getCoverMed(url: cover?.url)!,
            placeholderImage: #imageLiteral(resourceName: "img-not-found"),
            filter: nil,
            progress: nil,
            progressQueue: DispatchQueue.main,
            imageTransition: .crossDissolve(0.1),
            runImageTransitionIfCached: true,
            completion: { _ in
                self.thumbnail?.layer.shadowColor = UIColor.black.cgColor
                self.thumbnail?.layer.shadowOpacity = 3
                self.thumbnail?.layer.shadowOffset = CGSize.zero
                self.thumbnail?.layer.shadowRadius = 4
        })
        name?.text = title
        ratingProgressView?.progress = Float(rating ?? 1) / Float(100)
        self.layer.zPosition = 3
    }
}
