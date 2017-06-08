String tmp;
void setup() { 
  pinMode(12, INPUT); // portas de entra
  pinMode(11, INPUT);
  pinMode(10, INPUT);
  pinMode(9, INPUT);
  pinMode(8, INPUT);
  pinMode(7, INPUT);
  pinMode(6, INPUT);
  pinMode(5, INPUT);
  Serial.begin(9600); // velocidade da porta serial
}

void loop() {
tmp = ""; // limpa a string tmp a cada leitura do conversor ad 
for(int i=5; i<=12; i++){
  tmp =  String(tmp + digitalRead(i)); // faz a concatenação dos valores lidos nos pinos digitais
 }
Serial.println(tmp); // envia a string com os valores do ad pela serial 
delay(100); // espera 100 milisegundos por conta do delay de envio da porta serial
}
