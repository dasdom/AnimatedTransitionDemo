//  Created by dasdom on 15.01.21.
//  
//

import UIKit

class ImageLabelView: UIView {
  let imageView: UIImageView
  let label: UILabel
  
  override init(frame: CGRect) {
    imageView = UIImageView()
    
    label = UILabel()
    label.textAlignment = .center
    
    super.init(frame: frame)
    
    backgroundColor = .randomColor()
    
    let stackView = UIStackView(arrangedSubviews: [imageView, label])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.spacing = 20
    
    addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
      stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
      stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
      
      imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 16/9)
    ])
  }
  
  required init?(coder: NSCoder) { fatalError() }
}
