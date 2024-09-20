import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Ensure the image fits within the UIImageView without clipping
        imageView.contentMode = .scaleAspectFit
    }
}
