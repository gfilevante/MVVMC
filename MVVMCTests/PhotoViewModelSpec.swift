//
//  PhotoViewModelSpec.swift
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

class PhotoViewModelSpec: QuickSpec {
  override func spec() {
    describe("PhotoViewModel") {
      describe("model") {
        var photo : PhotoType!
        var photoViewModel:PhotoViewModelType!
        
        beforeEach {
          photo = Photo(id:1,  albumId: 1, title: "Foto 1", url: "http://lorempixel.com/640/480/cats/1/",
                            thumbnailUrl: "http://lorempixel.com/128/96/cats/1/", date: Date(timeIntervalSince1970: 1485000000)) // 2017-01-21 12:00:00
          photoViewModel = PhotoViewModel(photo: photo)
        }
        
        it("contains valid data") {
          expect(photoViewModel!.photo?.id).to(equal(photo.id))
          expect(photoViewModel!.photo?.albumId).to(equal(photo.albumId))
          expect(photoViewModel!.photo?.date).to(equal(photo.date))
          expect(photoViewModel!.photo?.thumbnailUrl).to(equal(photo.thumbnailUrl))
          expect(photoViewModel!.photo?.url).to(equal(photo.url))
          expect(photoViewModel!.title).to(equal(photo.title))
          expect(photoViewModel!.date).to(equal("21/01/2017"))
          expect(photoViewModel!.thumbnailUrl?.absoluteString).to(equal(photo.thumbnailUrl))
        }
      }
    }
    
    
  }
}
