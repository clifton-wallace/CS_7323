import UIKit

class FlowerTypeListViewController: UITableViewController  {
    
    // Model Shared Instance
    lazy private var flowerImageModel = {
        return FlowerImageModel.instance
    }()
    
    
    // Get List Of Flower Types And Add All
    lazy private var flowerTypes = {
        return flowerImageModel.getFlowerTypes()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Table Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.flowerTypes.count + 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < self.flowerTypes.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FlowerTypeCell", for: indexPath)
            if let flower = self.flowerTypes[indexPath.row] as String? {
                cell.textLabel!.text = "View \(flower)"
                cell.tag = 1
            }
            return cell
        }
        else if indexPath.row == (self.flowerTypes.count) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AllTypesCell", for: indexPath)
            cell.textLabel!.text = "View All Flowers"
            cell.tag = 0
            return cell
        }
        else if indexPath.row == (self.flowerTypes.count + 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RandomFlowerCell", for: indexPath)
            cell.textLabel!.text = "View Random Flower"
            cell.tag = -1
            return cell
        }
        
        return UITableViewCell()
    }
    
    //Seque Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //if the segue is to our ViewController, this is random image
        if let vc = segue.destination as? ViewController,
           let cell = sender as? UITableViewCell {
            if let flower = flowerImageModel.getRandomFlower() {
                vc.displayImageName = flower.name
            }
            else {
                fatalError("Failed To Randomly Select A Flower")
            }
        }
        else if let vc = segue.destination as? GalleryViewController,
                let cell = sender as? UITableViewCell,
                let name = cell.textLabel?.text {
            if (cell.tag == 1) {
                let flower = String(name.dropFirst("View ".count))
                vc.filter = flower
            }
            else {
                vc.filter = "All"
            }
        }
    }
}
