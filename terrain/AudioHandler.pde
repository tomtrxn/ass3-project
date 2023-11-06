import ddf.minim.*;
import ddf.minim.analysis.*;

class AudioHandler {
  Minim minim;
  AudioInput in;
  PApplet parent; // Reference to the main sketch

  AudioHandler(PApplet p) {
    parent = p;
    minim = new Minim(parent);
    // Get a stereo mix from the default audio input device
    in = minim.getLineIn(Minim.STEREO);
  }

  // Get the average amplitude from both left and right channels
  float getAmplitude() {
    float sum = 0;
    for (int i = 0; i < in.left.size(); ++i) {
      sum += Math.abs(in.left.get(i)) + Math.abs(in.right.get(i));
    }
    return sum / (in.left.size() * 2);
  }

  void stop() {
    // Close the audio input
    in.close();
    // Always stop Minim before exiting
    minim.stop();
  }
}
