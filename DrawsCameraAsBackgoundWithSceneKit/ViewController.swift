//
//  ViewController.swift
//  DrawsCameraAsBackgoundWithSceneKit
//
//  Created by Judson Douglas on 11/14/14.
//  Copyright (c) 2014 Judson Douglas. All rights reserved.
//

import UIKit
import SceneKit

final class ViewController: UIViewController {

    @IBOutlet weak var sceneView: SCNView!
    @IBOutlet weak var shapePicker: UIPickerView!
    var shapePickerController: PickerViewController!
    
    var camera: Camera!
    let scene = SCNScene()
    let geometry = GeometryNode(shape: GeometryNode.Shape.torus)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
        setupPickerView()
        setupDeviceCamera()
    }
    
    private func setupScene() {
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
        sceneView.delegate = self
        scene.rootNode.addChildNode(geometry)
        sceneView.scene = scene
    }
    private func setupPickerView() {
        shapePickerController = PickerViewController { [unowned self] selectedShape in
            self.geometry.changeShape(selectedShape)
        }
        shapePicker.delegate = shapePickerController
        shapePicker.dataSource = shapePickerController
        
    }
    private func setupDeviceCamera() {
        camera = Camera {[unowned self] realTimeImageFromCamera in
            self.geometry.texture = realTimeImageFromCamera
        }
    }
}

extension ViewController: SCNSceneRendererDelegate {
//    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
//        DispatchQueue.global(qos: .userInitiated).async {
//            self.geometry.firstMaterial?.diffuse.contents = self.imageFromCamera
//        }
//    }
}

