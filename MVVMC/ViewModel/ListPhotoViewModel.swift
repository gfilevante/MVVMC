//
//  ListPhotosViewModel.swift
//  MVVM
//
//  Created by belga on 18/1/17.
//  Copyright © 2017 GFI. All rights reserved.
//

import Foundation

class ListPhotoViewModel : ListPhotoViewModelType {
  weak var viewDelegate: ListPhotoViewModelTypeDelegate?
  weak var coordinatorDelegate: ListPhotoViewModelCoordinatorDelegate?
  
  fileprivate var items: [PhotoViewModelType]? {
    didSet {
      viewDelegate?.itemsDidChange(viewModel: self)
    }
  }
  
  var model: PhotoModelType? {
    didSet {
      items = nil;
      model?.listPhotos({ (result) in
        self.items = result.map {  item in
          return PhotoViewModel(photo:item)
        }
      }, fail: { (error) in
        self.viewDelegate?.showError(error: error)
      })
    }
  }
  
  var numberOfItems: Int {
    return items?.count ?? 0
  }
  
  func itemAtIndex(_ index: Int) -> PhotoViewModelType?
  {
    if let items = items, items.count > index {
      return items[index]
    }
    return nil
  }
  
  
  func useItemAtIndex(_ index: Int)
  {
    if let items = items, let coordinatorDelegate = coordinatorDelegate, index < items.count {
      coordinatorDelegate.didSelectData(self, item: items[index])
    }
  }
  
}
