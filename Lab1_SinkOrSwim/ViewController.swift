//Sink or Swim app
//Team member: Arman, Clifton, Jeevan


import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var zoomSlider: UISlider!
    
    // Name Of Image TO Display
    var displayImageName = ""
    
    // Model Shared Instance
    lazy private var flowerImageModel = {
        return FlowerImageModel.instance
    }()
    
    //instantiate "imageView" that return UIImageView
    lazy private var imageView: UIImageView? = {
        
        //display the image based on the name
        return UIImageView.init(image: self.flowerImageModel.getFlowerByName(name: displayImageName)?.image)
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
          
        //set the size of the scroll = size of the image
        if let size = self.imageView?.image?.size{
            self.scrollView.addSubview(self.imageView!)
            self.scrollView.contentSize = size
            self.scrollView.minimumZoomScale = 0.1
            self.scrollView.maximumZoomScale = 2.0
            self.scrollView.delegate = self
        }
        zoomSlider.minimumValue = 0.1
        zoomSlider.maximumValue = 2.0
        zoomSlider.value = 1.0
       
    }
    
    //function to enable zooom functionality
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    // Event To Change Scale
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let zoomScale = CGFloat(sender.value)
        scrollView.setZoomScale(zoomScale, animated: true)
    }


}

