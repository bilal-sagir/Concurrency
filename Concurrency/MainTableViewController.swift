import UIKit

class MainTableViewController: UITableViewController
{
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int
    {
        return 1000
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId")!
        
        cell.textLabel?.text = "\(longProcess())"
        return cell
    }
    
    
    
    
    
    
    
    

}

