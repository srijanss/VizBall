// An surface boundary

class Surface {
  // We'll keep track of all of the surface points
  ArrayList<Vec2> surface;
  float surface_width;
  float surface_height;
  float xpos;
  int gap;
  Body body;


  Surface(float w, float h, float start_pos, int gaps) {
    surface_width = w;
    surface_height = h;
    xpos = start_pos;
    gap = gaps;
    surface = new ArrayList<Vec2>();

    // This is what box2d uses to put the surface in its world
    ChainShape chain = new ChainShape();

    // This has to go backwards so that the objects  bounce off the top of the surface
    // This "edgechain" will only work in one direction!
    if(surface_width != 0) {
     
      for (float x = surface_width+10; x > start_pos; x -= 5) {
         float y;
        if(gaps != 0){
          if(x > width/2 && x < width/2+100){
            y = -100;
          }  
          else{
            y = surface_height;
          }
        }
        else{
          y = surface_height;
        }
        // Store the vertex in screen coordinates
        surface.add(new Vec2(x,y));
      }
    }
    else {
      for(float y = surface_height; y > start_pos; y -= 5) {
        float x = 0;
        surface.add(new Vec2(x,y));
      }
    }
    
    // Build an array of vertices in Box2D coordinates
    // from the ArrayList we made
    Vec2[] vertices = new Vec2[surface.size()];
    for (int i = 0; i < vertices.length; i++) {
      Vec2 edge = box2d.coordPixelsToWorld(surface.get(i));
      vertices[i] = edge;
    }
    
    // Create the chain!
    chain.createChain(vertices,vertices.length);
    
    // The edge chain is now attached to a body via a fixture
    BodyDef bd = new BodyDef();
    bd.position.set(0.0f,0.0f);
    body = box2d.createBody(bd);
    // Shortcut, we could define a fixture if we
    // want to specify frictions, restitution, etc.
    body.createFixture(chain,1);

  }
  
  void kill(){
    box2d.destroyBody(body);
  }
  

  // A simple function to just draw the edge chain as a series of vertex points
  void display() {
    fill(129, 206, 15);
    if(gap == 0){
    rect(xpos + 10, surface_height, surface_width, 20);
    }
    else{
       rect(xpos + 10, surface_height, surface_width/2, 20);
       rect(surface_width/2+100, surface_height, surface_width/2, 20);
    }
  }

}
