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
}

extension MainTableViewController
{
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView)
    {
        operations.queue.isSuspended = true
    }
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    {
        if !decelerate
        {
            loadAllCells()
        }
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        loadAllCells()
    }
    
    func loadAllCells()
    {
        operations.queue.isSuspended = false
        guard let visibleIndexPaths = tableView.indexPathsForVisibleRows else {return}
        
        let visible = Set(visibleIndexPaths)
        
        let pendingOperations = Set(operations.calculations.keys)
        
        var cancelThem = pendingOperations
        cancelThem.subtract(visible)
        
        var startThem = visible
        startThem.subtract(pendingOperations)
        
        for indexPath in cancelThem{
            if let pending = operations.calculations[indexPath]{
                pending.cancel()
            }
            operations.calculations.removeValue(forKey: indexPath)
        }
        for indexPath in startThem{
            let curCalc = values[indexPath.row]
            startOperation(val: curCalc, indexPath: indexPath)
        }
    }
}
