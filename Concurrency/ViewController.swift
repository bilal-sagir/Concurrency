import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var myImg : UIImageView!
    
    @IBAction func loadImg()
    {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.isSuspended = false
        
        let url = URL(string: "https://apod.nasa.gov/apod/image/1507/sombrero_hubble_11472.jpg")
        
        queue.qualityOfService = .background
        queue.addOperation
        {
            do{
                let data = try Data(contentsOf: url!)
                DispatchQueue.main.sync
                {
                    self.myImg.image = UIImage(data: data)
                }
            }catch{print(error.localizedDescription)}
        }
    }
}

