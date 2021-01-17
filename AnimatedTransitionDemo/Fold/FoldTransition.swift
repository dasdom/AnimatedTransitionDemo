//  Created by dasdom on 16.01.21.
//  
//

import UIKit

class FoldTransition: NSObject, UIViewControllerAnimatedTransitioning {
  
  private let duration: TimeInterval = 1.5
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    guard let fromView = transitionContext.view(forKey: .from),
          let toView = transitionContext.view(forKey: .to) else {
      transitionContext.completeTransition(false)
      return
    }
    
    let containerView = transitionContext.containerView
    
    let bounds = containerView.bounds
    containerView.addSubview(toView)
    toView.frame = bounds
    
    let width = fromView.frame.width/2
    let height = (fromView.frame.height - fromView.safeAreaInsets.top)/2
    let topLeftFrame = CGRect(x: 0, y: 0, width: width, height: height)
    let topRightFrame = CGRect(x: width, y: 0, width: width, height: height)
    let bottomLeftFrame = CGRect(x: 0, y: height, width: width, height: height)
    let bottomRightFrame = CGRect(x: width, y: height, width: width, height: height)

    guard let topLeftView = fromView.resizableSnapshotView(from: topLeftFrame, afterScreenUpdates: false, withCapInsets: .zero),
    let topRightView = fromView.resizableSnapshotView(from: topRightFrame, afterScreenUpdates: false, withCapInsets: .zero),
    let bottomLeftView = fromView.resizableSnapshotView(from: bottomLeftFrame, afterScreenUpdates: false, withCapInsets: .zero),
    let bottomRightView = fromView.resizableSnapshotView(from: bottomRightFrame, afterScreenUpdates: false, withCapInsets: .zero) else {
      transitionContext.completeTransition(false)
      return
    }

    topLeftView.frame = topLeftFrame.offsetBy(dx: 0, dy: fromView.safeAreaInsets.top)
    topRightView.frame = topRightFrame.offsetBy(dx: 0, dy: fromView.safeAreaInsets.top)
    bottomLeftView.frame = bottomLeftFrame.offsetBy(dx: 0, dy: fromView.safeAreaInsets.top)
    bottomRightView.frame = bottomRightFrame.offsetBy(dx: 0, dy: fromView.safeAreaInsets.top)

    containerView.addSubview(bottomRightView)
    containerView.addSubview(bottomLeftView)
    containerView.addSubview(topRightView)
    containerView.addSubview(topLeftView)

    let layer = topLeftView.layer
    layer.anchorPoint = CGPoint(x: 1, y: 0.5)
    var transform = CATransform3DIdentity
    transform = CATransform3DTranslate(transform, width/2, 0, 0)
    layer.transform = transform

    let animator0 = UIViewPropertyAnimator(duration: duration/4, curve: .easeOut) {
//      topLeftView.frame.origin.x = width
      var transform = CATransform3DIdentity
      transform = CATransform3DTranslate(transform, width/2, 0, 0)
      transform.m34 = 1.0 / -500
      transform = CATransform3DRotate(transform, 179.0 * .pi / 180.0, 0, 1, 0)
      layer.transform = transform
    }
    
    let animator1 = UIViewPropertyAnimator(duration: duration/4, curve: .easeOut) {
//      topLeftView.frame.origin.y = height + fromView.safeAreaInsets.top
      var transform = CATransform3DIdentity
      transform = CATransform3DTranslate(transform, width, height/2, 0)
      transform = CATransform3DScale(transform, -1, 1, 1)
      transform.m34 = 1.0 / -500
      transform = CATransform3DRotate(transform, -179.0 * .pi / 180.0, 1, 0, 0)
      layer.transform = transform
    }
    
    animator0.addCompletion { position in
      topRightView.removeFromSuperview()

      layer.anchorPoint = CGPoint(x: 0.5, y: 1)
      var transform = CATransform3DIdentity
      transform = CATransform3DTranslate(transform, width, height/2, 0)
      transform = CATransform3DScale(transform, -1, 1, 1)
//      transform = CATransform3DRotate(transform, 179.0 * .pi / 180.0, 0, 1, 0)
      layer.transform = transform
      
      animator1.startAnimation()
    }
    
    let animator2 = UIViewPropertyAnimator(duration: duration/4, curve: .easeOut) {
//      topLeftView.frame.origin.x = 0
      
      var transform = CATransform3DIdentity
      transform = CATransform3DTranslate(transform, width/2, height, 0)
      transform = CATransform3DScale(transform, -1, -1, 1)
      transform.m34 = 1.0 / -500
      transform = CATransform3DRotate(transform, 179.0 * .pi / 180.0, 0, 1, 0)
      layer.transform = transform
    }
    
    animator1.addCompletion { position in
      bottomRightView.removeFromSuperview()
      
      layer.anchorPoint = CGPoint(x: 1.0, y: 0.5)
      var transform = CATransform3DIdentity
      transform = CATransform3DTranslate(transform, width/2, height, 0)
      transform = CATransform3DScale(transform, -1, -1, 1)
      layer.transform = transform

      animator2.startAnimation()
    }
    
    let animator3 = UIViewPropertyAnimator(duration: duration/4, curve: .easeOut) {
      topLeftView.alpha = 0
      bottomLeftView.alpha = 0
    }
    
    animator2.addCompletion { position in
      bottomRightView.removeFromSuperview()
      animator3.startAnimation()
    }
    
    animator3.addCompletion { position in
      topLeftView.removeFromSuperview()
      topRightView.removeFromSuperview()
      bottomLeftView.removeFromSuperview()
      bottomRightView.removeFromSuperview()
      
      let finished = !transitionContext.transitionWasCancelled
      transitionContext.completeTransition(finished)
    }

    animator0.startAnimation()
  }
}
