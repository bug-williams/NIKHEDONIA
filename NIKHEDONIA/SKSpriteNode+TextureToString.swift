import Foundation
import SpriteKit



extension SKTexture {
    
    
    var name : String
    {
        return self.description.slice(start: "'",to: "'")!
    }
    
    
}




extension String {
    
    
    func slice(start: String, to: String) -> String? {
        
        return (range(of: start)?.upperBound).flatMap
            {
                sInd in
                (range(of: to, range: sInd..<endIndex)?.lowerBound).map
                    {
                        eInd in
                        substring(with:sInd..<eInd)
                        
                }
        }
    }
    
    
}
