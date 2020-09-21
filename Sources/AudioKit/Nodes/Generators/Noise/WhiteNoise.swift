// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/
// This file was auto-autogenerated by scripts and templates at http://github.com/AudioKit/AudioKitDevTools/

import AVFoundation
import CAudioKit

/// White noise generator
public class WhiteNoise: Node, AudioUnitContainer, Toggleable {

    public static let ComponentDescription = AudioComponentDescription(generator: "wnoz")

    public typealias AudioUnitType = InternalAU

    public private(set) var internalAU: AudioUnitType?

    // MARK: - Parameters

    public static let amplitudeDef = NodeParameterDef(
        identifier: "amplitude",
        name: "Amplitude",
        address: akGetParameterAddress("WhiteNoiseParameterAmplitude"),
        range: 0.0 ... 1.0,
        unit: .generic,
        flags: .default)

    /// Amplitude. (Value between 0-1).
    @Parameter public var amplitude: AUValue

    // MARK: - Audio Unit

    public class InternalAU: AudioUnitBase {

        public override func getParameterDefs() -> [NodeParameterDef] {
            [WhiteNoise.amplitudeDef]
        }

        public override func createDSP() -> DSPRef {
            akCreateDSP("WhiteNoiseDSP")
        }
    }

    // MARK: - Initialization

    /// Initialize this noise node
    ///
    /// - Parameters:
    ///   - amplitude: Amplitude. (Value between 0-1).
    ///
    public init(
        amplitude: AUValue = 1
    ) {
        super.init(avAudioNode: AVAudioNode())

        instantiateAudioUnit { avAudioUnit in
            self.avAudioUnit = avAudioUnit
            self.avAudioNode = avAudioUnit

            guard let audioUnit = avAudioUnit.auAudioUnit as? AudioUnitType else {
                fatalError("Couldn't create audio unit")
            }
            self.internalAU = audioUnit
            self.stop()

            self.amplitude = amplitude
        }

    }
}
