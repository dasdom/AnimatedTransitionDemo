//  Created by dasdom on 17.01.21.
//  
//

import UIKit

class MaskPopTransition: NSObject, UIViewControllerAnimatedTransitioning {
  
  private let duration: TimeInterval = 0.5
  fileprivate var animator: UIViewPropertyAnimator?

  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let animator = interruptibleAnimator(using: transitionContext)
    animator.startAnimation()
  }
  
  func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
    
    if let animator = animator {
      return animator
    }
    
    guard let fromView = transitionContext.view(forKey: .from),
          let toView = transitionContext.view(forKey: .to) else {
      fatalError()
    }
    
    let containerView = transitionContext.containerView
    
    let bounds = containerView.bounds
    containerView.insertSubview(toView, at: 0)
    toView.frame = bounds
    
    let fromWidth = bounds.height * 1.3
    let maskView = UIView(frame: CGRect(x: 0, y: 0, width: fromWidth, height: fromWidth))
    maskView.center = containerView.center
    maskView.layer.cornerRadius = fromWidth/2
    maskView.backgroundColor = .white
    fromView.mask = maskView

    let animator = UIViewPropertyAnimator(duration: duration, curve: .easeIn) {
      maskView.frame = CGRect(x: 0, y: 0, width: 2, height: 2)
      maskView.center = containerView.center
      maskView.layer.cornerRadius = 1
    }
    
    animator.addCompletion { position in
      fromView.mask = nil
      
      let finished = !transitionContext.transitionWasCancelled
      transitionContext.completeTransition(finished)
    }
    
    self.animator = animator
    return animator
  }
}
