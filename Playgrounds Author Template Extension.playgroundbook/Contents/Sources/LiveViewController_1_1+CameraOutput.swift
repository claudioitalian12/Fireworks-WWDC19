//
//  LiveViewController_1_1+CameraOutput.swift
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

import UIKit
import AVFoundation

extension LiveViewController_1_1: AVCaptureVideoDataOutputSampleBufferDelegate{
    public func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        connection.videoOrientation = orientation
        let cameraOutput = AVCaptureVideoDataOutput()
        cameraOutput.setSampleBufferDelegate(self, queue: DispatchQueue.main)
        let sadEffect = filter
        let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        let sadImage = CIImage(cvImageBuffer: pixelBuffer!)
        sadEffect!.setValue(sadImage, forKey: kCIInputImageKey)
        let cgImage = self.context.createCGImage(sadEffect!.outputImage!, from: sadImage.extent)!
        DispatchQueue.main.async {
            let filteredImage = UIImage(cgImage: cgImage)
            self.filteredImage.image = filteredImage
        }
    }
}
