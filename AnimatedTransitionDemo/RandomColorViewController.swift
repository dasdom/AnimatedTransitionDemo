//  Created by dasdom on 15.01.21.
//  
//

import UIKit

class RandomColorViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .randomColor()
  }
}
