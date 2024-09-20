import UIKit

class SlideShowViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var slideshowSwitch: UISwitch!
    @IBOutlet weak var switchLabel: UILabel!
    
    // Array of images for the slideshow
    var flowerImages = [FlowerModel]()
    
    // Current image index
    var currentIndex = 0
    
    // Timer for the slideshow
    var slideshowTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        flowerImages = FlowerImageModel.instance.getFlowers()
        
        // Set Initial Image
        imageView.image = flowerImages[currentIndex].image
        
        // Add Event To Switch Control
        slideshowSwitch.addTarget(self, action: #selector(toggleSlideshow), for: .valueChanged)
        
        // Start the slideshow
        startSlideshow()
    }
    
    // Start Slide Show
    func startSlideshow() {
        slideshowTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(showNextImage), userInfo: nil, repeats: true)
        switchLabel.text = "Stop Show"
    }
    
    // Stop Slide Show
    func stopSlideshow() {
        slideshowTimer?.invalidate()
        slideshowTimer = nil
        switchLabel.text = "Start Show"
    }
    
    // Show Next Image On Timer Fire
    @objc func showNextImage() {
        // Increment the index
        currentIndex += 1
        
        // Loop If At End Of Image List
        if currentIndex >= flowerImages.count {
            currentIndex = 0
        }
        
        // Update Image
        imageView.image = flowerImages[currentIndex].image
        
        // Add Basic Transition
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.fade
        imageView.layer.add(transition, forKey: nil)
    }
    
    // Turn Slide Show On And Off
    @objc func toggleSlideshow(_ sender: UISwitch) {
          if sender.isOn {
              startSlideshow()
          } else {
              stopSlideshow()
          }
      }
    
    // Disable Timer When View Leaves Focus. If You Do Not Do This Weird Things Happen
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        stopSlideshow()
    }
}
