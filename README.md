<p align="center">
  <img width="200" src="https://github.com/ThaDuyx/Scaile/blob/main/Scaile/Supporting%20Files/Assets.xcassets/ScaileAppStore.imageset/ScaileAppStore.png?raw=true"
</p>

# Scaile
> A iOS project used for creative purposes. The application receives chord progressions in the MIDI format made on a with a python server environment through the LSTM recurrent neural network.
> on mobile device and music with the help of computervision.

 - Developed in Swift

## AAU
Developed for the [Sonic Interaction Design](https://moduler.aau.dk/course/2023-2024/MSNSMCM2201) course.
## Purpose of the project
  - The purpose of the project was to explore how music would be generated with artificial intelligence. In this case MIDI file generation was chosen. The main goal for the project was a creative assistant for musicians or who wants another way of getting out of the infamous phenomenon of creatives called "the writer's block". This means the state of mind where it hard to get in the creative process. 
  
## How To Use
<p align="center">
    <a href="http://www.youtube.com/watch?feature=player_embedded&v=TEudhz0Tdts" target="_blank">
    <img src="http://img.youtube.com/vi/TEudhz0Tdts/mqdefault.jpg" alt="Watch the video" width="400" height="220" border="10" />
    </a>
</p>
  
  - Choose a harmonic scale like D Minor.
  - Generate a chord progression.
  - Play it back through the device.
  - Export the chord progression in MIDI format on your macOS device.
  - Import to your favourite DAW

## Tools

### Software
- xCode

### Frameworks
- AVMIDIPlayer
- FileManager
- SwiftUI
- URLSession

### Backend
- LSTM Neural Network generator: 
https://github.com/ThaDuyx/ScaileAI

### Supporting Files
- MIDI files (.mid)
- Sound Font (.sf2)
