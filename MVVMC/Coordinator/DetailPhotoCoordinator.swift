//
//  DetailCoordinator.swift
//  MVVMC
//
//  Created by belga on 20/1/17.
//  Copyright © 2017 GFI. All rights reserved.
//


import UIKit


protocol DetailPhotoCoordinatorDelegate: class
{
  func detailCoordinatorDidFinish(detailCoordinator: DetailPhotoCoordinator)
}

class DetailPhotoCoordinator: Coordinator
{
  weak var delegate: DetailPhotoCoordinatorDelegate?
  fileprivate let item: PhotoViewModelType
  //fileprivate var window: UIWindow
  fileprivate var navigationViewController: UINavigationController
  
  init(navigationViewController: UINavigationController, item: PhotoViewModelType)
  {
    self.navigationViewController = navigationViewController
    self.item = item
  }
  
  func start()
  {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    if let vc = storyboard.instantiateViewController(withIdentifier: "detailPhoto") as? DetailPhotoViewController {
      let viewModel =  DetailPhotoViewModel(item: item)
      viewModel.model = PhotoModel()
      viewModel.coordinatorDelegate = self
      vc.viewModel = viewModel
      navigationViewController.pushViewController(vc, animated: true)
      //window.rootViewController = vc
    }
  }
}

extension DetailPhotoCoordinator: DetailPhotoViewModelCoordinatorDelegate
{
  
  func detailPhotoViewModelDidFinish(_ viewModel: DetailPhotoViewModelType)
  {
    delegate?.detailCoordinatorDidFinish(detailCoordinator: self)
  }
  
}
