import UIKit

class MainTableViewController: UITableViewController
{
    var values : [Average] = []
    
    let operations = PendingCalculations ()
    
    
    func setPlaceHolders()
    {
        for _ in 0..<1000{
            let average = Average()
            values.append(average)
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad()
    {
        setPlaceHolders()
    }
    
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


extension MainTableViewController
{
    func startOperation(val : Average, indexPath: IndexPath)
    {
        if val.state != .new {return}
        
        guard operations.calculations[indexPath] == nil else {return}
        
        let thisCal = SingleCalculator(average: val)
        
        thisCal.completionBlock = {
            if thisCal.isCancelled {return}
            
            DispatchQueue.main.async {
                val.state = .found
                self.operations.calculations.removeValue(forKey: indexPath)
                self.tableView.reloadRows(at: [indexPath], with: .fade)
            }
            
        }
        
        operations.calculations[indexPath] = thisCal
        operations.queue.addOperation(thisCal)
        
        
    }
}
