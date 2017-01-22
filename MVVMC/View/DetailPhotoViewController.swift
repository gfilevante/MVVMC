//
//  DetailPhotoViewController.swift
//  MoyaTest
//
//  Created by belga on 15/1/17.
//  Copyright © 2017 GFI. All rights reserved.
//

import UIKit

class DetailPhotoViewController: UIViewController {
  var id : Int = 0
  var viewModel: DetailPhotoViewModelType? {
    willSet {
      viewModel?.viewDelegate = nil
    }
    didSet {
      viewModel?.viewDelegate = self
    }
  }
  
  
  
  @IBOutlet var photoTitle: UILabel!
  @IBOutlet var photoDate: UILabel!
  @IBOutlet var photoImageView: UIImageView!
  
  
  
  
    override func viewDidLoad() {
      super.viewDidLoad()
//      viewModel = DetailPhotoViewModel(item: id)
//      viewModel?.model = PhotoModel()
    }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    viewModel?.didFinish()
  }

}

extension DetailPhotoViewController : DetailPhotoViewModelDelegateType {
  func detailDidLoad(viewModel: DetailPhotoViewModelType) {
      photoTitle.text = viewModel.title
      photoDate.text = viewModel.date
      if let url =  viewModel.url {
        photoImageView.af_setImage(withURL:url)
      }
      self.view.layoutIfNeeded()
    
  }
  
  func detailErrorReceived( error: Swift.Error) {
    let alertVC = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
    self.present(alertVC, animated: true, completion: nil)
  }
}
