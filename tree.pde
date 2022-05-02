class Tree {
    Node root;

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
                if (n.pos.dist(particles.get(j)) < n.attachDistance) {
                    Node newNode = n.addChild(particles.get(j));
                    newNode.attachDistance = n.attachDistance * 0.8;
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
    float attachDistance = 100;
    ArrayList<Node> children;
    
    Node(PVector pos, Node parent) {
        this.pos = pos;
        this.parent = parent;
        this.children = new ArrayList<Node>();
    }
    
    Node addChild(PVector pos) {
        Node n = new Node(pos, this);
        children.add(n);
        return n;
    }
    
    void draw() {
       fill(255);
       stroke(255);
       ellipse(pos.x, pos.y, RADIUS, RADIUS);        
       for (Node n: this.children) {
           bline(pos, n.pos);
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
