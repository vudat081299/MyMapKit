//
//  SignUpCollectionViewCell.swift
//  MyMapKit
//
//  Created by Vũ Quý Đạt  on 19/12/2020.
//

import UIKit

class SignUpCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var textInput: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var viewInput: UIView!
    @IBOutlet weak var layerInputVIew: UIView!
    
    let rightArrow = UIImage(named: ">")?.withRenderingMode(.alwaysTemplate)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        nextButton.setImage(rightArrow, for: .normal)
        nextButton.tintColor = .darkGray
        viewInput.border()
        viewInput.dropShadow()
        layerInputVIew.border()
    }

    @IBAction func next(_ sender: Any) {
        
    }
    
}
