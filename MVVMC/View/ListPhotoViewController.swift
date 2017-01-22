//
//  ListPhotoViewController.swift
//  MoyaTest
//
//  Created by belga on 10/1/17.
//  Copyright © 2017 GFI. All rights reserved.
//

import UIKit
import Moya

class ListPhotoViewController: UIViewController {
  
		
  @IBOutlet var tableView: UITableView!

  var viewModel: ListPhotoViewModelType? {
    willSet {
      viewModel?.viewDelegate = nil
    }
    didSet {
      viewModel?.viewDelegate = self
      //refreshDisplay()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
//    refreshDisplay()
  }
  
  func refreshDisplay() {
     tableView?.reloadData()
  }

}

extension ListPhotoViewController : ListPhotoViewModelTypeDelegate {
  func showError(error: Swift.Error) {
    let alertVC = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
    self.present(alertVC, animated: true, completion: nil)
  }
  
  func itemsDidChange(viewModel: ListPhotoViewModelType) {
    refreshDisplay()
  }
}


extension ListPhotoViewController : UITableViewDataSource {
  
  
  func numberOfSections(in tableView: UITableView) -> Int
  {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    if let viewModel = viewModel {
      return viewModel.numberOfItems
    }
    
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! TableViewCell
    cell.viewModel = viewModel?.itemAtIndex(indexPath.row)
    return cell
  }
  
}

extension ListPhotoViewController : UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      viewModel?.useItemAtIndex(indexPath.row)
  }
}

