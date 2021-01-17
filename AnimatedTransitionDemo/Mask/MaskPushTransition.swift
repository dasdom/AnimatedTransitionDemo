//  Created by dasdom on 16.01.21.
//  
//

import UIKit

class MaskPushTransition: NSObject, UIViewControllerAnimatedTransitioning {
  
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
    
    let bounds = containerView.bounds
    containerView.addSubview(toView)
    toView.frame = bounds
    
    let maskView = UIView(frame: CGRect(x: 0, y: 0, width: 2, height: 2))
    maskView.center = containerView.center
    maskView.layer.cornerRadius = 1
    maskView.backgroundColor = .white
    toView.mask = maskView
    
    let toWidth = bounds.height * 1.3
    UIViewPropertyAnimator.runningPropertyAnimator(withDuration: duration, delay: 0, options: .curveEaseIn) {
      maskView.frame = CGRect(x: 0, y: 0, width: toWidth, height: toWidth)
      maskView.center = containerView.center
      maskView.layer.cornerRadius = toWidth/2
    } completion: { position in
      
      toView.mask = nil
      
      let finished = !transitionContext.transitionWasCancelled
      transitionContext.completeTransition(finished)
    }
  }
}
