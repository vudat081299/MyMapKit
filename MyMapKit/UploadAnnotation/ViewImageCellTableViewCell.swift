//
//  ViewImageCellTableViewCell.swift
//  MyMapKit
//
//  Created by Vũ Quý Đạt  on 20/12/2020.
//

import UIKit

class ViewImageCellTableViewCell: UITableViewCell {

    @IBOutlet weak var textInput: UITextField!
    @IBOutlet weak var imageAnno: UIImageView!
    @IBOutlet weak var layerImageView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageAnno.border()
        layerImageView.dropShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func didEdit(_ sender: UITextField) {
        if uploadAnnotationData.imageNote!.count > 0 {
            uploadAnnotationData.imageNote?[0] = textInput.text!
        } else {
            uploadAnnotationData.imageNote?.append(textInput.text!)
        }
    }
    
    
}
