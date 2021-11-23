import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var myLbl : UILabel!
    
    let pending = Pending()
    
    @IBAction func run()
    {
        if pending.progress != nil { return } //check for operation
        
        self.myLbl.text = "In Progress"
        
        let op = MyOperation()
                
        op.completionBlock = {
            if op.isCancelled{ return }
            
            let res = op.value
            DispatchQueue.main.async {
                self.myLbl.text = "\(res)"
            }
        }
        pending.queue.addOperation(op)
    }

}

class Pending
{
    var progress : Operation?
    
    var queue : OperationQueue = {
        var queue = OperationQueue()
        queue.name = "myQueue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
}


class MyOperation: Operation
{
    var value : Float = 0.0
    
    override func main()
    {
        let total = 10_000_000
        var sum = 0
        for _ in 0..<total{
            sum += Int.random(in: 1...6)
        }
        value = Float(sum) / Float(total)
    }
    
}
