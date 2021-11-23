import Foundation

class SingleCalculator: Operation
{
    var avg : Average
    
    init(average: Average)
    {
        self.avg = average
    }
    
    override func main()
    {
        
        let total = 500_000
        var sum = 0
        for _ in 0...total{
            sum += Int.random(in: 1...6)
        }
        avg.value = "\(Float (sum) / Float (total))"
        avg.state = .found
        
        
    }
}
