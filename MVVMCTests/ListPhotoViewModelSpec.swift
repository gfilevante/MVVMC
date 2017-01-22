//
//  ListPhotoViewModelSpec.swift
//  MVVM
//
//  Created by belga on 20/1/17.
//  Copyright © 2017 GFI. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Moya


@testable import MVVMC

class ListPhotoViewModelSpec: QuickSpec {

  override func spec() {
    describe("ListPhotoViewModel") {
      var listViewModel: ListPhotoViewModel!
      
      beforeEach {
        listViewModel = ListPhotoViewModel()
      }
      
      describe("model") {
        var mockModel: MockPhotoModel!
        var mockViewDelegate: MockListPhotoViewModelDelegate!
        
        beforeEach {
          mockViewDelegate = MockListPhotoViewModelDelegate()
          listViewModel.viewDelegate = mockViewDelegate
          mockModel = MockPhotoModel()

        }
        
        context("model retrieve data successfully") {
          beforeEach {
            listViewModel.model = mockModel
          }
          
          it("calls its itemsDidChange delegate") {
            expect(mockViewDelegate.itemDidChangeWasCalled).to(beTrue())
          }
        }
        
        context("model retrieve data failed") {
          beforeEach {
            mockModel.returnSuccessClosure = false
            listViewModel.model = mockModel
          }
          
          it("calls its showError delegate") {
            expect(mockViewDelegate.showErrorWasCalled).to(beTrue())
          }
        }
      }
      
      describe("numberOfItems") {
        var mockModel: MockPhotoModel!
        
        beforeEach {
          mockModel = MockPhotoModel()
          listViewModel.model = mockModel
        }
        
        it("returns the item count of the list model") {
          expect(listViewModel.numberOfItems).to(equal(mockModel.items.count))
        }
      }
      
      describe("itemAtIndex") {
        var mockModel: MockPhotoModel!
        
        beforeEach {
          mockModel = MockPhotoModel()
          listViewModel.model = mockModel
        }
        
        context("given a valid index") {
          it("returns the correct item") {
            let photoViewModel0 = listViewModel.itemAtIndex(0)
            let photo0 = mockModel.items[0]
            expect(photoViewModel0!.photo?.id).to(equal(photo0.id))
            expect(photoViewModel0!.photo?.albumId).to(equal(photo0.albumId))
            expect(photoViewModel0!.photo?.date).to(equal(photo0.date))
            expect(photoViewModel0!.photo?.thumbnailUrl).to(equal(photo0.thumbnailUrl))
            expect(photoViewModel0!.photo?.url).to(equal(photo0.url))
//            expect(photoViewModel0!.title).to(equal(photo0.title))
//            expect(photoViewModel0!.date).to(equal("21/01/2017"))
          }
        }
        
        context("given an invalid index") {
          it("returns nil") {
            expect(listViewModel.itemAtIndex(2)).to(beNil())
          }
        }
      }
    }
  }
}

private class MockPhotoModel : PhotoModelType{
  var  provider = MoyaProvider<PhotoTarget>()
  var returnSuccessClosure = true
  
  let items : [PhotoType] = [
    Photo(id:1,  albumId: 1, title: "Foto 1", url: "http://lorempixel.com/640/480/cats/1/",
          thumbnailUrl: "http://lorempixel.com/128/96/cats/1/", date: Date(timeIntervalSince1970: 1485000000)), // 2017-01-21 12:00:00
    Photo(id:1,  albumId: 1, title: "Foto 1", url: "http://lorempixel.com/640/480/cats/2/",
          thumbnailUrl: "http://lorempixel.com/128/96/cats/2/", date: Date(timeIntervalSince1970: 1482000000)) //2016-12-17 18:40:00
    ]
  
  func listPhotos(_ success: @escaping ([PhotoType]) -> Void, fail: @escaping (Swift.Error) -> Void) {
    if returnSuccessClosure {
      success(items)
    } else {
      let error = NSError(domain: "es.gfi.MVVM", code: 1, userInfo: nil)
      fail(error)
    }
  }
  
  func getPhoto(id: Int, success: @escaping (PhotoType) -> Void, fail: @escaping (Swift.Error) -> Void) {
    
  }
}

private class MockListPhotoViewModelDelegate: ListPhotoViewModelTypeDelegate {
  var itemDidChangeWasCalled = false
  var showErrorWasCalled = false
  
  func itemsDidChange(viewModel: ListPhotoViewModelType) {
    itemDidChangeWasCalled = true
  }
  
  func showError(error: Swift.Error) {
    showErrorWasCalled = true
  }
}
