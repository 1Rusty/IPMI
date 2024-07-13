PImage img;
int imgWidth = 400, imgHeight = 400;

// propiedades numeros
int numCircles = 23; // Cantidad
float maxDiameter = 22, minDiameter = maxDiameter / numCircles; // Tamaño
float[][] circleSizes = new float[numCircles][numCircles];
color[][] circleColors = new color[numCircles][numCircles];
float interactionRadius = 300; // Radio de interacción del cursor
boolean restartRequested = false; // Flag que indica si se requiere reiniciar el codigo

void setup() {
  size(800, 400);
  background(50);
  
  img = loadImage("F_17.jpg"); // Imagen

  // dibujar circulos, y sus propiedades
  for (int j = 0; j < numCircles; j++) {
    for (int i = 0; i < numCircles; i++) {
      circleSizes[j][i] = map(i, 0, numCircles - 1, maxDiameter, minDiameter); // Asigna tamaño
      circleColors[j][i] = color(255); // Todos los circulos son blancos
    }
  }
}

void draw() {
  background(20);
  
  float centerX = 600, centerY = 200; // Centrar círculos pantalla 2
  image(img, 0, 0); // carga imagen
  
  // Variable tamaño circ. cursor (Agranda los circulos dependiendo de donde se encuentre el cu)
  for (int j = 0; j < numCircles; j++) {
    for (int i = 0; i < numCircles; i++) {
      float posX = centerX + (i - numCircles/2) * (maxDiameter + 5); // Agrandar X
      float posY = centerY + (j - numCircles/2) * (maxDiameter + 5); // Agrandar Y
      
     // Arreglo ajustar perimetro de dibujado
      float distanceImgX = abs(posX - imgWidth / 2.2); 
      float distanceImgY = abs(posY - imgHeight / 2); 
      
      // Verificar si circulo esta dentro de img
      if (distanceImgX < imgWidth / 2 && distanceImgY < imgHeight / 2) {
        circleSizes[j][i] = minDiameter; // Establece min. si img = si
      } else {
        float distance = calculateDistance(mouseX, mouseY, posX, posY); // Calcular distancia del cursor al circulo
        float maxSize = maxDiameter;
        // Ajustar el tamaño del circulo segun distancia del cursor (Zona de interaccion)
        float newSize = maxSize - map(constrain(distance, 0, interactionRadius), 0, interactionRadius, 0, maxSize - minDiameter);
        circleSizes[j][i] = newSize;
      }
      
      noStroke();
      fill(circleColors[j][i]);
      ellipse(posX, posY, circleSizes[j][i], circleSizes[j][i]); 
    }
  }

  // Dibujar el texto centrado
  textAlign(CENTER, CENTER);
  textSize(24);
  fill(255, 0, 0);
  text("PRESIONAR BARRA ESPACIADORA\nPARA REINICIAR", 600, 50);
  
}
float calculateDistance(float x1, float y1, float x2, float y2) {
  float dx = x2 - x1;
  float dy = y2 - y1;
  return sqrt(dx * dx + dy * dy);
}

void mousePressed() {   //cambia el color de los circulos cada que se haga click
  // Random color de X=(50) círculos
  for (int k = 0; k < 50; k++) {
    int randomRow = int(random(numCircles));
    int randomCol = int(random(numCircles));
    circleColors[randomRow][randomCol] = color(random(255), random(255), random(255));
  }
}

void keyPressed() {
  // Reiniciar los colores de circulos al presionar espacio
  if (key == ' ') {
    restartColors(); //abajo
  }
}

// restartColors
void restartColors() {
  for (int j = 0; j < numCircles; j++) {
    for (int i = 0; i < numCircles; i++) {
      circleColors[j][i] = color(255);
    }
  }
}
