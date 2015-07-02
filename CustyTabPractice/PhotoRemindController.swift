//
//  PhotoRemindController.swift
//  CustyTabPractice
//
//  Created by Kathryn Manning on 6/29/15.
//  Copyright (c) 2015 kathrynmanning. All rights reserved.
//

import UIKit
import AVFoundation

class PhotoRemindController: UIViewController {

    @IBOutlet weak var previewView: UIView!
    
    var captureSession : AVCaptureSession?
    var stillImageOutput : AVCaptureStillImageOutput?
    var previewLayer : AVCaptureVideoPreviewLayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        // configure a session
        captureSession = AVCaptureSession()
        // sessionPreset determines resolution - high resolution
        captureSession!.sessionPreset = AVCaptureSessionPresetPhoto
        
        // select a device to use - the back camera is teh default
        var backCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        // prepare to accept input on this ^ device
        var error : NSError?
        // associate the device with a capture session
        var input = AVCaptureDeviceInput(device: backCamera, error: &error)
        // associate the input with the capture session
        
        if error == nil && captureSession!.canAddInput(input)
        {
            captureSession!.addInput(input)
            
            stillImageOutput = AVCaptureStillImageOutput()
            stillImageOutput!.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
            
            if captureSession!.canAddOutput(stillImageOutput)
            {
                captureSession!.addOutput(stillImageOutput)
                
                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                previewLayer!.videoGravity = AVLayerVideoGravityResizeAspectFill
                //want rounded corners?
                //previewLayer!.cornerRadius = 7.0
                previewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.Portrait
                previewView.layer.addSublayer(previewLayer)
                
                captureSession!.startRunning()
            }
            
        }
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // set the bounds of the videopreviewlayer to match bounds of the containing view
        previewLayer!.frame = previewView.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didPressTakePhoto(sender: AnyObject) {
        
        // get the first connection in the array of connections on the stillImageOutput
        if let videoConnection = stillImageOutput!.connectionWithMediaType(AVMediaTypeVideo)
        {
            videoConnection.videoOrientation = AVCaptureVideoOrientation.Portrait
            stillImageOutput?.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: {(sampleBuffer, error) in
                if (sampleBuffer != nil) {
                    var imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                    var dataProvider = CGDataProviderCreateWithCFData(imageData)
                    var cgImageRef = CGImageCreateWithJPEGDataProvider(dataProvider, nil, true, kCGRenderingIntentDefault)
                    
                    var image = UIImage(CGImage: cgImageRef, scale: 1.0, orientation: UIImageOrientation.Right)
                    //self.capturedImage.image = image
                    
                    //now can store image into the database
                }
            })
        }
        
    }

}
