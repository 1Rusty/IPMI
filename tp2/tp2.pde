// Declaración:
int estado;  // para saber en qué pantalla estoy parado
int tiempoAnterior; // guarda el tiempo del intervalo para utilizarlo cuando haya pasado 1 segundo
int intervalo = 1500; // 1.5 segundos 
PImage fotoA, fotoB, fotoC; // declaración de imágenes
boolean mostrarBoton = false;  // no mostrar el botón (hasta que hayan pasado 3 imágenes)
PFont fuente; // variable para la nueva fuente

void setup() {
  size(640, 480);
  estado = 1;
  tiempoAnterior = millis(); // Guarda el tiempo inicial (1.5 segundos cuando haya transcurrido)

  // Cargar imágenes
  fotoA = loadImage("fotoA.png");
  fotoB = loadImage("fotoB.png");
  fotoC = loadImage("fotoC.png");
  
  // Cargar fuente personalizada
  fuente = loadFont("adrippingmarker-48.vlw");
}

void draw() {    
  background(255);

  // Comprobar si ha pasado 1.5 segundos
  if (millis() - tiempoAnterior >= intervalo) {
    estado = estado + 1;
    if (estado > 3) {
      mostrarBoton = true; // habilita el botón
    } else {
      tiempoAnterior = millis();
    }
  }

  if (estado == 1) {
    mostrarPantalla(fotoA, "Obra  1", true, color(255), width / 20, height - 20);
  } else if (estado == 2) {
    mostrarPantalla(fotoB, "Obra  2", true, color(255), width / 20, height - 20);
  } else if (estado == 3) {
    mostrarPantalla(fotoC, "Obra  3", true, color(255), width / 20, height - 20);
  }

  // si ya han pasado 3 pantallas, mostrarBoton es verdadero y dibuja el botón de reiniciar
  if (mostrarBoton) {
    fill(0);
    rect(width / 2 - 50, height - 60, 100, 40);
    fill(255);
    textSize(24);
    textAlign(CENTER, CENTER);
    text("Reiniciar", width / 2, height - 40);
  }
}

void mousePressed() {   // habilita el botón y declara su tamaño y forma
  
  if (mostrarBoton) {
    if (mouseX > width / 2 - 50 && mouseX < width / 2 + 50 &&
        mouseY > height - 60 && mouseY < height - 20) {
      reiniciarPresentacion();
    }
  }
}

void mostrarPantalla(PImage img, String texto, boolean mostrarTexto, color textColor, int x, int y) {
  image(img, 0, 0, width, height);
  if (mostrarTexto) {
    fill(textColor);
    textFont(fuente); // Aplicar la nueva fuente
    textSize(32);
    textAlign(LEFT, BOTTOM);
    text(texto, x, y); // Utiliza las coordenadas especificadas
  }
}

void reiniciarPresentacion() {
  estado = 1;   // vuelve a la pantalla 1 y repite el ciclo
  tiempoAnterior = millis(); // reinicia el contador
  mostrarBoton = false; // desactiva el botón para que no se muestre más
}
