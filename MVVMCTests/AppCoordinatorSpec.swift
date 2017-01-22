//
//  AppCoordinatorSpec.swift
//  MVVMC
//
//  Created by belga on 21/1/17.
//  Copyright © 2017 GFI. All rights reserved.
//


import Quick
import Nimble

@testable import MVVMC

class AppCoordinatorSpec: QuickSpec {
  override func spec() {
    describe("AppCoordinator") {
      var appCoordinator: AppCoordinator!
      
      beforeEach({
        let window = UIWindow()
        appCoordinator = AppCoordinator(window: window)
        appCoordinator.start()
      })
      
      describe("start") {
        it("sets the listPhoto coordinator") {
          if (appCoordinator.childCoordinator is ListPhotoCoordinator) == false {
            fail("Expected an ListPhotoCoordinator, got something else")
          }
        }
        
        it("sets itself as the authentication coordinators delegate") {
          let listPhotoCoordinator = appCoordinator.childCoordinator as! ListPhotoCoordinator
          
          expect(listPhotoCoordinator.delegate!).to(beIdenticalTo(appCoordinator))
        }
      }
      

      
//      describe("listCoordinatorDidFinish") {
//        beforeEach({
//          let authenticationCoordinator = appCoordinator.coordinators[CoordinatorType.authentication] as! AuthenticationCoordinator
//          appCoordinator.authenticationCoordinatorDidFinish(authenticationCoordinator: authenticationCoordinator)
//          let listCoordinator = appCoordinator.coordinators[CoordinatorType.list] as! ListCoordinator
//          appCoordinator.listCoordinatorDidFinish(listCoordinator: listCoordinator)
//        })
//        
//        it("removes the list coordinator") {
//          expect(appCoordinator.coordinators[CoordinatorType.list]).to(beNil())
//        }
//      }
    }
  }
}
