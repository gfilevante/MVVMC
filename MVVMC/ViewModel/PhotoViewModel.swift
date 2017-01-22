//
//  PhotoViewModel.swift
//  MVVM
//
//  Created by belga on 19/1/17.
//  Copyright © 2017 GFI. All rights reserved.
//

import Foundation

class PhotoViewModel: PhotoViewModelType {
  
  var photo : PhotoType?
  
  var id: Int? {
    return photo?.id
  }
  var title: String
  var date: String
  var url: URL?
  var thumbnailUrl: URL?
	
  init(photo:PhotoType) {
    self.photo = photo
    self.title = photo.title ?? ""
    self.date = ""
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    if let date = photo.date {
      self.date = dateFormatter.string(from: date)
    }
    if let url = photo.thumbnailUrl {
      self.thumbnailUrl = URL(string:url)
    }
    if let url = photo.url {
      self.url = URL(string:url)
    }
  }
  
}
