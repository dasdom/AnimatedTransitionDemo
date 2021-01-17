//  Created by dasdom on 15.01.21.
//  
//

import UIKit

class NavigationControllerDelegate: NSObject, UINavigationControllerDelegate {
  
  var interactiveTransition: UIPercentDrivenInteractiveTransition?
  
  func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    
    let transition: UIViewControllerAnimatedTransitioning?
    
    switch (fromVC, toVC) {
      case (_, is FromBottomViewController):
        transition = FromBottomPushTransition()
      case (is FromBottomViewController, _):
        transition = ToBottomPopTransition()
      case (_, is MoveElementsViewController):
        let moveElementsTransition = MoveElementsTransition()
        moveElementsTransition.operation = .push
        transition = moveElementsTransition
      case (is MoveElementsViewController, _):
        let moveElementsTransition = MoveElementsTransition()
        moveElementsTransition.operation = .pop
        transition = moveElementsTransition
      case (_, is MaskViewController):
        transition = MaskPushTransition()
      case (is MaskViewController, _):
        transition = MaskPopTransition()
      case (_, is FoldViewController):
        transition = FoldTransition()
      case (_, is TileViewController):
        transition = TileTransition()
      default:
        transition = nil
    }
    
    return transition
  }
  
  func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    return interactiveTransition
  }
}
