//
//  ListPhotoCoordinatorSpec.swift
//  MVVMC
//
//  Created by belga on 21/1/17.
//  Copyright © 2017 GFI. All rights reserved.
//

import Quick
import Nimble

@testable import MVVMC

class ListPhotoCoordinatorSpec: QuickSpec {
  override func spec() {
    describe("ListPhotoCoordinator") {
      var listCoordinator: ListPhotoCoordinator!
      var window: UIWindow!
      
      beforeEach({
        window = UIWindow()
        listCoordinator = ListPhotoCoordinator(window: window)
        listCoordinator.start()
      })
      
      describe("start") {
        it("sets the list photo view controller as root view controller") {
          expect(window.rootViewController).to(beAKindOf(UINavigationController.self))
          let navigationController = window.rootViewController as! UINavigationController
          expect(navigationController.topViewController).to(beAKindOf(ListPhotoViewController.self))
          
        }
        
        it("sets the list photo view model of the controller") {
          let navigationController = window.rootViewController as! UINavigationController
          let listViewController = navigationController.topViewController as! ListPhotoViewController
          
          expect(listViewController.viewModel).toNot(beNil())
        }
        
        it("sets itself as the list photo view models coordinator delegate") {
          let navigationController = window.rootViewController as! UINavigationController
          let listViewController = navigationController.topViewController as! ListPhotoViewController
          
          expect(listViewController.viewModel!.coordinatorDelegate).to(beIdenticalTo(listCoordinator))
        }
      }
      
      describe("didSelectData") {
        beforeEach {
          let viewModel = ListPhotoViewModel()
          let photo = Photo(id:1,  albumId: 1, title: "Foto 1", url: "http://lorempixel.com/640/480/cats/1/",
                            thumbnailUrl: "http://lorempixel.com/128/96/cats/1/", date: Date(timeIntervalSince1970: 1485000000)) // 2017-01-21
          let item = PhotoViewModel(photo: photo)

          listCoordinator.didSelectData(viewModel, item: item)
        }
        
        it("sets the detail coordinator") {
          expect(listCoordinator.detailCoordinator).toNot(beNil())
        }
        
        it("sets itself as the detail coordinators delegate") {
          expect(listCoordinator.detailCoordinator!.delegate).to(beIdenticalTo(listCoordinator))
        }
      }
      
      describe("detailCoordinatorDidFinish") {
        beforeEach {
          let viewModel = ListPhotoViewModel()
          let photo = Photo(id:1,  albumId: 1, title: "Foto 1", url: "http://lorempixel.com/640/480/cats/1/",
                            thumbnailUrl: "http://lorempixel.com/128/96/cats/1/", date: Date(timeIntervalSince1970: 1485000000)) // 2017-01-21
          let item = PhotoViewModel(photo: photo)
          
          listCoordinator.didSelectData(viewModel, item: item)
          
          listCoordinator.detailCoordinatorDidFinish(detailCoordinator: listCoordinator.detailCoordinator!)
        }
        
        it("removes the detail coordinator") {
          expect(listCoordinator.detailCoordinator).to(beNil())
        }
        
        it("sets the list view controller as the root view controller") {
          expect(window.rootViewController).to(beAKindOf(UINavigationController.self))
          let navigationController = window.rootViewController as! UINavigationController
          expect(navigationController.topViewController).to(beAKindOf(ListPhotoViewController.self))
        }
      }
    }
  }
}

