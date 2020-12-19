//
//  AnnotatitionViewController.swift
//  MyMapKit
//
//  Created by Vũ Quý Đạt  on 19/12/2020.
//

import UIKit

let leadingEdgeCollectionView: CGFloat = 30.0

class AnnotatitionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    var annotationList = [1, 2, 3]
    var CellWidth = 0.0
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return annotationList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: AnnotationImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnnotationImageCell", for: indexPath) as! AnnotationImageCell
        if indexPath.row == 0 {
            cell.csLeadingBgImageView.constant = leadingEdgeCollectionView
            cell.csTrailingBgImageView.constant = 0
        } else if (indexPath.row == annotationList.count - 1) {
            cell.csLeadingBgImageView.constant = 0
            cell.csTrailingBgImageView.constant = leadingEdgeCollectionView
        } else {
            cell.csLeadingBgImageView.constant = 0
            cell.csTrailingBgImageView.constant = 0
        }
        cell.backGroundImageView.border(10)
        
        return cell
    }
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == 0 || indexPath.row == annotationList.count - 1 {
            return CGSize(width: view.frame.size.width - leadingEdgeCollectionView, height: view.frame.size.width * 3/5)
        } else {
            return CGSize(width: view.frame.size.width - 2 * leadingEdgeCollectionView, height: view.frame.size.width * 3/5)
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.myCollectionView.register(UINib(nibName: "AnnotationImageCell", bundle: nil), forCellWithReuseIdentifier: "AnnotationImageCell")
        CellWidth = Double(view.frame.size.width - 1.5 * leadingEdgeCollectionView)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension AnnotatitionViewController: UIScrollViewDelegate {
    
    // do not enabled paging
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.myCollectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        var cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        cellWidthIncludingSpacing = view.frame.size.width - 45
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
//        print("\(layout.itemSize.width) - \(layout.minimumLineSpacing)")
//        print("\(cellWidthIncludingSpacing) - \(offset) - \(index) - \(roundedIndex) - \(roundedIndex)")
        targetContentOffset.pointee = offset
    }
}
