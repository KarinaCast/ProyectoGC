import ddf.minim.*;
Minim minim;
AudioPlayer inicio_windows, clic, error;

PImage inicio, pantalla_azul, sesion, papelera, windows;
ArrayList<Objeto> iconos;

//Condición de pantalla
int entrada = 0;

//Coordenadas de la Papelera
float x, y;
int rand_x, rand_y;

//Tiempo en que cambia la papelera
float rand_espera;
int tiempo;
int espera = 5000;

//Puntajes
int puntaje, caidas;

//Rotacion icono
float rot = 0;

void setup() {
  size(800, 518);
  inicio = loadImage("fondos/inicio.png");
  sesion = loadImage("fondos/sesion.png");
  pantalla_azul = loadImage("fondos/bluescreen.png");
  papelera = loadImage("iconosXP/papeleraV.png");
  windows = loadImage("iconosXP/windowsLogo.png");
  
  
  minim = new Minim(this);
  inicio_windows = minim.loadFile("sonidos/XPStart.mp3");
  clic = minim.loadFile("sonidos/clic.mp3");
  error = minim.loadFile("sonidos/error.mp3");
  
  iconos = new ArrayList<Objeto>();

  x = random(500, 700);
  rand_x = int(x);  
  y = random(0, 200);
  rand_y = int(y);
  tiempo = millis();
}

void draw() {
  if (entrada == 0){
    background(sesion);
    pushMatrix();
       translate(320,220);
       rotate(rot);
       imageMode(CENTER);
       image(windows,0,0,50,50); 
       rot +=0.03;
    popMatrix();  
  }
    
  else if (entrada == 1){
    background(inicio);
    imageMode(0);
    
    for (int i = iconos.size()-1; i >= 0; i--) { 
      Objeto icono = iconos.get(i);
      icono.colision(rand_x+10, rand_y+10, 70, 70);  
      icono.draw();
      
      //Si entra a la papelera
      if (icono.coord.x > rand_x && icono.coord.x < rand_x + 80
        && icono.coord.y > rand_y && icono.coord.y < rand_y + 10) {
        puntaje++;
        iconos.remove(i);
      }
      
      //Si sale de la pantalla
      else if (icono.coord.x > 800 && icono.coord.y > 518){
        iconos.remove(i);
        caidas++;
      }
      //println(iconos.size());      
    }
    
    //Papelera
    image(papelera, rand_x, rand_y, 80, 80);
    
     
     println(mouseX);
     println(mouseY);
     
    //Random: Cambio de posición de papelera
    if (millis() - tiempo >= espera) {
      x = random(500, 700);
      rand_x = int(x);             
      y = random(0, 200);    
      rand_y = int(y); 
      
      tiempo = millis();
    }
    
    //Si tira 25 íconos, pierde
    if (caidas >= 25) {
      entrada = 2;
      error.rewind();
      error.play();
    }
    
    //Si el puntaje es 0, la papelera está vacía, sino, lleno
    if(puntaje > 0)
      papelera = loadImage("iconosXP/papelera.png");
    
    //Textos
    fill(0);
    textSize(10);
    text("Puntaje: ",615,465);
    text(puntaje,665,465);  
    
    text("Iconos caidos: ",615,480);
    text(caidas,690,480); 

    //Activa paredes
    if (key == 's') paredes();
  }
  
  else if(entrada == 2){
    background(pantalla_azul);
    if(key == 'r'){
      entrada = 0;      
    } 
  }
  
}


void mousePressed() {
  if (entrada == 0) {
    if ((mouseX > 420 && mouseX < 550) && (mouseY > 200 && mouseY < 250)) {
      inicio_windows.rewind();
      inicio_windows.play();
      entrada = 1;
      key = 0;
      reiniciar();
    }
    
    else if ((mouseX > 14 && mouseX < 122) && (mouseY > 470 && mouseY < 495)) {
      exit();
    }
    
  }
  
  if(entrada ==1 ){
    if(mouseX > rand_x && mouseX < rand_x + 80
      && mouseY > rand_y && mouseY < rand_y + 80 ){
        entrada = 2 ;
        error.rewind();
        error.play();
    }
  }
  clic.play();
  clic.rewind();
  iconos.add(new Objeto(mouseX, mouseY, 32));
}

void paredes() {
  fill(255, 0, 0, 200);
  rect(0, height - 20, 600, 20);
  rect(rand_x+10, rand_y+10, 70, 70);
}

void reiniciar(){  
  puntaje = 0;
  caidas = 0;
  tiempo = millis();  
  iconos.clear();
}
