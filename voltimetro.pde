import processing.serial.*;
PImage bg,on,off;
boolean inpower = false;
Serial myPort;    // Porta serial
String inString;  // String  de entrada da serial
float volt=0;
float x=185,y=0;

void setup(){ //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
size (800,600);
bg = loadImage("case.png");
on = loadImage("on.png");
off = loadImage("off.png");
myPort = new Serial(this, Serial.list()[32], 9600); // configura qual das portas vai ser usada e a velocidade de cominucação
myPort.bufferUntil(10); // tamanho do buffer de entrada da serial
inString = "00000000"; // forca a string de entrada como zero, para nao da erro 
background(bg);
}

void draw(){
  if (mouseX > 50-off.width && mouseX < 50+off.width &&      // analisa se o mouse esta dentro do botão ligar e se ele foi clik
      mouseY > 50-off.height && mouseY < 50+off.height) {
     if(mousePressed){
     inpower = !inpower; // muda estado da variavel para acionar e descionar as leituras 
     delay(500);
     }  
   }
   
   if(inpower == true){
     on();
   }else{
     off();
   }
  //println(mouseX+" , "+mouseY);
}

void off(){         // tela desligado
//background(bg);
image(off,50,50);
}

void on(){  // tela ligado //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if(x<690){
image(on,50,50);
volt=0.019607843*(unbinary(inString));  // tranforma o valor da string de entrada em decimal e faz uma multiplicação com (5/255)
fill(185);
noStroke();
rect(355, 425, 140, 37);
fill(0,0,255);
textSize(40); 
text(volt, 355, 455); // escreve na tela a voltagem lida pelo conversor ad
fill(0, 102, 153);
y = map(volt, 5, 0, 80, 233); // faz uma regra de tres para o eixo y do grafico com o valor ja transformado para volts
stroke(255,0,0);     
strokeWeight(4);    
point(x,y);
x++;
delay(100);
  }else{
  background(bg);
  image(on,50,50);
  x=185;
  }
}

void serialEvent(Serial p) {       // interrupção da porta serial ///////////////////////////////////////////////////////////////////////////////////////
  inString = p.readString();       // variavel de entrada recebe o buffer da seral
  inString = inString.substring(0, 8); // trunca a variavel de entrada de 10 caracteres para 8
}    
