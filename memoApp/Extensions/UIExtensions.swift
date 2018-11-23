//
//  UIExtensions.swift
//  memoApp
//
//  Created by 伊藤静那(Ito Shizuna) on 2018/11/23.
//  Copyright © 2018年 ShizunaIto. All rights reserved.
//

import UIKit

extension UINavigationBar {
    func withoutUnderline() {
        self.shadowImage = UIImage()
        self.setBackgroundImage(UIImage(), for: .default)
        self.isTranslucent = false
    }
}
