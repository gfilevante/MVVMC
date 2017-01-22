//
//  TableViewCell.swift
//  MoyaTest
//
//  Created by belga on 14/1/17.
//  Copyright © 2017 GFI. All rights reserved.
//

import UIKit
import AlamofireImage

class TableViewCell: UITableViewCell {

  @IBOutlet var title: UILabel!
  
  @IBOutlet var thumbnailImageView: UIImageView!
  
  @IBOutlet var date: UILabel!
  
  
  var viewModel: PhotoViewModelType? {
    didSet {
      if let viewModel = viewModel {
        title.text = viewModel.title
        if let thumbnailUrl = viewModel.thumbnailUrl {
          thumbnailImageView.af_setImage(withURL: thumbnailUrl)
        }
        date.text = viewModel.date
      } else {
        title.text = "Unknown"
        date.text = "Unknown"
      }
    }
  }

}
