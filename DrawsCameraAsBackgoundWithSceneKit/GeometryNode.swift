//
//  File.swift
//  DrawsCameraAsBackgoundWithSceneKit
//
//  Created by Artem Sherbachuk (UKRAINE) on 10/6/16.
//  Copyright © 2016 Judson Douglas. All rights reserved.
//

import SceneKit


final class GeometryNode: SCNNode {
    
    private var shape: SCNGeometry! {
        didSet {
            geometry = shape
        }
    }
    
    enum Shape: Int {
        case box, plane, sphere, pyramid, cone, cylinder, capsule, tube, torus
    }
    
    init(shape: GeometryNode.Shape) {
        super.init()
        setShape(s: shape)
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")}
    private func setShape(s: GeometryNode.Shape) {
        switch s {
        case .box: self.shape = SCNBox(width: 5, height: 5, length: 5, chamferRadius: 1)
        case .plane: self.shape = SCNPlane(width: 5, height: 5)
        case .sphere: self.shape = SCNSphere(radius: 5)
        case .pyramid: self.shape = SCNPyramid(width: 5, height: 5, length: 5)
        case .cone: self.shape = SCNCone(topRadius: 1, bottomRadius: 5, height: 5)
        case .cylinder: self.shape = SCNCylinder(radius: 5, height: 5)
        case .capsule: self.shape = SCNCapsule(capRadius: 3, height: 5)
        case .tube: self.shape = SCNTube(innerRadius: 3, outerRadius: 5, height: 5)
        case .torus: self.shape = SCNTorus(ringRadius: 5, pipeRadius: 2)
        }
    }
    
    var texture: Any? {
        didSet {
            self.geometry?.firstMaterial?.diffuse.contents = texture
        }
    }
    
    func changeShape(_ shape: GeometryNode.Shape) {
        setShape(s: shape)
    }
}
