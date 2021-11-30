//
//  SpeechRecognizer.swift
//  PlanetariumApplication
//
//  Created by Tiitus Telke on 26.11.2021.
//  Created using https://developer.apple.com/tutorials/app-dev-training/transcribing-speech-to-text
//

import AVFoundation
import Foundation
import Speech
import SwiftUI

struct SpeechRecognizer {
    private class SpeechAssist {
        var audioEngine: AVAudioEngine?
        var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
        var recognitionTask: SFSpeechRecognitionTask?
        let speechRecognizer = SFSpeechRecognizer()
        var timer: Timer?
        
        deinit {
            reset()
        }
        
        func reset() {
            recognitionTask?.cancel()
            audioEngine?.stop()
            audioEngine = nil
            recognitionRequest = nil
            recognitionTask = nil
            timer = nil
        }
    }
    
    private let assistant = SpeechAssist()
    
    @Binding var clr: Color
    
    init(clr: Binding<Color>) {
        self._clr = clr
    }
    
    func record(to speech: Binding<String>) {
        relay(speech, message: "Requesting access")
        canAccess { authorized in
            guard authorized else {
                relay(speech, message: "Access denied")
                return
            }
            
            relay(speech, message: "Access granted")
            
            assistant.audioEngine = AVAudioEngine()
            guard let audioEngine = assistant.audioEngine else {
                fatalError("Unable to create audio engine")
            }
            assistant.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
            guard let recognitionRequest = assistant.recognitionRequest else {
                fatalError("Unable to create request")
            }
            recognitionRequest.shouldReportPartialResults = true
            
            do {
                relay(speech, message: "Booting audio subsystem")
                
                let audioSession = AVAudioSession.sharedInstance()
                try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
                try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
                let inputNode = audioEngine.inputNode
                relay(speech, message: "Found input node")
                
                let recordingFormat = inputNode.outputFormat(forBus: 0)
                inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
                    recognitionRequest.append(buffer)
                }
                let beginRecordingId: SystemSoundID = 1113
                relay(speech, message: "Preparing audio engine")
                changeColor($clr, newColor: Color(.red))
                AudioServicesPlaySystemSound(beginRecordingId)
                audioEngine.prepare()
                try audioEngine.start()
                assistant.recognitionTask = assistant.speechRecognizer?.recognitionTask(with: recognitionRequest) { (result, error) in
                    var isFinal = false
                    
                    if let result = result {
                        relay(speech, message: result.bestTranscription.formattedString)
                        isFinal = result.isFinal
                    }
                    
                    if error != nil || isFinal {
                        audioEngine.stop()
                        inputNode.removeTap(onBus: 0)
                        self.assistant.recognitionRequest = nil
                    }
                    else if error == nil {
                        restartSpeechTimer()
                    }
                }
            } catch {
                print("Error transcibing audio: " + error.localizedDescription)
                assistant.reset()
            }
        }
    }
    
    func stopRecording() {
        let endRecordingId: SystemSoundID = 1114
        AudioServicesPlaySystemSound(endRecordingId)
        changeColor($clr, newColor: Color(.blue))
        assistant.reset()
    }
    
    private func canAccess(withHandler handler: @escaping (Bool) -> Void) {
        SFSpeechRecognizer.requestAuthorization { status in
            if status == .authorized {
                AVAudioSession.sharedInstance().requestRecordPermission { authorized in
                    handler(authorized)
                }
            } else {
                handler(false)
            }
        }
    }
    // timer from this stackoverflow answer: https://stackoverflow.com/a/45195741 thank you nuvaryan
    private func restartSpeechTimer() {
        assistant.timer?.invalidate()
        assistant.timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { (timer) in
            stopRecording()
        })
    }
    
    private func relay(_ binding: Binding<String>, message: String) {
        DispatchQueue.main.async {
            binding.wrappedValue = message
        }
    }
    
    private func changeColor(_ binding: Binding<Color>, newColor: Color) {
        DispatchQueue.main.async {
            binding.wrappedValue = newColor
        }
    }
}


