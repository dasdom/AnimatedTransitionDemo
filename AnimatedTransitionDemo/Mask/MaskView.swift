//  Created by dasdom on 16.01.21.
//  
//

import UIKit

class MaskView: UIView {

  let imageView: UIImageView
  
  override init(frame: CGRect) {
    
    imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    super.init(frame: frame)
    
    addSubview(imageView)
    
    NSLayoutConstraint.activate([
      imageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
      imageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
      imageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
      
      imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 16/9)
    ])
  }
  
  required init?(coder: NSCoder) { fatalError() }
}
