//  Created by dasdom on 16.01.21.
//  
//

import UIKit

class MoveElementsViewController: ImageLabelViewController {

  var startX = CGFloat(0)
  var navigationControllerDelegate: NavigationControllerDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let gestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(pan(_:)))
    gestureRecognizer.edges = .left
    view.addGestureRecognizer(gestureRecognizer)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    navigationControllerDelegate = navigationController?.delegate as? NavigationControllerDelegate
  }
}

extension MoveElementsViewController {
  @objc func pan(_ sender: UIScreenEdgePanGestureRecognizer) {
    
    let translation = sender.translation(in: view)
    
    let percent = min(1, max(0, (translation.x - startX)/200))
    
    switch sender.state {
      case .began:
        startX = translation.x
        navigationControllerDelegate?.interactiveTransition = UIPercentDrivenInteractiveTransition()
        navigationController?.popViewController(animated: true)
      case .changed:
        navigationControllerDelegate?.interactiveTransition?.update(percent)
      case .ended:
        fallthrough
      case .cancelled:
        if sender.velocity(in: sender.view).x < 0 && percent < 0.5 {
          navigationControllerDelegate?.interactiveTransition?.cancel()
        } else {
          navigationControllerDelegate?.interactiveTransition?.finish()
        }
        navigationControllerDelegate?.interactiveTransition = nil
      default:
        break
    }
    
  }
}
