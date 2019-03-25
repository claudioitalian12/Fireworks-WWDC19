//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  Provides supporting functions for setting up a live view.
//

import UIKit
import PlaygroundSupport
import AVFoundation

public class LiveViewController_1_1: LiveViewController {
    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    var photoOutput: AVCapturePhotoOutput?
    var orientation: AVCaptureVideoOrientation = .portrait
    var filter = CIFilter(name: "CIEdges")
    var timerAnimation = Timer()
    let context = CIContext()
    let emitterLayer = CAEmitterLayer()
    let textWors = ["I can’t…","It’s all my fault","I’m tired","I want to be alone","No one cares","I don’t feel like it","I do not know what to do","I don't know what I want to do","I'm useless","everyone is better than me","there is nothing I can do","why am I always wrong?","what's wrong with me","it's all so boring","it never improves anything","nobody understands me","it is so unfair","everyone can do it except me","I don't want to get up","I have no capacity","I can't do anything","I'm not good at anything","I have no creativity","I'm too stupid to work","I'm too stupid to have a future","I would like but I can't","I'm not as good as before","I don't see anything interesting","I have nothing interesting"]
    
    @IBOutlet weak var filteredImage: UIImageView!
    
    @IBOutlet weak var mindLabel: UILabel!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        makeLabel()
        makeGesture()
        oriented(to: self.preferredInterfaceOrientationForPresentation)
        DispatchQueue.main.async {
            self.makeDeviceSetup()
            self.makeInputOutput()
        }
    }
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        autorizzation()
    }
    override public func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        captureSession.stopRunning()
        timerAnimation.invalidate()
    }
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        emitterLayer.emitterPosition = CGPoint(x: view.bounds.width * 0.5, y: -50)
        emitterLayer.emitterSize = CGSize(width: view.bounds.width, height: 0)
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        autorizzation()
    }
    override public func willAnimateRotation(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        oriented(to: toInterfaceOrientation)
    }
    override public func receive(_ message: PlaygroundValue) {
    }
    func makeLabel(){
        mindLabel.alpha = 0.5
        mindLabel.text = "TAP"
        UIView.animate(withDuration: TimeInterval(1), delay: 0, options: [UIView.AnimationOptions.autoreverse,UIView.AnimationOptions.repeat], animations: {
            self.mindLabel.alpha = 0}, completion: nil)
    }
    func makeGesture(){
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGesture)))
    }
    @objc func tapGesture() {
        if(type(of: view.layer.sublayers!.last!) != CAEmitterLayer.self){
            self.mindLabel.layer.removeAllAnimations()
            self.mindLabel.alpha = 0.5
            (0...10).forEach { (_) in
                makeAnimatedView()
            }
            timerAnimation = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
                self.mindLabel.transitionAnimation(0.4)
                self.mindLabel.text = "\"" + self.textWors.randomElement()! + "\""
            }
            timerAnimation.fire()
        }
    }
    func makeAnimatedView() {
        let emitterCell = CAEmitterCell()
        emitterCell.contents = UIImage(named: "face2")!.cgImage
        emitterCell.scale = 0.03
        emitterCell.scaleRange = 0.3
        emitterCell.emissionRange = .pi
        emitterCell.lifetime = 20.0
        emitterCell.birthRate = 4.0
        emitterCell.velocity = -30
        emitterCell.velocityRange = -20
        emitterCell.yAcceleration = 30
        emitterCell.xAcceleration = 5
        emitterCell.spin = -0.5
        emitterCell.spinRange = 1.0
        
        emitterLayer.emitterPosition = CGPoint(x: view.bounds.width  * 0.5, y: -50)
        emitterLayer.emitterSize = CGSize(width: view.bounds.width, height: 0)
        emitterLayer.emitterShape = CAEmitterLayerEmitterShape.line
        emitterLayer.beginTime = CACurrentMediaTime()
        emitterLayer.timeOffset = 10
        emitterLayer.emitterCells = [emitterCell]
        emitterLayer.opacity = 0.8
        view.layer.addSublayer(emitterLayer)
    }
    func autorizzation(){
        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) != .authorized
        {
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler:
                { (authorizedCamera) in
                    DispatchQueue.main.async
                        {
                            if authorizedCamera
                            {
                                self.makeInputOutput()
                            }
                    }
            })
        }
    }
    func makeDeviceSetup() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        let devicesSession = deviceDiscoverySession.devices
        for device in devicesSession {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            }
        }
        currentCamera = backCamera
    }
    func makeInputOutput() {
        do {
            makeFramerate(currentCamera: currentCamera!)
            let captureInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.sessionPreset = AVCaptureSession.Preset.hd1280x720
            if captureSession.canAddInput(captureInput) {
                captureSession.addInput(captureInput)
            }
            let captureOutput = AVCaptureVideoDataOutput()
            captureOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "queueVideo", attributes: []))
            if captureSession.canAddOutput(captureOutput) {
                captureSession.addOutput(captureOutput)
            }
            captureSession.startRunning()
        } catch {
            print(error)
        }
    }
    func oriented(to toInterfaceOrientation: UIInterfaceOrientation){
        if (toInterfaceOrientation == .landscapeLeft) {
            orientation = .landscapeLeft
        } else if (toInterfaceOrientation == .landscapeRight) {
            orientation = .landscapeRight
        } else if (toInterfaceOrientation == .portrait) {
            orientation = .portrait
        }
        else if (toInterfaceOrientation == .portraitUpsideDown) {
            orientation = .portraitUpsideDown
        }
    }
    func makeFramerate(currentCamera: AVCaptureDevice) {
        for format in currentCamera.formats {
            var ranges = format.videoSupportedFrameRateRanges as [AVFrameRateRange]
            let frameRate = ranges[0]
            do {
                if frameRate.maxFrameRate == 240 {
                    try currentCamera.lockForConfiguration()
                    currentCamera.activeFormat = format as AVCaptureDevice.Format
                    currentCamera.activeVideoMinFrameDuration = frameRate.minFrameDuration
                    currentCamera.activeVideoMaxFrameDuration = frameRate.maxFrameDuration
                }
            }
            catch {
                print(error)
            }
        }
    }
}
