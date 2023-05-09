//
//  UIView+Constraints.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 8.05.23.
//

import UIKit

extension UIView {
    @discardableResult func autoLayout() -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func constraintToSuperView(constant: CGFloat = 0) {
        guard let superview else { return }
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: constant),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -constant)
        ])
    }
}
