import Foundation

struct contentNotification{
    static let added = Notification.Name("com.bilal-sagir.gcdsingleton.addded")
    static let found = Notification.Name("com.bilal-sagir.gcdsingleton.found")
    static let remov = Notification.Name("com.bilal-sagir.gcdsingleton.remov")
}

class AppData
{
    private init () {} //didnt get it????
    
    static let shared = AppData ()
    
    var cities : Array<String> = []
    
    private let myQueue = DispatchQueue(label: "com.institute.gcdsingleton",
                                        qos: DispatchQoS.background,
                                        attributes: [.concurrent],
                                        autoreleaseFrequency: .inherit,
                                        target: nil)
    
    func add (_ city: String )
    {
        myQueue.async(group: nil,
                      qos: DispatchQoS.background,
                      flags: DispatchWorkItemFlags.barrier)
        {
            for _ in 0..<10_000_000
            {
                self.cities.append(city)
                
            }
            
            NotificationCenter.default.post(name: contentNotification.added, object: nil)
        }
    }
    
    func getCities() -> Array<String>
    {
        var mCities : [String]!
        myQueue.sync {
            mCities = cities.sorted()
        }
        NotificationCenter.default.post(name: contentNotification.found, object: nil)
        return mCities
    }
    
    func remove (_ city: String )
    {
        myQueue.async(group: nil, qos: .background, flags: .barrier)
        {
            if let index = self.cities.firstIndex(of: city)
            {
                self.cities.remove(at: index)
                
                NotificationCenter.default.post(name: contentNotification.remov, object: nil)
            }
        }
        
    }
}
