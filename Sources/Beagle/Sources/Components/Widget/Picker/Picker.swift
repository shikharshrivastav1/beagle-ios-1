//
//  Picker.swift
//
//
//  Created by Shikhar Shrivastav on 17/02/22.
//

/// Defines a button natively using the server driven information received through Beagle.
public struct Picker: Widget {
    
    /// Defines the button text content.
    public let text: Expression<String>
    
    public let entries: Expression<[String]>
    
    /// References a native style configured to be applied on this button.
    public var styleId: String?
    
    /// Attribute to define actions when this component is pressed.
    @AutoCodable
    public var onPress: [Action]?
    
    /// Enables or disables the button.
    public var enabled: Expression<Bool>?
    
    public var id: String?
    public var style: Style?
    public var accessibility: Accessibility?
    
}

