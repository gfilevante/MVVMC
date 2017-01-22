//
//  DetailPhotoViewModelSpec.swift
//  MVVM
//
//  Created by belga on 20/1/17.
//  Copyright © 2017 GFI. All rights reserved.
//

import Foundation


import Foundation
import Quick
import Nimble
import Moya


@testable import MVVMC

class DetailPhotoViewModelSpec: QuickSpec {
  
  override func spec() {
    describe("DetailPhotoViewModel") {
      var detailViewModel: DetailPhotoViewModel!
      
      beforeEach {
        let photo = Photo(id:1,  albumId: 1, title: "Foto 1", url: "http://lorempixel.com/640/480/cats/1/",
              thumbnailUrl: "http://lorempixel.com/128/96/cats/1/", date: Date(timeIntervalSince1970: 1485000000)) // 2017-01-21
        let photoViewModel = PhotoViewModel(photo: photo)
        detailViewModel = DetailPhotoViewModel(item: photoViewModel)
      }
      
      describe("model") {
        var mockModel: MockPhotoModel!
        var mockViewDelegate: MockDetailPhotoViewModelDelegate!
        
        beforeEach {
          mockViewDelegate = MockDetailPhotoViewModelDelegate()
          detailViewModel.viewDelegate = mockViewDelegate
          mockModel = MockPhotoModel()
          
        }
        
        context("model retrieve data successfully") {
          beforeEach {
            detailViewModel.model = mockModel
          }
          
          it("calls its itemsDidChange delegate") {
            expect(mockViewDelegate.itemDidChangeWasCalled).to(beTrue())
          }
        }
        
        context("model retrieve data failed") {
          beforeEach {
            mockModel.returnSuccessClosure = false
            detailViewModel.model = mockModel
          }
          
          it("calls its showError delegate") {
            expect(mockViewDelegate.showErrorWasCalled).to(beTrue())
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
          thumbnailUrl: "http://lorempixel.com/128/96/cats/1/", date: Date(timeIntervalSince1970: 1485000000)) //2016-12-17 18:40:00
  ]
  
  func listPhotos(_ success: @escaping ([PhotoType]) -> Void, fail: @escaping (Swift.Error) -> Void) {

  }
  
  func getPhoto(id: Int, success: @escaping (PhotoType) -> Void, fail: @escaping (Swift.Error) -> Void) {
    if returnSuccessClosure {
      success(items[0])
    } else {
      let error = NSError(domain: "es.gfi.MVVM", code: 1, userInfo: nil)
      fail(error)
    }
  }
}



private class MockDetailPhotoViewModelDelegate: DetailPhotoViewModelDelegateType {
  var itemDidChangeWasCalled = false
  var showErrorWasCalled = false
  
  func detailDidLoad(viewModel: DetailPhotoViewModelType) {
    itemDidChangeWasCalled = true
  }
  
  func detailErrorReceived( error: Swift.Error) {
    showErrorWasCalled = true
  }
  
}
