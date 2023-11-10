import controlP5.*;
import processing.video.*;

PImage[] recordedFrames; // Array to store recorded frames
int frameIndex = 0; // Index for playback
boolean isPlayingBack = false; // Playback state
int frameRate = 30; // Webcam frame rate, adjust as needed
int recordDurationInSeconds = 10; // Desired recording duration in seconds

void setup() {
    size(640, 480);
    // Allocate space for frames based on frame rate and duration
    recordedFrames = new PImage[frameRate * recordDurationInSeconds]; 
    new ControlWindow(this);
}

void draw() {
    if (isPlayingBack && recordedFrames[frameIndex] != null) {
        image(recordedFrames[frameIndex], 0, 0, width, height);
        frameIndex++;
        if (frameIndex >= recordedFrames.length) {
            frameIndex = 0; // Loop back to the start
        }
    }
}

void startPlayback() {
    frameIndex = 0;
    isPlayingBack = true;
}

void stopPlayback() {
    isPlayingBack = false;
}
