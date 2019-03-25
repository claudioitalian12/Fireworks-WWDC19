//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  Provides supporting functions for setting up a live view.
//

import UIKit
import PlaygroundSupport
import ARKit

public class LiveViewController_1_2: LiveViewController {
    var sceneView: ARSCNView!
    let session = ARSession()
    var timer = Timer()
    var skills = ["sociable","educated","careful"]
    public override func viewDidLoad() {
        super.viewDidLoad()
        makeSceneOption()
        makeScene()
        makeLight()
        makeCamera()
        runScene()
    }
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    override public func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        timer.invalidate()
    }
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sceneView.frame = view.bounds
    }
    override public func receive(_ message: PlaygroundValue) {
        guard case .data(let messageData) = message else { return }
        do {
            if let skills = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(messageData) as? [String] {
                removeOldNode()
                generateNode(skills: skills)
                
              }
            else if var colorsSkills = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(messageData) as? [UIColor] {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
                        if node.name == "skills" {
                            (node as! SCNTextHelper).textRepositioner.geometry!.firstMaterial?.diffuse.contents = colorsSkills.first
                            colorsSkills.removeFirst()
                    }
                 }
               }
             }
        }
        catch _ {
        }
    }
    func makeSceneOption(){
        sceneView = ARSCNView(frame: view.bounds)
        sceneView.session = session
        sceneView.delegate = self
        sceneView.session.delegate = self
        sceneView.showsStatistics = false
    }
    func makeScene(){
        let scene = SCNScene()
        sceneView.scene = scene
    }
    func makeLight(){
        let AmbientLight = SCNNode()
        AmbientLight.light = SCNLight()
        AmbientLight.light?.type = .ambient
        AmbientLight.light?.color = UIColor.white
        AmbientLight.light?.intensity = 500
        sceneView.scene.rootNode.addChildNode(AmbientLight)
    }
    func makeCamera(){
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 0)
        sceneView.scene.rootNode.addChildNode(cameraNode)
    }
    func runScene(){
        let configuration = ARWorldTrackingConfiguration()
        self.view.addSubview(sceneView)
        sceneView.session.run(configuration, options: [.removeExistingAnchors])
    }
 
    func removeOldNode(){
     self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
         if node.name == "skills" {
             node.removeFromParentNode()
         }
      }
    }
    func generateNode(skills: [String]){
        for i in skills{
            let myTextNode = SCNTextHelper(text: i)
            myTextNode.name = "skills"
            myTextNode.position = SCNVector3(randomPositionV3(lowerB: -1.5, upperB: +1.0),randomPositionV3(lowerB: -0.3, upperB: +0.5), randomPositionV3(lowerB: -1.6, upperB: -0.3))
            DispatchQueue.main.async {
                self.sceneView.scene.rootNode.addChildNode(myTextNode)
            }
        }
    }
}
extension LiveViewController_1_2: ARSCNViewDelegate, ARSessionDelegate {
    // MARK: - ARSCNViewDelegate
    public func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
     
    }
    public  func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
    }
    public func session(_ session: ARSession, didUpdate frame: ARFrame) {
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            if node.name == "skills" {
                if ( abs((self.sceneView.session.currentFrame?.camera.transform.columns.3.z)! - node.position.z) < 0.08 && (self.sceneView.session.currentFrame?.camera.transform.columns.3.y)! > node.position.y - 0.2 &&  (self.sceneView.session.currentFrame?.camera.transform.columns.3.y)! < node.position.y + 0.2 &&
                    (self.sceneView.session.currentFrame?.camera.transform.columns.3.x)! > node.position.x - (0.2 * 2.5) &&
                    (self.sceneView.session.currentFrame?.camera.transform.columns.3.x)! < node.position.x + (0.2 * 2.5)
                    ) {
                    node.removeFromParentNode()
                }
            }
        }
    }
}
