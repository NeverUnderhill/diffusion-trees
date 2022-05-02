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
    tree = new Tree(new PVector(width/2, height * 0.9));
}

void generate() {
}

void draw() {
    for (int i = 0; i < 100; i++) {
        updateParticles(particles, 4);
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

PVector getMidPt(PVector p1, PVector p2) {
    return new PVector((p1.x + p2.x)/2, (p1.y + p2.y)/2);
}

PVector nudgePoint(PVector p, float variance) {
    return new PVector(p.x + randomGaussian(0, variance), p.y + randomGaussian(0, variance));
}

void line(PVector p1, PVector p2) {
    noFill();
    line(p1.x, p1.y, p2.x, p2.y);
}

void bline(PVector p1, PVector p2) {
    noFill();
    float angleVariance = PI/10;
    PVector cp1 = lerp(p1, p2, 0.333);
    float prandom1 =
        -angleVariance +
        ((1 + p1.x) * (1 + p2.y)) % (2 * angleVariance);
    float prandom2 =
        -angleVariance +
        ((1 + p2.x) * (1 + p1.y)) % (2 * angleVariance);
    cp1 = rotate(cp1, p1, prandom2);
    PVector cp2 = lerp(p1, p2, 0.666);
    cp2 = rotate(cp2, p1, prandom1);
    bezier(p1.x, p1.y, cp1.x, cp1.y, cp2.x, cp2.y, p2.x, p2.y);
}

PVector lerp(PVector p1, PVector p2, float r) {
    return new PVector(lerp(p1.x, p2.x, r), lerp(p1.y, p2.y, r));
}

PVector rotate(PVector point, PVector center, float angle) {
    PVector output = new PVector(point.x, point.y);
    output.sub(center);
    output.rotate(angle);
    output.add(center);
    return output;
}
