//
//  BookCollectionViewCell.swift
//  Robateria
//
//  Created by Korbinian Baumer on 16.01.18.
//  Copyright © 2018 Korbinian Baumer. All rights reserved.
//

import Foundation
import UIKit

class BookCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bookTitle: UILabel!

    func displayContent(title: String){

        bookTitle.text = title
    }
}
