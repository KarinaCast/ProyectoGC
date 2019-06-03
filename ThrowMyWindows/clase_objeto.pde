class Objeto {
  
  PVector coord;
  PVector tam;
  PVector vel;
  PVector gravedad;
  PImage imagen_icono;

  Objeto(float x, float y, float w) {
    coord = new PVector(x, y);
    tam = new PVector(w,w);
    imagen_icono = loadImage(nombrePNG());
    //Controla la curva
    vel = new PVector(4.25,-7.36);
    //Controla la gravedad
    gravedad = new PVector(0.1,0.3);    
  }
  
   void colision(int boteX, int boteY, int boteW, int boteH) {
    vel.y = vel.y + gravedad.y;
    vel.x = vel.x + gravedad.x; 
    coord.y = coord.y + vel.y;
    coord.x = coord.x + vel.x;
    
    if (coord.x + tam.x + vel.x > boteX &&
        coord.x + vel.x < boteX + boteW &&
        coord.y + tam.y > boteY &&
        coord.y < boteY + boteH) {    
        //Rebota
        vel.x = vel.x * - 1;
    }
    
    else if (coord.x + tam.x > 0 &&
       coord.x < 0 + 600 &&
       coord.y + tam.y + vel.y > height &&
       coord.y + vel.y < height - 20){
        vel.y = vel.y * - 1;
    }
    
  }
  
  void draw() {
    pushMatrix();
      image(imagen_icono,coord.x,coord.y,tam.x,tam.y);    
    popMatrix();
  }
} 
