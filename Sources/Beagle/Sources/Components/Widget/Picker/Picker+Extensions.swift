//
//  Picker+Extensions.swift
//
//
//  Created by Shikhar Shrivastav on 18/02/22.
//

import UIKit

extension Picker {
    
    public func toView(renderer: BeagleRenderer) -> UIView {
        let picker = BeagleUIPicker(onSelected: onSelected, controller: renderer.controller)
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
        
        var styleId: String? {
            didSet { applyStyle() }
        }
        
        private var onSelected: [Action]?
        private weak var controller: BeagleController?
        
        required init(
            onSelected: [Action]?,
            controller: BeagleController?
        ) {
            super.init(frame: .zero)
            self.onSelected = onSelected
            self.controller = controller
            setDefaultStyle()
        }
        
        @available(*, unavailable)
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
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
            let value: DynamicObject = .dictionary(["value": .string(items?[row] ?? "")])
            controller?.execute(actions: onSelected, with: "onSelected", and: value, origin: self)
        }
        
        private func applyStyle() {
            guard let styleId = styleId else { return }
            beagle.applyStyle(for: self as UIPickerView, styleId: styleId, with: controller)
        }
        
        private func setDefaultStyle() {
            /*setTitleColor(UIColor.systemBlue, for: .normal)
            titleLabel?.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)*/
        }
        
    }
}
