//https://github.com/CodingTrain/Coding-Challenges/blob/main/011_PerlinNoiseTerrain/Processing/CC_011_PerlinNoiseTerrain/CC_011_PerlinNoiseTerrain.pde

import ddf.minim.*;

Minim minim;
AudioHandler audioHandler;
int cols, rows;
int scl = 20;
int w = 2000;
int h = 1600;

float flying = 0;

float[][] terrain;

void setup() {
  size(600, 600, P3D);
  minim = new Minim(this);
  cols = w / scl;
  rows = h / scl;
  terrain = new float[cols][rows];
  audioHandler = new AudioHandler(this); // Instantiate the AudioHandler with a reference to this sketch
}

void draw() {
  flying -= 0.1;
  float amplitude = audioHandler.getAmplitude(); // Get the amplitude once at the start of draw()

  // Output to console if there's significant amplitude
  if (amplitude > 0.01) { // Threshold value
    println("Voice input detected with amplitude: " + amplitude);
  }

  float yoff = flying;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100);
      xoff += 0.2;
    }
    yoff += 0.2;
  }

  background(0);
  stroke(255);
  noFill();

  translate(width / 2, height / 2 + 50);
  rotateX(PI / 3);
  translate(-w / 2, -h / 2);
  for (int y = 0; y < rows - 1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      float terrainHeight = terrain[x][y] + amplitude * 1000; // Use the amplitude variable
      vertex(x * scl, y * scl, terrainHeight);
      vertex(x * scl, (y + 1) * scl, terrain[x][y + 1] + amplitude * 1000);
    }
    endShape();
  }

  // Visual feedback for audio amplitude
  float volumeLevel = amplitude * 1000; // Use the amplitude variable
  fill(255, 0, 0);
  noStroke();
  rect(0, height - volumeLevel, 50, volumeLevel); // Draw a red rectangle at the bottom based on volume
}

void stop() {
  // Properly close the audio input and Minim before exiting
  audioHandler.stop();
  super.stop();
}
