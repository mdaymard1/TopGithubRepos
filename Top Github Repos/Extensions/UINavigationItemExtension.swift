//
//  UINavigationItemExtension.swift
//  Top Github Repos
//
//  Created by Mike Aymard on 6/2/22.
//

import UIKit

extension UINavigationItem {

    /**
     Removes the text from UINavigationBar back button, but keeps the back button icon
     */
    func clearBackButtonText() {
        backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

}
