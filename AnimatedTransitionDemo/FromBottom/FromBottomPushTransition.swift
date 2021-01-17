//  Created by dasdom on 15.01.21.
//  
//

import UIKit

class FromBottomPushTransition: NSObject, UIViewControllerAnimatedTransitioning {
  
  private let duration: TimeInterval = 0.5
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
    guard let toView = transitionContext.view(forKey: .to) else {
      transitionContext.completeTransition(false)
      return
    }
    
    let containerView = transitionContext.containerView
    
    containerView.addSubview(toView)
    
    let bounds = containerView.bounds
    toView.frame = bounds.offsetBy(dx: 0, dy: bounds.height)
    
    UIViewPropertyAnimator.runningPropertyAnimator(withDuration: duration, delay: 0, options: .curveEaseInOut) {
      toView.frame = bounds
    } completion: { position in
      let finished = !transitionContext.transitionWasCancelled
      transitionContext.completeTransition(finished)
    }

  }
}
