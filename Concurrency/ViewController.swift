import UIKit

struct MyNotification
{
    static let dowloadEnded = Notification.Name("com.bilal-sagir.app.kvo")
}


class AppData
{
    class func notify ()
    
    {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).asyncAfter(deadline: .now() + 3.0)
        {
            NotificationCenter.default.post(name: MyNotification.dowloadEnded,
                                            object: nil)
        }
    }
}




class ViewController: UIViewController
{

    @IBOutlet weak var Lbl : UILabel!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(gotNotified(_:)),
                                               name: MyNotification.dowloadEnded,
                                               object: nil)
    }
    
    @objc func gotNotified (_ note: Notification)
    {
        DispatchQueue.main.async {
            self.Lbl.text = "download ENDED"
        }
    }
    
    @IBAction func dowload()
    {
        self.Lbl.text = "Downloading...."
        AppData.notify()
    }
    
}

