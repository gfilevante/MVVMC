//
//  AppCoordinator.swift
//  MVVMC
//
//  Created by belga on 20/1/17.
//  Copyright © 2017 GFI. All rights reserved.
//


import UIKit

class AppCoordinator: Coordinator {
  
  fileprivate var window: UIWindow
  fileprivate(set) var childCoordinator: Coordinator?
  
  init(window: UIWindow)
  {
    self.window = window
  }
  
  func start() {
      showListPhoto()
  }
}


extension AppCoordinator : ListPhotoCoordinatorDelegate {
  
  func showListPhoto() {
    let listCoordinator = ListPhotoCoordinator(window: window)
    childCoordinator = listCoordinator
    listCoordinator.delegate = self
    listCoordinator.start()

  }
  
  func listPhotoCoordinatorDidFinish(listCoordinator: ListPhotoCoordinator) {
    childCoordinator = nil
  }
  
  
}
