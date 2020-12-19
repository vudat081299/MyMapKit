//
//  SignUpViewController.swift
//  MyMapKit
//
//  Created by Vũ Quý Đạt  on 19/12/2020.
//

import UIKit

class SignUpViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var listInputCollectionView: UICollectionView!
    @IBOutlet weak var gradienBg: Gradient!
    
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var currentProgressDot: UIView!
    @IBOutlet weak var backButton: UIButton!
    
    var inputTitle = ["Your full name", "Username", "Phone number", "Email", "Password", "Confirm password"]
    
    let x = UIImage(named: "x")?.withRenderingMode(.alwaysTemplate)
    var lastContentOffset: CGFloat! = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.listInputCollectionView.register(UINib(nibName: "SignUpCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SignUpCollectionViewCell")
        progressView.minEdgeBorder()
        currentProgressDot.roundedBorder()
            backButton.setImage(x, for: .normal)
        backButton.tintColor = .white
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inputTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SignUpCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SignUpCollectionViewCell", for: indexPath) as! SignUpCollectionViewCell
        cell.title.text = inputTitle[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.size.width, height: 300)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
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
        if scrollView.contentOffset.x < -100.0 {
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
