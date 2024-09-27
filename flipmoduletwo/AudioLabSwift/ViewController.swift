//
//  ViewController.swift
//  AudioLabSwift
//
//  Created by Eric Larson 
//  Copyright © 2020 Eric Larson. All rights reserved.
//

import UIKit
import Metal

let WINDOW_COUNT = 20
let AUDIO_BUFFER_SIZE = 1024*4

class ViewController: UIViewController {
 
    var timer: Timer?
    
    let audio = AudioModel(buffer_size: AUDIO_BUFFER_SIZE, window_count: WINDOW_COUNT)
    lazy var graph:MetalGraph? = {
        return MetalGraph(mainView: self.view)
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // add in graphs for display
        graph?.addGraph(withName: "fft",
                        shouldNormalize: true,
                        numPointsInGraph: AUDIO_BUFFER_SIZE/2)
        
        graph?.addGraph(withName: "time",
            shouldNormalize: false,
            numPointsInGraph: AUDIO_BUFFER_SIZE)
        
        graph?.addGraph(withName: "fft_window",
                        shouldNormalize: true,
                        numPointsInGraph: WINDOW_COUNT)
        
        // just start up the audio model here
        //audio.startMicrophoneProcessing(withFps: 10)
        audio.startProcesingAudioFileForPlayback(withFps: 10)
        //audio.startProcessingSinewaveForPlayback(withFreq: 630.0)
        audio.play()
        
        // run the loop for updating the graph peridocially
        Timer.scheduledTimer(timeInterval: 0.05, target: self,
            selector: #selector(self.updateGraph),
            userInfo: nil,
            repeats: true)
       
    }
    // This method is called whenever the view needs to lay out its subviews, including during rotation
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Check the current orientation
        let orientation = UIDevice.current.orientation
        
        // Get the new screen dimensions
        let screenWidth = view.bounds.width
        let screenHeight = view.bounds.height
        let controlHeight: CGFloat = 100  // Space for controls
        
        // Adjust the Metal graph layout based on orientation
        if orientation.isLandscape {
            // In landscape mode, you might want a different layout
            graph?.metalLayer.frame = CGRect(x: 0, y: controlHeight, width: screenWidth, height: screenHeight - controlHeight)
        } else if orientation.isPortrait {
            // In portrait mode, take full width but adjust height
            graph?.metalLayer.frame = CGRect(x: 0, y: controlHeight, width: screenWidth, height: screenHeight - controlHeight)
        } else {
            // Default layout (fallback for unknown or flat orientation)
            graph?.metalLayer.frame = CGRect(x: 0, y: controlHeight, width: screenWidth, height: screenHeight - controlHeight)
        }
        
        // Optional: Re-render the graph if you need to handle changes in graph resolution or content
        graph?.render()
    }
    // Added To Stop Audio Manager When Sceen Looses Focus
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        
        audio.stop()
    }
    
    
    @objc
    func updateGraph(){
        self.graph?.updateGraph(
            data: self.audio.fftData,
            forKey: "fft"
        )
      
        self.graph?.updateGraph(
            data: self.audio.timeData,
            forKey: "time"
        )
        
        self.graph?.updateGraph(
            data: self.audio.windowedData,
            forKey: "fft_window"
        )
      
    }
    
    

}

