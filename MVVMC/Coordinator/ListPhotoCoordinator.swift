//
//  ListPhotoCoordinator.swift
//  MVVMC
//
//  Created by belga on 20/1/17.
//  Copyright © 2017 GFI. All rights reserved.
//

import UIKit

protocol ListPhotoCoordinatorDelegate: class
{
  func listPhotoCoordinatorDidFinish(listCoordinator: ListPhotoCoordinator)
}


class ListPhotoCoordinator: Coordinator
{
  
  
  
  weak var delegate: ListPhotoCoordinatorDelegate?
  fileprivate(set) var detailCoordinator: DetailPhotoCoordinator?
  fileprivate var window: UIWindow
  
  fileprivate var listViewController: ListPhotoViewController?
  fileprivate var navigationViewController: UINavigationController?
  
  
  init(window: UIWindow)
  {
    self.window = window
  }
  
  func start()
  {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    listViewController = storyboard.instantiateViewController(withIdentifier: "listPhoto") as? ListPhotoViewController
    
    guard let listViewController = listViewController else { return }
    navigationViewController = UINavigationController(rootViewController: listViewController)
    guard let navigationViewController = navigationViewController else { return }
    
    let viewModel =  ListPhotoViewModel()
    viewModel.model = PhotoModel()
    viewModel.coordinatorDelegate = self
    listViewController.viewModel = viewModel
    window.rootViewController = navigationViewController
  }
}

extension ListPhotoCoordinator: ListPhotoViewModelCoordinatorDelegate
{
  func didSelectData(_ viewModel: ListPhotoViewModelType, item: PhotoViewModelType )
  {
    detailCoordinator = DetailPhotoCoordinator(navigationViewController: navigationViewController!, item: item)
    detailCoordinator?.delegate = self
    detailCoordinator?.start()
  }
}



extension ListPhotoCoordinator: DetailPhotoCoordinatorDelegate
{
  func detailCoordinatorDidFinish(detailCoordinator: DetailPhotoCoordinator)
  {
    self.detailCoordinator = nil
    guard let navigationViewController = navigationViewController else { return }
    navigationViewController.popViewController(animated: true)
  }
}



