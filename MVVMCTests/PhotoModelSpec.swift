//
//  PhotoTargetSpec.swift
//  MoyaTest
//
//  Created by belga on 15/1/17.
//  Copyright © 2017 GFI. All rights reserved.
//

import Quick
import Nimble
import Moya

@testable import MVVMC

class PhotoModelSpec: QuickSpec {
  override func spec() {
    var service: PhotoModelType = PhotoModel()
    
    
    describe("PhotoModel listPhotos") {
      
      context("with correct data") {
        
        beforeEach({
          let testProvider = MoyaProvider<PhotoTarget>(stubClosure: MoyaProvider.immediatelyStub)
          service.provider = testProvider
        })
        it("returns a list of photos") {
          var errored = false
          var photos : [PhotoType] = []
          waitUntil(action: { done in
            service.listPhotos({ result in
              photos = result
              done()
            }, fail: { error in
              errored = true
              done()
            })
          })
          expect(photos.count).to(equal(100))
          expect(errored).to(beFalse())
        }
      }
      
      context("with errors") {
        beforeEach({
          let failureEndpointClosure = { (target: PhotoTarget) -> Endpoint<PhotoTarget> in
            let url = target.baseURL.appendingPathComponent(target.path).absoluteString
            let error = NSError(domain: "com.moya.moyaerror", code: 0, userInfo: [NSLocalizedDescriptionKey: "Houston, we have a problem"])
            return Endpoint<PhotoTarget>(url: url, sampleResponseClosure: {.networkError(error)}, method: target.method, parameters: target.parameters)
          }
          let testProvider = MoyaProvider<PhotoTarget>(endpointClosure:failureEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
          service.provider = testProvider
        })
        it("listPhotos returns an error") {
          var errored = false
          var photos : [PhotoType] = []
          waitUntil(action: { done in
            service.listPhotos({ result in
              photos = result
              done()
            }, fail: { error in
              errored = true
              done()
            })
          })
          expect(errored).to(beTrue())
          expect(photos).to(beEmpty())
        }
      }
      
      
      context("with server error") {
        beforeEach({
          let failureEndpointClosure = { (target: PhotoTarget) -> Endpoint<PhotoTarget> in
            let url = target.baseURL.appendingPathComponent(target.path).absoluteString
            return Endpoint<PhotoTarget>(url: url, sampleResponseClosure: {.networkResponse(500, Data())}, method: target.method, parameters: target.parameters)
          }
          let testProvider = MoyaProvider<PhotoTarget>(endpointClosure:failureEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
          service.provider = testProvider
        })
        it("listPhotos returns an error") {
          var errored = false
          var photos : [PhotoType] = []
          waitUntil(action: { done in
            service.listPhotos({ result in
              photos = result
              done()
            }, fail: { error in
              errored = true
              done()
            })
          })
          expect(errored).to(beTrue())
          expect(photos).to(beEmpty())
        }
      }
    }
    
    describe("PhotoModel getPhoto") {
      
      context("with succesfull request") {
        
        beforeEach({
          let testProvider = MoyaProvider<PhotoTarget>(stubClosure: MoyaProvider.immediatelyStub)
          service.provider = testProvider
        })
        it("returns a photo") {
          var errored = false
          var photo : PhotoType?
          waitUntil(action: { done in
            service.getPhoto(id:1, success: { result in
              photo = result
              done()
            }, fail: { error in
              errored = true
              done()
            })
          })
          expect(photo).notTo(beNil())
          expect(errored).to(beFalse())
        }
      }
    }
  }
}
