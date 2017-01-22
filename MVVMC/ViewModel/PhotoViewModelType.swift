//
//  PhotoModelType.swift
//  MVVM
//
//  Created by belga on 19/1/17.
//  Copyright © 2017 GFI. All rights reserved.
//

import Foundation

protocol PhotoViewModelType {
  var photo: PhotoType? {get}
  
  var id: Int? {get}
  var title: String {get}
  var date: String {get}
  var url: URL? {get}
  var thumbnailUrl: URL? {get}
}
