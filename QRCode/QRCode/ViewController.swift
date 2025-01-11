//
//  ViewController.swift
//  QRCode
//
//  Created by MacV on 24/07/23.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {
    
    var avCaptureSession: AVCaptureSession!
    var avPreviewLayer: AVCaptureVideoPreviewLayer!
    var qrCodeFrameView: UIView?
    var qrimageView: UIImageView?
    var player: AVPlayer!
     var avpController = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avCaptureSession = AVCaptureSession()
        qrCodeFrameView = UIView()
        qrimageView = UIImageView()
       // DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
           
            guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
                self.failed()
                return
            }
            let avVideoInput: AVCaptureDeviceInput
            
            do {
                avVideoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            } catch {
                self.failed()
                return
            }
            
            if (self.avCaptureSession.canAddInput(avVideoInput)) {
                self.avCaptureSession.addInput(avVideoInput)
            } else {
                self.failed()
                return
            }
            
            let metadataOutput = AVCaptureMetadataOutput()
            
            if (self.avCaptureSession.canAddOutput(metadataOutput)) {
                self.avCaptureSession.addOutput(metadataOutput)
                
                metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417, .qr]
            } else {
                self.failed()
                return
            }
            
        self.avPreviewLayer = AVCaptureVideoPreviewLayer(session: self.avCaptureSession)
        self.avPreviewLayer.frame = self.view.layer.bounds
        self.avPreviewLayer.videoGravity = .resizeAspectFill
        self.view.layer.addSublayer(self.avPreviewLayer)
        self.avCaptureSession.startRunning()
        
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            qrCodeFrameView.layer.borderWidth = 2
            view.addSubview(qrCodeFrameView)
            view.bringSubviewToFront(qrCodeFrameView)
            
        }
        if let qrimageView = qrimageView{
            qrCodeFrameView?.addSubview(qrimageView)
            
        }
     //   }
        let moviePath = Bundle.main.path(forResource: "video", ofType: "mp4")
            if let path = moviePath {
                let url = NSURL.fileURL(withPath: path)
                self.player = AVPlayer(url: url)
                self.avpController = AVPlayerViewController()
                self.avpController.player = self.player
                
                self.addChild(avpController)
               // self.qrCodeFrameView?.addSubview(avpController.view)
            }
        
    }
    
    
    func failed() {
        let ac = UIAlertController(title: "Scanner not supported", message: "Please use a device with a camera. Because this device does not support scanning a code", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        avCaptureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       /* if (avCaptureSession?.isRunning == false) {
            avCaptureSession.startRunning()
        }*/
    }
    override func viewDidAppear(_ animated: Bool) {
        if (avCaptureSession?.isRunning == false) {
            DispatchQueue.main.async {
                self.avCaptureSession.startRunning()
            }
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (avCaptureSession?.isRunning == true) {
            avCaptureSession.stopRunning()
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
}
extension ViewController : AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        /*avCaptureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }*/
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            qrimageView?.frame = CGRect.zero
            self.avpController.view.frame = CGRect.zero
            //found(code: "No QR code is detected")
                return
            }

            // Get the metadata object.
            let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject

            if metadataObj.type == AVMetadataObject.ObjectType.qr {
                // If the found metadata is equal to the QR code metadata then update the status
                let barCodeObject = avPreviewLayer?.transformedMetadataObject(for: metadataObj)
                qrCodeFrameView?.frame = barCodeObject?.bounds ?? CGRect(x: 0, y: 0, width: 200, height: 200)

                if metadataObj.stringValue != nil {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.qrimageView?.frame = self.qrCodeFrameView?.bounds ?? CGRect(x: 0, y: 0, width: 200, height: 200)
                        self.qrimageView?.image = UIImage(named: "nature")
                        //self.avpController.view.frame =  self.qrCodeFrameView?.bounds ?? CGRect(x: 0, y: 0, width: 200, height: 200)
                        //self.player.play()
                    }
                   // found(code: metadataObj.stringValue ?? "")
                }
            }
        
       // dismiss(animated: true)
    }
    
    func found(code: String) {
        print(code)
        let alert = UIAlertController(title: "QR Code Info", message: code, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            DispatchQueue.main.async {
                self.avCaptureSession.startRunning()
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
