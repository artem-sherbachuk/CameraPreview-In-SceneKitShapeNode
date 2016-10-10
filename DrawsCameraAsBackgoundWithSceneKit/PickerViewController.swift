//
//  PickerViewController.swift
//  DrawsCameraAsBackgoundWithSceneKit
//
//  Created by Artem Sherbachuk (UKRAINE) on 10/6/16.
//  Copyright © 2016 Judson Douglas. All rights reserved.
//

import UIKit

class PickerViewController: NSObject {
    
    typealias ShapeChangedCompletion = (GeometryNode.Shape) -> Void
    fileprivate var completion: ShapeChangedCompletion
    
    init(onShapeChanged: @escaping ShapeChangedCompletion) {
        self.completion = onShapeChanged
        super.init()
    }
    
    fileprivate var shapesNames: [String] {
        return ["box", "plane", "sphere", "pyramid", "cone", "cylinder", "capsule", "tube", "torus"]
    }

}

extension PickerViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return shapesNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedShape = GeometryNode.Shape(rawValue: row)!
        completion(selectedShape)
    }
    
}
extension PickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return shapesNames.count
    }
}
