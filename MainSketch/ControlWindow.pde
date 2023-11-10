import controlP5.*;
import processing.video.*;

class ControlWindow extends PApplet {
    ControlP5 cp5;
    MainSketch parentSketch;
    Capture cam;
    boolean isRecording = false;
    int frameCount = 0;
    int previewWidth = 320; // Width of the webcam preview
    int previewHeight = 240; // Height of the webcam preview

    ControlWindow(MainSketch parent) {
        parentSketch = parent;
        PApplet.runSketch(new String[]{this.getClass().getSimpleName()}, this);
    }

    public void settings() {
        size(640, 520); // Window size
    }

    public void setup() {
        surface.setTitle("Control Panel");
        cp5 = new ControlP5(this);
        cam = new Capture(this, 640, 480);
        cam.start();
    }

    public void draw() {
        background(200);
        if (cam.available()) {
            cam.read();
        }

        // Calculate the x position to center the preview
        int previewX = (width - previewWidth) / 2;
        int previewY = 10; // A small margin from the top

        // Display the webcam feed at the calculated position
        image(cam, previewX, previewY, previewWidth, previewHeight);

        if (isRecording) {
            if (frameCount < parentSketch.recordedFrames.length) {
                parentSketch.recordedFrames[frameCount] = cam.get();
                frameCount++;
            } else {
                isRecording = false;
                frameCount = 0;
                println("Recording stopped - memory full");
            }
        }

        // Keybinding legend and other UI elements
        fill(0);
        textSize(16);
        text("Keybindings:\n'R' - Start Recording\n'T' - Stop Recording & Play", 20, 500);
    }

    public void keyPressed() {
        if (key == 'r' || key == 'R') {
            isRecording = true;
            frameCount = 0;
            println("Recording started");
        }
        if (key == 't' || key == 'T') {
            isRecording = false;
            parentSketch.startPlayback();
            println("Recording stopped");
        }
    }
}
