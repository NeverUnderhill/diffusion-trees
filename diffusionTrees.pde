ArrayList<PVector> particles;
Tree tree;

void setup() {
    size(700, 700);
    frameRate(60);
    background(255);    
    noFill();
    stroke(0);
    generate();
    particles = generateParticles(200);
    tree = new Tree(new PVector(width/2, height/2));
}

void generate() {
}

void draw() {
    for (int i = 0; i < 100; i++) {
        updateParticles(particles, 3);
        tree.attachParticles(particles);
    }
    drawParticles(particles);
    tree.draw();
}

float randomGaussian(float mean, float variance) {
    return mean + randomGaussian() * variance;
}

void keyPressed() {
    if (key == 'r') {
        generate();     
    } else if (key == 's') {
        saveFrame("local/ep######.png");
    }
}