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

class SpeechRecognizer: ObservableObject {
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
    
    @Published private(set) var isRecording: Bool = false
    
    func record(to speech: Binding<String>) {
        canAccess { authorized in
            guard authorized else {
                return
            }
            
            self.assistant.audioEngine = AVAudioEngine()
            guard let audioEngine = self.assistant.audioEngine else {
                fatalError("Unable to create audio engine")
            }
            
            self.assistant.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
            guard let recognitionRequest = self.assistant.recognitionRequest else {
                fatalError("Unable to create request")
            }
            recognitionRequest.shouldReportPartialResults = true
            
            do {
                let audioSession = AVAudioSession.sharedInstance()
                try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
                try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
                let inputNode = audioEngine.inputNode
                
                let recordingFormat = inputNode.outputFormat(forBus: 0)
                inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
                    recognitionRequest.append(buffer)
                }
                
                audioEngine.prepare()
                try audioEngine.start()
                
                let beginRecordingId: SystemSoundID = 1113
                AudioServicesPlaySystemSound(beginRecordingId)
                
                DispatchQueue.main.async {
                    self.isRecording = true
                }
                
                self.assistant.recognitionTask = self.assistant.speechRecognizer?.recognitionTask(with: recognitionRequest) { (result, error) in
                    var isFinal = false
                    
                    if let result = result {
                        self.relay(speech, message: result.bestTranscription.formattedString)
                        isFinal = result.isFinal
                    }
                    
                    if error != nil || isFinal {
                        audioEngine.stop()
                        inputNode.removeTap(onBus: 0)
                        self.assistant.recognitionRequest = nil
                    }
                    
                    if error == nil && !isFinal {
                        self.restartSpeechTimer()
                    }
                }
            } catch {
                print("Error transcibing audio: " + error.localizedDescription)
                self.assistant.reset()
            }
        }
    }
    
    func stopRecording() {
        isRecording = false
        assistant.reset()
        let endRecordingId: SystemSoundID = 1114
        AudioServicesPlaySystemSound(endRecordingId)
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
            self.stopRecording()
        })
    }
    
    private func relay(_ binding: Binding<String>, message: String) {
        DispatchQueue.main.async {
            binding.wrappedValue = message
        }
    }
}
