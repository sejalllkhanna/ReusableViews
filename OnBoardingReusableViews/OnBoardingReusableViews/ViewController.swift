//
//  ViewController.swift
//  OnBoardingReusableViews
//
//  Created by Sejal Khanna on 08/06/22.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
   
    @IBOutlet weak var ReusableInputView: ReusableInputView!
    var InputTextField: CustomInputTextField!
    var inputFieldTopConstraint: NSLayoutConstraint!
    var inputFieldHeightConstraint: NSLayoutConstraint!
    var inputFieldLeadingConstraint: NSLayoutConstraint!
    var inputFieldTrailingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        let leftbarButton = UIButton().addBarButton(image: #imageLiteral(resourceName: "backButton"), ViewController: self, color: UIColor(named: "crossButtonColor") ?? UIColor(white: 1, alpha: 0.1), left: true)
        leftbarButton.addTarget(self, action:#selector(backButtonPressed),for:.touchUpInside)
        let rightbarButton = UIButton().addBarButton(image: #imageLiteral(resourceName: "cancelButton"), ViewController: self, color: UIColor(named: "crossButtonColor") ?? UIColor(white: 1, alpha: 0.1), left: false)
        rightbarButton.addTarget(self, action:#selector(crossBarButtonPressed),for:.touchUpInside)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            ReusableInputView.BottomSectionBottomConstraint.constant = keyboardSize.height
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        ReusableInputView.BottomSectionBottomConstraint.constant = 0
    }
    
    @objc private func crossBarButtonPressed() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    @objc private func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    private func setupUI() {
        
        InputTextField = CustomInputTextField()
        InputTextField.InputTextField.delegate = self
        
        view.addSubview(InputTextField)
        
        inputFieldTopConstraint = InputTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 350)
        inputFieldHeightConstraint = InputTextField.heightAnchor.constraint(equalToConstant: 60)
        inputFieldLeadingConstraint = InputTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        inputFieldTrailingConstraint = InputTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        
        NSLayoutConstraint.activate([
            inputFieldTopConstraint,
            inputFieldLeadingConstraint,
            inputFieldTrailingConstraint,
            inputFieldHeightConstraint
        ])
    }
    
}

extension UIButton {
    func addBarButton(image:UIImage,ViewController:UIViewController,color:UIColor?, left: Bool)->UIButton{
        if left {
            let leftbarButton = UIButton().addBackButtonInNavigationBar(setImage: image, color: color)
            let barButton = UIBarButtonItem(customView: leftbarButton)
            ViewController.navigationItem.leftBarButtonItems = [barButton]
            return leftbarButton
        } else {
            let rightbarButton = UIButton().addBackButtonInNavigationBar(setImage: image, color: color)
            let barButton = UIBarButtonItem(customView: rightbarButton)
            ViewController.navigationItem.rightBarButtonItems = [barButton]
            return rightbarButton
        }
    }
    
    func addBackButtonInNavigationBar(setImage:UIImage,color:UIColor?)->UIButton{
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(setImage, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        if (color != nil){
            button.backgroundColor = color
        }else{
            button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3)
        }
        
        button.layer.cornerRadius =  5
        
        return button
    }
}
