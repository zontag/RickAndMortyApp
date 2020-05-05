import Foundation
import UIKit

protocol Injectable {
    var resolver: Environment { get }
}

extension Injectable {
    
    var resolver: Environment { appEnvironment }
}
