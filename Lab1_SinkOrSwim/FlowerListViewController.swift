import UIKit

class FlowerListViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    // Model Shared Instance
    lazy private var flowerImageModel = {
        return FlowerImageModel.instance
    }()
    
    // List Of Flowers
    private var filteredFlowers: [FlowerModel] = []
    
    // Get List Of Flower Types And Add All
    private var flowerTypes : [String]{
        return flowerImageModel.getflowerTypeFilter()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredFlowers = FlowerImageModel.instance.getFlowers() // Initially show all flowers
    }
    
    // Table Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFlowers.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PickerCell", for: indexPath) as? PickerTableViewCell {
                // Set the picker view delegate and data source
                cell.pickerView.delegate = self
                cell.pickerView.dataSource = self
                return cell
            } else {
                // Return an empty cell or handle the error
                return UITableViewCell()
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FlowerNameCell", for: indexPath)
            if let flower = filteredFlowers[indexPath.row - 1] as FlowerModel? {
                cell.textLabel!.text = flower.name
            }
            return cell
        }
    }
    
    //Seque Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        //if the segue is to our ViewController as destination
        if let vc = segue.destination as? ViewController,
           let cell = sender as? UITableViewCell,
           let name = cell.textLabel?.text {
            vc.displayImageName = name
        }
    }
        
    // Picker Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return flowerTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return flowerTypes[row]
    }
    
    // Filter List Based On Picker Selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCategory = flowerTypes[row]
        
        if selectedCategory == "All" {
            filteredFlowers = FlowerImageModel.instance.getFlowers()
        } else {
            filteredFlowers = FlowerImageModel.instance.getFlowers(forType:selectedCategory)
        }
        
        // Reload the table view to show filtered results
        tableView.reloadData()
    }
}
