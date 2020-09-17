//: ## High Shelf Filter
//:

import AudioKit

let file = try AVAudioFile(readFileName: playgroundAudioFiles[0])

let player = try AudioPlayer(file: file)
player.looping = true

var filter = HighShelfFilter(player)
filter.cutoffFrequency = 10_000 // Hz
filter.gain = 0 // dB

engine.output = filter
try engine.start()
player.play()

//: User Interface Set up
import AudioKitUI

class LiveView: View {

    override func viewDidLoad() {
        addTitle("High Shelf Filter")

        addView(Button(title: "Stop") { button in
            filter.isStarted ? filter.stop() : filter.play()
            button.title = filter.isStarted ? "Stop" : "Start"
        })

        addView(Slider(property: "Cutoff Frequency",
                         value: filter.cutoffFrequency,
                         range: 20 ... 22_050,
                         format: "%0.1f Hz"
        ) { sliderValue in
            filter.cutoffFrequency = sliderValue
        })

        addView(Slider(property: "Gain",
                         value: filter.gain,
                         range: -40 ... 40,
                         format: "%0.1f dB"
        ) { sliderValue in
            filter.gain = sliderValue
        })
    }
}

import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = LiveView()
