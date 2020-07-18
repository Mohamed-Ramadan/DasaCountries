//
//  UITableView+Extension.swift
//  DasaCountries
//
//  Created by macbook on 7/18/20.
//  Copyright © 2020 macbook. All rights reserved.
//
 
import UIKit

extension UITableView {
    func setEmptyMessage(_ message: String, image: UIImage, withAddButton:Bool = false, buttonTitle:String = "",  completion:(()->())? = nil) {
        guard self.numberOfRows() == 0 else {
            return
        }
        
        let messageLabel = UILabel(frame: .zero)
        messageLabel.text = message
        messageLabel.textColor = UIColor.lightGray
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont.systemFont(ofSize: 13.0, weight: UIFont.Weight.regular)
        messageLabel.sizeToFit()
        
        
        let imageView = UIImageView(frame: .zero)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit 
        
        
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.spacing = 20
        vStack.alignment = .fill
        vStack.distribution = .fill
        
        vStack.addArrangedSubview(imageView)
        vStack.addArrangedSubview(messageLabel)
        
        if withAddButton {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: self.frame.size.width - 50, height: 60))
            button.setTitle(buttonTitle, for: .normal)
            button.layer.cornerRadius = 3
            button.clipsToBounds = true
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: UIFont.Weight.semibold)
            button.actionHandler(controlEvents: .touchUpInside) {
                if let complationHandler = completion {
                    complationHandler()
                }
            }
            vStack.addArrangedSubview(button)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([button.heightAnchor.constraint(equalToConstant: 45)])
        }
        
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundView = vStack;
        self.separatorStyle = .none;
        
        NSLayoutConstraint.activate([
            vStack.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            vStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            vStack.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40)])
    }
    
    func restore() {
        self.backgroundView = nil
    }
    
    public func numberOfRows() -> Int {
        var section = 2
        var rowCount = 0
        while section < numberOfSections {
            rowCount += numberOfRows(inSection: section)
            section += 1
        }
        return rowCount
    }
}

extension UIButton {
    private func actionHandler(action:(() -> Void)? = nil) {
        struct __ { static var action :(() -> Void)? }
        if action != nil { __.action = action }
        else { __.action?() }
    }
    @objc private func triggerActionHandler() {
        self.actionHandler()
    }
    func actionHandler(controlEvents control :UIControl.Event, ForAction action:@escaping () -> Void) {
        self.actionHandler(action: action)
        self.addTarget(self, action: #selector(triggerActionHandler), for: control)
    }
}
