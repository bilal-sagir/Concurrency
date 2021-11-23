import Foundation

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
