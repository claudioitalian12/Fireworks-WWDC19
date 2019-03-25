//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  Provides supporting functions for setting up a live view.
//

import UIKit
import AVFoundation
import PlaygroundSupport

public class LiveViewController_1_3: LiveViewController {
    var captureSession: AVCaptureSession?
    var videoLayer: AVCaptureVideoPreviewLayer?
    let emitterLayer = CAEmitterLayer()
    var baseCell = CAEmitterCell()
    let particleImage = UIImage(named: "particle")?.cgImage
    public override func viewDidLoad() {
        super.viewDidLoad()
         makeBaseCell()
         makeSessionConfig()
         setupLayer()
         fireworks()
    }
    override public func willAnimateRotation(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
         oriented(to: toInterfaceOrientation)
    }
    override public func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        captureSession?.stopRunning()
    }
    public override func viewWillLayoutSubviews() {
        videoLayer?.frame = self.view.bounds
        emitterLayer.position = CGPoint(x: view.bounds.center.x, y: view.bounds.center.y * 2)
    }
    override public func receive(_ message: PlaygroundValue) {
        guard case .data(let messageData) = message else { return }
        do { if let colorFireworks = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(messageData) as? UIColor {
            emitterLayer.emitterCells?.removeAll()
            emitterLayer.removeFromSuperlayer()
            
            baseCell.color = colorFireworks.cgColor
            self.setupLayer()
            self.fireworks()
            
            }
        } catch _ { fatalError("error") }
    }
    func oriented(to toInterfaceOrientation: UIInterfaceOrientation) {
            if (toInterfaceOrientation == .landscapeLeft) {
                videoLayer?.transform = CATransform3DMakeRotation(CGFloat(Double.pi)*0.5, 0, 0, 1)
            } else if (toInterfaceOrientation == .landscapeRight) {
                videoLayer?.transform = CATransform3DMakeRotation(-CGFloat(Double.pi)*0.5, 0, 0, 1)
            } else if (toInterfaceOrientation == .portrait) {
                videoLayer?.transform = CATransform3DMakeRotation(0, 0, 0, 1)
            }
             else if (toInterfaceOrientation == .portraitUpsideDown) {
                 videoLayer?.transform = CATransform3DMakeRotation(0, 0, 0, -1)
            }
        videoLayer?.frame = self.view.frame
    }
    func setupLayer()
    {
        emitterLayer.position = CGPoint(x: view.bounds.center.x, y: view.bounds.center.y * 2)
        emitterLayer.renderMode = CAEmitterLayerRenderMode.additive
        emitterLayer.emitterMode = .volume
        emitterLayer.emitterShape = .rectangle
        view.layer.addSublayer(emitterLayer)
    }
    func makeSessionConfig(){
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
        } catch {
            print(error)
        }
        videoLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        videoLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoLayer?.frame = view.layer.bounds
        oriented(to: self.preferredInterfaceOrientationForPresentation)
        view.layer.addSublayer(videoLayer!)
        captureSession?.startRunning()
    }
    func fireworks() {
        let firework: CAEmitterCell = makeFirework()
        let scia: CAEmitterCell = makeScia()
        baseCell.emitterCells = [scia,firework]
        emitterLayer.position = CGPoint(x: view.bounds.center.x, y: view.bounds.center.y * 2)
        emitterLayer.emitterCells = [baseCell]
        emitterLayer.fillMode = .removed
    }
    func makeBaseCell(){
        baseCell.color = UIColor.purple.cgColor
        baseCell.redRange   = 0.5
        baseCell.greenRange = 0.5
        baseCell.blueRange  = 0.5
        baseCell.alphaRange = 0.5
        baseCell.emissionLongitude = -CGFloat.pi * 0.5
        baseCell.emissionRange = CGFloat.pi * 0.2
        baseCell.emissionLatitude = 0.0
        baseCell.lifetime = 2.0
        baseCell.birthRate = 1.0
        baseCell.velocity = 400.0
        baseCell.velocityRange = 50.0
        baseCell.yAcceleration = 300.0
    }
    func makeScia()-> CAEmitterCell {
        let scia = CAEmitterCell()
        scia.contents = particleImage
        scia.emissionLongitude = CGFloat((4*Double.pi)*0.5)
        scia.scale = 0.4
        scia.velocity = 100
        scia.birthRate = 45.0
        scia.alphaSpeed = -0.7
        scia.lifetime = 1.5
        scia.yAcceleration = 350
        scia.emissionRange = CGFloat(Double.pi*0.15)
        scia.scaleSpeed = -0.1
        scia.scaleRange = 0.1
        scia.beginTime = 0.01
        scia.duration = 0.7
        return scia
    }
    func makeFirework() -> CAEmitterCell {
        let firework = CAEmitterCell()
        firework.contents = particleImage
        firework.birthRate = 8787
        firework.velocity = 130
        firework.lifetime = 2.0
        firework.alphaSpeed = -0.2
        firework.yAcceleration = -80
        firework.scale = 0.6
        firework.emissionRange = CGFloat(2*Double.pi)
        firework.beginTime = 1.5
        firework.duration = 0.1
        firework.scaleSpeed = -0.1
        firework.spin = 2.0
        return firework
    }
}
