class Tree {
    Node root;
    static final float ATTACH_DISTANCE = 17;

    Tree(PVector rootPos) {
        root = new Node(rootPos, null);
    }
    
    void draw() {
        noStroke();
        root.draw();
    }
    
    ArrayList<Node> getNodes() {
        ArrayList<Node> nodes = new ArrayList<Node>();
        root.pushAllNodes(nodes);
        return nodes;
    }
    
    void attachParticles(ArrayList<PVector> particles) {
        ArrayList<Node> nodes = getNodes();
        for (int j = 0; j < particles.size(); j++) {
            if (particles.get(j) == null) {
                continue;
            }
            for (Node n: nodes) {
                if (n.pos.dist(particles.get(j)) < ATTACH_DISTANCE) {
                    n.addChild(particles.get(j));
                    particles.set(j, null);
                    break;
                }
            }
        }
    }
}

class Node {
    static final float RADIUS = 3;
    PVector pos;
    Node parent;
    ArrayList<Node> children;
    
    Node(PVector pos, Node parent) {
        this.pos = pos;
        this.parent = parent;
        this.children = new ArrayList<Node>();
    }
    
    void addChild(PVector pos) {
        children.add(new Node(pos, this));
    }
    
    void draw() {
       fill(255);
       stroke(255);
       ellipse(pos.x, pos.y, RADIUS, RADIUS);        
       for (Node n: this.children) {
           line(pos.x, pos.y, n.pos.x, n.pos.y);
           n.draw();
       }
    }

    void pushAllNodes(ArrayList<Node> nodeList) {
        if (nodeList == null) {
            nodeList = new ArrayList<Node>();
        }
        nodeList.add(this);
        for (Node n: this.children) {
            n.pushAllNodes(nodeList); 
        }
    }
}
