//
//  ReusableInputView.swift
//  OnBoardingReusableViews
//
//  Created by Sejal Khanna on 08/06/22.
//

import UIKit

class ReusableInputView: UIView {
    
    @IBOutlet weak var TopSection: UIView!
    @IBOutlet weak var MiddleSection: UIView!
    @IBOutlet weak var BottomSection: UIView!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var SubTitleLabel: UILabel!
    @IBOutlet weak var NextButton: UIButton!
    
    @IBOutlet weak var BottomSectionBottomConstraint: NSLayoutConstraint!
    
    let nibName = "ReusableInputView"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    
    
}
