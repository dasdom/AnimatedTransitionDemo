//  Created by dasdom on 15.01.21.
//  
//

import UIKit

class ImageLabelViewController: UIViewController {
  
  let name: String
  let image: UIImage?
  private var contentView: ImageLabelView {
    return view as! ImageLabelView
  }
  
  init(name: String, image: UIImage?) {
    
    self.name = name
    self.image = image
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) { fatalError() }
  
  override func loadView() {
    let contentView = ImageLabelView()
    contentView.label.text = name
    contentView.imageView.image = image
    view = contentView
  }
}

extension ImageLabelViewController: TransitionInfoProtocol {
  func viewsToAnimate() -> [UIView] {
    return [contentView.imageView, contentView.label]
  }
  
  func copyForView(_ subView: UIView) -> UIView {
    if subView == contentView.imageView {
      let imageViewCopy = UIImageView(image: contentView.imageView.image)
      imageViewCopy.contentMode = contentView.imageView.contentMode
      imageViewCopy.clipsToBounds = true
      return imageViewCopy
    } else if subView == contentView.label {
      let labelCopy = UILabel()
      labelCopy.text = contentView.label.text
      labelCopy.font = contentView.label.font
      labelCopy.backgroundColor = contentView.label.backgroundColor
      return labelCopy
    }
    return UIView()
  }
  
  
}
