import UIKit

extension MainTableViewController
{
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int
    {
        return values.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId")!
        
        let thisValue = values[indexPath.row]
        
        if thisValue.state == .new{
            cell.backgroundColor = .white
            cell.textLabel?.text = "Calculating....."
            
            if !tableView.isDragging && !tableView.isDecelerating
            {
                startOperation(val: thisValue, indexPath: indexPath)
            }
        }
        else
        {
            cell.backgroundColor = .systemGreen
            cell.textLabel?.text = thisValue.value
        }
        
        return cell
    }
    
}
