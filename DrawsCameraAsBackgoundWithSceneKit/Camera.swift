//
//  Camera.swift
//  DrawsCameraAsBackgoundWithSceneKit
//
//  Created by Artem Sherbachuk (UKRAINE) on 10/5/16.
//  Copyright © 2016 Judson Douglas. All rights reserved.
//

import UIKit
import AVFoundation

final class Camera: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    let captureSession = AVCaptureSession()
    private let queue = DispatchQueue(label: "queuename", attributes: .concurrent)
    typealias ImageCompletion = (UIImage) -> Void
    private let completion: ImageCompletion
    
    init(imageCompletion: @escaping ImageCompletion) {
        self.completion = imageCompletion
        super.init()
        if let videoDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo) {
            do {
                let videoIn = try AVCaptureDeviceInput(device: videoDevice)
                if (captureSession.canAddInput(videoIn)){
                    captureSession.addInput(videoIn)
                }
                let output = AVCaptureVideoDataOutput()
                if captureSession.canAddOutput(output) {
                    captureSession.addOutput(output)
                }
                output.setSampleBufferDelegate(self, queue: queue)
            } catch {
                print("AVCaptureDeviceInput error \(error)")
            }
            captureSession.startRunning()
        } else {
            fatalError("No camera found on device!.")
        }
    }
    
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        self.completion(sampleBuffer.image)
    }
}


extension CMSampleBuffer {
    var image: UIImage {
        let image = UIImageFromCMSamleBuffer(buffer: self)
        return image
    }
    private func UIImageFromCMSamleBuffer(buffer:CMSampleBuffer)-> UIImage {
        let pixelBuffer:CVImageBuffer = CMSampleBufferGetImageBuffer(buffer)!
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        
        let pixelBufferWidth = CGFloat(CVPixelBufferGetWidth(pixelBuffer))
        let pixelBufferHeight = CGFloat(CVPixelBufferGetHeight(pixelBuffer))
        let imageRect:CGRect = CGRect(x:0,y:0,width:pixelBufferWidth, height:pixelBufferHeight)
        let ciContext = CIContext.init()
        let cgimage = ciContext.createCGImage(ciImage, from: imageRect )
        let image = UIImage(cgImage: cgimage!)
        let resisedImage = resizeImage(image: image, newWidth: 500)
        //print("resized image from camera \(resisedImage)")
        return resisedImage
    }
    private func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width:newWidth, height:newHeight))
        image.draw(in: CGRect(x:0, y:0, width:newWidth, height:newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}
