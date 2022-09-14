//
//  CustomInputTextField.swift
//  AadhaarValidation
//
//  Created by Sukhjeet Singh on 01/06/22.
//

import UIKit

class CustomInputTextField: UIView, UITextFieldDelegate {
    
    enum InputError: String {
        case Invalid
        case Required
        case Mismatch
        case none
    }
    
    static let identifier = "CustomInputTextField"
    
    let PlaceholderLabel: PaddedLabel = {
        let label = PaddedLabel(xPadding: 0, yPadding: 3)
        
        label.text = "Enter Aadhaar Number"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 25)
        
        return label
    }()
    
    private var PlaceholderLabelBottomConstraint: NSLayoutConstraint!
    private var PlaceholderLabelTrailingConstraint: NSLayoutConstraint!
    private var PlaceholderLabelHeightConstraint: NSLayoutConstraint!
    
    let InputTextField: CustomInputField = {
        let textField = CustomInputField()
        
        textField.textAlignment = .left
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 25)
        textField.keyboardType = .numberPad
        
        return textField
    }()
    
    private var InputTextFieldTopConstraint: NSLayoutConstraint!
    private var InputTextFieldLeadingConstraint: NSLayoutConstraint!
    private var InputTextFieldHeightConstraint: NSLayoutConstraint!
    
    private let ErrorLabel: PaddedLabel = {
        let label = PaddedLabel(xPadding: 8, yPadding: 0)
        
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemOrange
        label.layer.cornerRadius = 3
        label.clipsToBounds = true
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1
        
        return label
    }()
    
    private var ErrorLabelTrailingConstraint: NSLayoutConstraint!
    private var ErrorLabelBottomConstraint: NSLayoutConstraint!
    
    private let BackgroundView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 3.0
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowColor = UIColor.gray.cgColor
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    private func setupUI() {
        addSubview(BackgroundView)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        BackgroundView.addSubview(InputTextField)
        BackgroundView.addSubview(PlaceholderLabel)
        insertSubview(ErrorLabel, at: 1)
        
        PlaceholderLabelBottomConstraint = PlaceholderLabel.bottomAnchor.constraint(equalTo: BackgroundView.bottomAnchor)
        PlaceholderLabelTrailingConstraint = PlaceholderLabel.trailingAnchor.constraint(equalTo: BackgroundView.trailingAnchor)
        
        InputTextFieldTopConstraint = InputTextField.topAnchor.constraint(equalTo: BackgroundView.topAnchor)
        InputTextFieldLeadingConstraint = InputTextField.leadingAnchor.constraint(equalTo: BackgroundView.leadingAnchor, constant: 10)
        
        NSLayoutConstraint.activate([
            BackgroundView.topAnchor.constraint(equalTo: topAnchor),
            BackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            BackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            BackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            PlaceholderLabel.topAnchor.constraint(equalTo: BackgroundView.topAnchor),
            PlaceholderLabelBottomConstraint,
            PlaceholderLabel.leadingAnchor.constraint(equalTo: InputTextField.leadingAnchor),
            PlaceholderLabelTrailingConstraint,
            
            InputTextFieldTopConstraint,
            InputTextField.bottomAnchor.constraint(equalTo: BackgroundView.bottomAnchor),
            InputTextFieldLeadingConstraint,
            InputTextField.trailingAnchor.constraint(equalTo: BackgroundView.trailingAnchor),
        ])
        
        InputTextField.addTarget(self, action: #selector(textFieldValueChanged), for: .editingChanged)
    }
    
    @objc private func textFieldValueChanged() {
        ErrorLabel.isHidden = true
    }
    
    func removePlaceHolder() {
        if InputTextField.text != nil && InputTextField.text!.count == 0 {
            PlaceholderLabelBottomConstraint.isActive = false
            InputTextFieldTopConstraint.isActive = false
            
            PlaceholderLabelHeightConstraint = PlaceholderLabel.heightAnchor.constraint(equalToConstant: 20)
            
            PlaceholderLabelBottomConstraint = PlaceholderLabel.bottomAnchor.constraint(equalTo: InputTextField.topAnchor)
            PlaceholderLabelTrailingConstraint.constant = -(PlaceholderLabel.frame.width * 0.55)
            
            InputTextFieldTopConstraint = InputTextField.topAnchor.constraint(equalTo: PlaceholderLabel.bottomAnchor)
            InputTextFieldLeadingConstraint.constant = 20
            
            PlaceholderLabelBottomConstraint.isActive = true
            PlaceholderLabelHeightConstraint.isActive = true
            InputTextFieldTopConstraint.isActive = true
            
            UIView.animate(withDuration: 0.2) {
                self.layoutIfNeeded()
            }
        }
    }
    
    func keyBoardWillHide() {
        if InputTextField.text != nil && InputTextField.text!.count == 0 {
            PlaceholderLabelBottomConstraint.isActive = false
            PlaceholderLabelHeightConstraint.isActive = false
            InputTextFieldTopConstraint.isActive = false
            
            PlaceholderLabelBottomConstraint = PlaceholderLabel.bottomAnchor.constraint(equalTo: BackgroundView.bottomAnchor)
            PlaceholderLabelTrailingConstraint.constant = 0
            
            InputTextFieldTopConstraint = InputTextField.topAnchor.constraint(equalTo: BackgroundView.topAnchor)
            InputTextFieldLeadingConstraint.constant = 10
            
            PlaceholderLabelBottomConstraint.isActive = true
            InputTextFieldTopConstraint.isActive = true
            
            UIView.animate(withDuration: 0.2) {
                self.layoutIfNeeded()
            }
        }
    }
    
    func showError(errorType: InputError) {
        if errorType == .none {
            ErrorLabel.isHidden = true
            ErrorLabel.text = ""
            return
        }
        ErrorLabel.text = errorType.rawValue
        ErrorLabel.isHidden = false
        //Setup ErrorLabel
        ErrorLabelTrailingConstraint = ErrorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ErrorLabelBottomConstraint = ErrorLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10)
        
        NSLayoutConstraint.activate([
            ErrorLabelTrailingConstraint,
            ErrorLabelBottomConstraint
        ])
    }
}

final class CustomInputField: UITextField {    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 0 , dy: -5)
    }
}

final class PaddedLabel: UILabel {
    
    var topInset: CGFloat = 2.0
    var bottomInset: CGFloat = 2.0
    var leftInset: CGFloat = 8.0
    var rightInset: CGFloat = 8.0
    
    convenience init(xPadding: CGFloat, yPadding: CGFloat) {
        self.init(frame: .zero)
        
        topInset = yPadding
        bottomInset = yPadding
        leftInset = xPadding
        rightInset = xPadding
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset, height: size.height + topInset + bottomInset)
    }
    
}
