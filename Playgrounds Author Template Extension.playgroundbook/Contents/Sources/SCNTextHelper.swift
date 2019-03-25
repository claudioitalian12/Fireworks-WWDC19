//
//  SCNTextHelper.swift
//  Book_Sources
//
//  Created by claudio Cavalli on 24/03/2019.
//
//
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  Provides supporting functions for setting up a live view.
//

import ARKit

public class SCNTextHelper: SCNNode {
    public var textRepositioner = SCNNode()
    public var textGeometry: SCNText? = nil
    public var firstMaterial: SCNMaterial? {
        get {
            return self.textGeometry?.firstMaterial
        }
        set {
            self.textGeometry?.firstMaterial = firstMaterial
        }
    }
    var stringText: Any? = nil {
        didSet {
            if let textGeometry = self.textGeometry, let str = self.stringText {
                textGeometry.string = str
                self.setScale()
            }
        }
    }
    public var flatN: CGFloat {
        didSet {
            if let textGeometry = self.textGeometry {
                textGeometry.flatness = self.flatN
            }
        }
    }
    public var textScale: SCNVector3 {
        didSet {
            if self.textGeometry != nil {
                self.setScale()
            }
        }
    }
    public init(text: Any? = nil, font: UIFont? = nil, textScale: Float = 1, flatN: CGFloat = 0.6) {
        let textGeom = SCNText(string: text, extrusionDepth: 0.02)
        let customFont = font ?? UIFont(name: "Kailasa", size: 20)
        textGeom.font = customFont
        textGeom.flatness = flatN
        textGeom.isWrapped = false
        textGeom.firstMaterial?.diffuse.contents = UIColor.clear
        self.textScale = SCNVector3(textScale, textScale, 1)
        self.flatN = flatN
        super.init()
        self.textRepositioner.scale = self.textScale
        self.stringText = text
        self.textGeometry = textGeom
        self.textRepositioner.geometry = textGeom
        self.addChildNode(self.textRepositioner)
        self.setScale()
    }
    public func setScale() {
        if self.stringText == nil {
            return
        }
        self.textGeometry?.isWrapped = false
        self.scale = SCNVector3(1,1,1)
        self.textRepositioner.scale = textScale
        let scale = 1.0 / self.boundingBox.max.x
        self.scale = SCNVector3(scale, scale, 1)
        let rpGeom = self.textRepositioner.boundingBox
        self.textRepositioner.position = SCNVector3(-(rpGeom.max.x + rpGeom.min.x) / 2, -(rpGeom.max.y + rpGeom.min.y) / 2, 0)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

