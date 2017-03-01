import UIKit

protocol ScreenshotDelegate: class {
    func openImage(url: String)
}
class ScreenshotCollectionTableViewCell: UITableViewCell {

    @IBOutlet weak var screenshotCollectionview: UICollectionView?
    weak var delegate: ScreenshotDelegate?

    var screenshot: [Screenshot] = [] {
        didSet {
            self.screenshotCollectionview?.register(UINib(nibName: NibName.screenshotTableCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Identifier.screenshotTableCollectionViewCell)
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 145, height: 145)
            layout.sectionInset = UIEdgeInsetsMake(5, 20, 15, 20)
            layout.minimumInteritemSpacing = 10
            layout.scrollDirection = .horizontal
            screenshotCollectionview?.setCollectionViewLayout(layout, animated: true)
            screenshotCollectionview?.delegate = self
            screenshotCollectionview?.dataSource = self
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension ScreenshotCollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return screenshot.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.screenshotTableCollectionViewCell, for: indexPath) as! ScreenshotTableCollectionViewCell
        cell.url = getCoverMed(url: screenshot[indexPath.row].url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let url = screenshot[indexPath.row].url else  { return }
        self.delegate?.openImage(url: url)
    }
}