//
//  DetailPhotoCoordinatorSpec.swift
//  MVVMC
//
//  Created by belga on 21/1/17.
//  Copyright © 2017 GFI. All rights reserved.
//

import Quick
import Nimble

@testable import MVVMC

class DetailPhotoCoordinatorSpec: QuickSpec {
  override func spec() {
    describe("DetailCoordinator") {
      var detailCoordinator: DetailPhotoCoordinator!
      var navigationController : UINavigationController!
      
      beforeEach {
        navigationController = UINavigationController()
        let photo = Photo(id:1,  albumId: 1, title: "Foto 1", url: "http://lorempixel.com/640/480/cats/1/",
                          thumbnailUrl: "http://lorempixel.com/128/96/cats/1/", date: Date(timeIntervalSince1970: 1485000000)) // 2017-01-21
        let item = PhotoViewModel(photo: photo)
        detailCoordinator = DetailPhotoCoordinator(navigationViewController: navigationController, item: item)
        detailCoordinator.start()
      }
      
      describe("start") {
        it("sets the detail view controller as root view controller") {
          expect(navigationController.topViewController).to(beAKindOf(DetailPhotoViewController.self))
        }
        
        it("sets the detail view model of the controller") {
          let detailViewController = navigationController.topViewController as! DetailPhotoViewController
          
          expect(detailViewController.viewModel).toNot(beNil())
        }
        
        it("sets itself as the detail view models coordinator delegate") {
          let detailViewController = navigationController.topViewController as! DetailPhotoViewController
          
          expect(detailViewController.viewModel!.coordinatorDelegate).to(beIdenticalTo(detailCoordinator))
        }
      }
      
      describe("detailViewModelDidEnd") {
        var mockDelegate: MockDetailCoordinatorDelegate!
        
        beforeEach {
          mockDelegate = MockDetailCoordinatorDelegate()
          detailCoordinator.delegate = mockDelegate
          let photo = Photo(id:1,  albumId: 1, title: "Foto 1", url: "http://lorempixel.com/640/480/cats/1/",
                            thumbnailUrl: "http://lorempixel.com/128/96/cats/1/", date: Date(timeIntervalSince1970: 1485000000)) // 2017-01-21
          let item = PhotoViewModel(photo: photo)
          let viewModel = DetailPhotoViewModel(item: item)
          detailCoordinator.detailPhotoViewModelDidFinish(viewModel)
        }
        
        it("calls the delegates did finish function") {
          expect(mockDelegate.wasCalled).to(beTrue())
        }
        
        it("passes itself to the did finish function") {
          expect(mockDelegate.lastCaller).to(beIdenticalTo(detailCoordinator))
        }
      }
    }
  }
}

private class MockDetailCoordinatorDelegate: DetailPhotoCoordinatorDelegate {
  fileprivate(set) var wasCalled = false
  fileprivate(set) var lastCaller: DetailPhotoCoordinator!
  
  func detailCoordinatorDidFinish(detailCoordinator: DetailPhotoCoordinator) {
    wasCalled = true
    lastCaller = detailCoordinator
  }
}

