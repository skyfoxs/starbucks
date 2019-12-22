//
//  String+pdf417Barcode.swift
//  Starbucks
//
//  Created by Supakit Thanadittagorn on 19/12/19.
//  Copyright © 2019 pop. All rights reserved.
//

import UIKit

extension String {
    var pdf417Barcode: UIImage? {
        let data = self.data(using: String.Encoding.ascii)

        guard let filter = CIFilter(name: "CIPDF417BarcodeGenerator") else { return nil }
        filter.setValue(data, forKey: "inputMessage")

        let transform = CGAffineTransform(scaleX: 3, y: 3)
        guard let output = filter.outputImage?.transformed(by: transform) else { return nil }
        return UIImage(ciImage: output)
    }
}
