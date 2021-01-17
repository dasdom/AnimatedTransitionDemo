//  Created by dasdom on 15.01.21.
//  
//

import UIKit

class TransitionsViewController: UITableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
  }
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Transition.allCases.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let transition = Transition(rawValue: indexPath.row) else {
      return UITableViewCell()
    }

    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
    cell.imageView?.image = transition.image
    cell.textLabel?.text = transition.name
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    guard let transition = Transition(rawValue: indexPath.row) else {
      return
    }
      
    let next = transition.nextViewController
    navigationController?.pushViewController(next, animated: true)
  }
}

extension TransitionsViewController: TransitionInfoProtocol {
  func viewsToAnimate() -> [UIView] {
    let cell: UITableViewCell
    if let indexPath = tableView.indexPathForSelectedRow {
      cell = tableView.cellForRow(at: indexPath)!
//    } else {
//      cell = tableView.cellForRow(at: lastSelectedIndexPath!)
    } else {
      return []
    }
    
    guard let imageView = cell.imageView, let label = cell.textLabel else {
      return []
    }
    return [imageView, label]
  }
  
  func copyForView(_ subView: UIView) -> UIView {
    let cell = tableView.cellForRow(at: tableView.indexPathForSelectedRow!)!
    if subView is UIImageView {
      return UIImageView(image: cell.imageView?.image)
    } else {
      let label = UILabel()
      label.text = cell.textLabel?.text
      return label
    }
  }
}

extension TransitionsViewController {
  enum Transition: Int, CaseIterable {
    case `default`
    case fromBottom
    case moveElements
    case mask
    case tile
    case fold
    
    var name: String {
      let name: String
      switch self {
        case .default: name = "Default"
        case .fromBottom: name = "From bottom"
        case .moveElements: name = "Move elements"
        case .mask: name = "Mask"
        case .tile: name = "Tile"
        case .fold: name = "Fold"
      }
      return name
    }
    
    var image: UIImage? {
      let imageName: String
      switch self {
        case .default: imageName = "default"
        case .fromBottom: imageName = "fromBottom"
        case .moveElements: imageName = "moveElements"
        case .mask: imageName = "mask"
        case .tile: imageName = "tile"
        case .fold: imageName = "fold"
      }
      return UIImage(named: imageName)
    }
    
    var nextViewController: UIViewController {
      let next: UIViewController
      switch self {
        case .default: next = RandomColorViewController()
        case .fromBottom: next = FromBottomViewController()
        case .moveElements: next = MoveElementsViewController(name: self.name, image: self.image)
        case .mask: next = MaskViewController(image: self.image)
        case .tile: next = TileViewController(name: self.name, image: self.image)
        case .fold: next = FoldViewController(name: self.name, image: self.image)
      }
      return next
    }
  }
}
