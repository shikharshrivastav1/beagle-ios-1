//
//  Picker+Extensions.swift
//
//
//  Created by Shikhar Shrivastav on 18/02/22.
//

import UIKit

extension Picker {
    
    public func toView(renderer: BeagleRenderer) -> UIView {
        let picker = BeagleUIPicker()
        picker.dataSource = picker
        picker.delegate = picker
        picker.translatesAutoresizingMaskIntoConstraints = false
        if let styleId = styleId {
            picker.beagle.applyStyle(for: picker as UIPickerView, styleId: styleId, with: renderer.controller)
        }
        renderer.observe(entries, andUpdateManyIn: picker) {
            picker.items = $0
            picker.reloadAllComponents()
        }
        return AutoLayoutWrapper(view: picker)
    }
    
    final class BeagleUIPicker: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
        
        var items: [String]? = nil
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            if component == 0 {
                return items?.count ?? 0
            }
            return 0
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if let total = items?.count, total > row {
                return items?[row] ?? ""
            }
            return ""
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            controller?.execute(actions: onSelected, event: "onSelected", origin: self)
        }
        
    }
}
