//
//  DetailPhotoViewModel.swift
//  MVVM
//
//  Created by belga on 20/1/17.
//  Copyright © 2017 GFI. All rights reserved.
//

import Foundation

class DetailPhotoViewModel : DetailPhotoViewModelType {
  weak var viewDelegate: DetailPhotoViewModelDelegateType?
  weak var coordinatorDelegate: DetailPhotoViewModelCoordinatorDelegate?
  var item:PhotoViewModelType?
  
  
  
  fileprivate(set) var data: PhotoType? {
    didSet {
      viewDelegate?.detailDidLoad(viewModel: self)
    }
  }
  
  var title: String {
    return data?.title ?? String()
  }
  
  var date: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    if let date = data?.date {
      return dateFormatter.string(from: date)
    }
    return String()
  }

  var url: URL? {
    if let str = data?.url {
      return URL(string: str)
    }
    return nil
  }

  
  var model: PhotoModelType? {
    didSet {
      if let id = self.item?.id {
        model?.getPhoto(id: id,
                        success: { (result) in
                          self.data = result
        }, fail: { (error) in
          self.viewDelegate?.detailErrorReceived(error: error)
        })
      }
    }
      
  }
  
  init(item:PhotoViewModelType) {
    self.item = item
  }
  
  
  func didFinish() {
    self.coordinatorDelegate?.detailPhotoViewModelDidFinish(self)
  }
  
}
