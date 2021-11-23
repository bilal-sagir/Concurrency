import Foundation

class PendingCalculations
{
    var calculations : [IndexPath: Operation] = [:]
    
    
    
    
    
    var queue : OperationQueue =
    {
        var q  = OperationQueue ()
        q.name = "calculation queue"
        q.maxConcurrentOperationCount = 1
        return q
    }()
        
    
}
