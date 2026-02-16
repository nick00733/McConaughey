//
//  ContentView.swift
//  McConaughey
//
//  Created by Nick Nedjat on 16.02.26.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    
    @State private var audioPlayer: AVAudioPlayer!
    @State private var stepperValue: Int = 1
    
    var body: some View {
        VStack {
            Text("How is Matt?")
                .font(.largeTitle)
                .fontWeight(.black)
            Image("matt")
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 30)) //NICHT: .cornerRadius(30)
                .shadow(radius: 30)
            
            Spacer()
            
            Stepper("How is Matt?", value: $stepperValue, in: 1...10)
                .font(.title2)
            
            Text("\(stepperValue)")
                .font(.largeTitle)
            
            Spacer()
            
            Button("Tell Me!") {
                playSound(soundName: "alright")
            }
            .font(.headline)
            .foregroundColor(.white)
            .buttonStyle(.glassProminent)
            .background(Color.blue)
            .clipShape(Capsule())
                    }
        .padding()
    }
    
    func playSound(soundName: String) {
        if audioPlayer != nil && audioPlayer.isPlaying {
            audioPlayer.stop()
        }

        guard let soundFile = NSDataAsset(name: soundName) else {
            print("😡 Could not read file named \(soundName)")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.numberOfLoops = stepperValue-1
            audioPlayer.play()
        } catch {
            print("😡 ERROR: \(error.localizedDescription) creating audioPlayer")
        }
    }
}

#Preview {
    ContentView()
}
