//
//  DetailPhotoViewModelType.swift
//  MVVM
//
//  Created by belga on 20/1/17.
//  Copyright © 2017 GFI. All rights reserved.
//

import Foundation



protocol DetailPhotoViewModelDelegateType: class
{
  func detailDidLoad(viewModel: DetailPhotoViewModelType)
  func detailErrorReceived( error: Swift.Error)
}

protocol DetailPhotoViewModelCoordinatorDelegate: class
{
  func detailPhotoViewModelDidFinish(_ viewModel: DetailPhotoViewModelType)
}


protocol DetailPhotoViewModelType
{
  var model: PhotoModelType? { get set }
  var viewDelegate: DetailPhotoViewModelDelegateType? { get set }
  var coordinatorDelegate: DetailPhotoViewModelCoordinatorDelegate? { get set}
  var item: PhotoViewModelType? { get }
  var title : String {get}
  var date : String {get}
  var url: URL? {get}
  
  func didFinish()
		
}
