import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var myLabel : UILabel!
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        DelayFunc()
    }

 
    
    func DelayFunc()
    {
        let pausedTime = 5.0
        DispatchQueue.main.asyncAfter(deadline: .now() + pausedTime)
        {
            [weak self] in
            guard let self = self else {return}
            
            
            self.myLabel.text = "It s happening after 5 sec"
        }
    }

}

