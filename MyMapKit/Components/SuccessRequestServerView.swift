//
//  SuccessRequestServerView.swift
//  MyMapKit
//
//  Created by Vũ Quý Đạt  on 24/12/2020.
//

import UIKit

class SuccessRequestServerView: UIView {

    @IBOutlet weak var animationView: NVActivityIndicatorView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    fileprivate func setupView() {
        // do your setup here
        animationView.type = .ballPulseSync
        animationView.startAnimating()
    }
    
    class func instanceFromNib() -> SuccessRequestServerView {
        let view = UINib(nibName: "SuccessRequestServerView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! SuccessRequestServerView
        view.setupView()
        return view
    }
    
}
