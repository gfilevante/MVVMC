//
//  ListViewModel.swift
//  MVVM
//
//  Created by belga on 18/1/17.
//  Copyright © 2017 GFI. All rights reserved.
//

import Foundation

protocol ListPhotoViewModelTypeDelegate: class
{
  func itemsDidChange(viewModel: ListPhotoViewModelType)
  func showError(error: Swift.Error)
}


protocol ListPhotoViewModelCoordinatorDelegate: class
{
  func didSelectData(_ viewModel: ListPhotoViewModelType, item: PhotoViewModelType)
}

protocol ListPhotoViewModelType
{

  var model: PhotoModelType? { get set }
  var viewDelegate: ListPhotoViewModelTypeDelegate? { get set }
  var coordinatorDelegate: ListPhotoViewModelCoordinatorDelegate? { get set}
  
  
  var numberOfItems: Int { get }
  func itemAtIndex(_ index: Int) -> PhotoViewModelType?
  func useItemAtIndex(_ index: Int)
}
