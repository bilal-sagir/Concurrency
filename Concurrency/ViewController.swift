import UIKit

class ViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        AppData.shared.getCities()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(notified(_:)),
                                               name: contentNotification.added,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(notified(_:)),
                                               name: contentNotification.found,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(notified(_:)),
                                               name: contentNotification.remov,
                                               object: nil)
    }

    @objc func notified (_ notification: Notification){
        if notification.name == contentNotification.remov{
            
        }
        if notification.name == contentNotification.added{
            
        }
        if notification.name == contentNotification.found{
            
        }
    }

}

