//
//  SignUpViewController.swift
//  MyMapKit
//
//  Created by Vũ Quý Đạt  on 19/12/2020.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var gradienBg: Gradient!
    
    @IBOutlet weak var scrollInputView: UIScrollView!
    
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var currentProgressDot: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var imageBg: UIImageView!
    
    @IBOutlet weak var fullname: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var phonenumber: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmpassword: UITextField!
    
    @IBOutlet weak var fn1: UIView!
    @IBOutlet weak var fn2: UIView!
    @IBOutlet weak var un1: UIView!
    @IBOutlet weak var un2: UIView!
    @IBOutlet weak var pn1: UIView!
    @IBOutlet weak var pn2: UIView!
    @IBOutlet weak var em1: UIView!
    @IBOutlet weak var em2: UIView!
    @IBOutlet weak var pw1: UIView!
    @IBOutlet weak var pw2: UIView!
    @IBOutlet weak var cp1: UIView!
    @IBOutlet weak var cp2: UIView!
    @IBOutlet weak var bt1: UIButton!
    @IBOutlet weak var bt2: UIButton!
    @IBOutlet weak var bt3: UIButton!
    @IBOutlet weak var bt4: UIButton!
    @IBOutlet weak var bt5: UIButton!
    
    let x = UIImage(named: "x")?.withRenderingMode(.alwaysTemplate)
    var lastContentOffset: CGFloat! = 0
    var satelliteSize: CGFloat = 0.0
    var inputTitle = ["Your full name", "Username", "Phone number", "Email", "Password", "Confirm password"]
    var viewList: [UIView]!
    var buttonList: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // data
        viewList = [fn1, un1, pn1, em1, pw1, cp1, fn2, un2, pn2, em2, pw2, cp2]
        buttonList = [bt1, bt2, bt3, bt4, bt5]

        // Do any additional setup after loading the view.
        progressView.minEdgeBorder()
        currentProgressDot.roundedBorder()
        backButton.setImage(x, for: .normal)
        backButton.tintColor = .white
        
        setupAnimationBg()
        setUpView()
    }
    
    func setUpView() {
        borderAllViewIn(viewList)
        setUpButton(buttonList)
    }
    
    func borderAllViewIn(_ array: [UIView]) {
        for (index, value) in array.enumerated() {
            value.border()
            if index > 5 {
                value.dropShadow()
            }
        }
    }
    
    func setUpButton(_ array: [UIButton]) {
        let rightArrow = UIImage(named: ">")?.withRenderingMode(.alwaysTemplate)
        for value in array {
            value.setImage(rightArrow, for: .normal)
            value.tintColor = .darkGray
        }
    }
    
    func setupAnimationBg() {
//            let duration: CFTimeInterval = 30
//
//            // Animation
//            let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
//
//            animation.keyTimes = [0, 0.5, 1]
//            animation.values = [0, -Double.pi, -2 * Double.pi]
//            animation.duration = duration
//            animation.repeatCount = HUGE
//            animation.isRemovedOnCompletion = false
//
//        imageBg.layer.add(animation, forKey: "animation")
        
        
            // Rotate animation
            let rotateAnimation = CAKeyframeAnimation(keyPath: "position")

        rotateAnimation.path = UIBezierPath(arcCenter: CGPoint(x: view.frame.size.width / 2, y: imageBg.frame.size.height / 2),
                                                radius: (view.frame.size.width - satelliteSize) / 2 + 50,
                                                startAngle: CGFloat(Double.pi * 1.5),
                                                endAngle: CGFloat(Double.pi * 1.5 + 4 * Double.pi),
                                                clockwise: true).cgPath
            rotateAnimation.duration = 60 * 2
            rotateAnimation.repeatCount = HUGE
            rotateAnimation.isRemovedOnCompletion = false

            imageBg.layer.add(rotateAnimation, forKey: "animation")

    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func backButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func bt1Action(_ sender: UIButton) {
    
    }
    @IBAction func bt2Action(_ sender: UIButton) {
    
    }
    @IBAction func bt3Action(_ sender: UIButton) {
    
    }
    @IBAction func bt4Action(_ sender: UIButton) {
    
    }
    @IBAction func bt5Action(_ sender: UIButton) {
    
    }
    @IBAction func bt6Action(_ sender: UIButton) {
    
    }
}

extension SignUpViewController: UIScrollViewDelegate {
//    func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
//        <#code#>
//    }
    
    // do not enabled paging
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let layout = self.listInputCollectionView?.collectionViewLayout as! UICollectionViewFlowLayout
//        var cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
//        cellWidthIncludingSpacing = view.frame.size.width - 45
//        var offset = targetContentOffset.pointee
//        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
//        let roundedIndex = round(index)
//        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
////        print("\(layout.itemSize.width) - \(layout.minimumLineSpacing)")
////        print("\(cellWidthIncludingSpacing) - \(offset) - \(index) - \(roundedIndex) - \(roundedIndex)")
//        targetContentOffset.pointee = offset
//    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.tag == 1 && scrollView.contentOffset.x < -15.0 {
            navigationController?.popViewController(animated: true)
        }
//        if (2.2 > scrollView.contentOffset.x) {
//            // move up
//        }
//        else if (lastContentOffset < scrollView.contentOffset.x) {
//           // move down
//        }
//
//        // update the new position acquired
//        lastContentOffset = scrollView.contentOffset.x
    }
}
