import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var myLabel : UILabel!
    @IBOutlet weak var icon : UIActivityIndicatorView!
    
    
    @IBAction func buttonFunc()
    {
        myLabel.text = "Dice Avg calculating..."
        icon.startAnimating()
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async
        {//set qos to BACKGROUND!!
            let new = self.LongProcess()
            DispatchQueue.main.async
            {
                self.icon.stopAnimating()
                self.myLabel.text = new
            }
        }
    }
    
    
    func LongProcess() -> String // Simple Dice Func to take a while
    {
        var sum = 0
        let n = 10_000_000
        for _ in 0..<n
        {
            let dice = Int.random(in: 1...6)
            sum += dice
        }
        
        let avg = Float(sum) / Float(n)
        let FormattedAvg =  String(format: "%.3f", avg)
        return FormattedAvg
    }


}

