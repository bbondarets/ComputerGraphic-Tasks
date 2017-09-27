void drawSquare(float x, float y, float size)
{
  float halfSize = size/2;
  beginShape();
  vertex(x - halfSize, y + halfSize);
  vertex(x + halfSize, y + halfSize);
  vertex(x + halfSize, y - halfSize);
  vertex(x - halfSize, y - halfSize);
  endShape(CLOSE);
}

void drawHexagon(float x, float y, float size)
{
  float halfSize = size/2;
  beginShape();
  vertex(x - halfSize, y - sqrt(3) * halfSize);
  vertex(x + halfSize, y - sqrt(3) * halfSize);
  vertex(x + size, y);
  vertex(x + halfSize, y + sqrt(3) * halfSize);
  vertex(x - halfSize, y + sqrt(3) * halfSize);
  vertex(x - size, y);
  endShape(CLOSE);
}

void drawDodecagon(float x, float y, float size)
{
  float halfSize = size/2;
  beginShape();
  vertex(x - halfSize, y - sqrt(3) * halfSize-size);
  vertex(x + halfSize, y - sqrt(3) * halfSize-size);
  vertex(x + halfSize + halfSize * sqrt(3),y - size - halfSize);
  vertex(x + size +size*sqrt(3)/2, y-halfSize);
  vertex(x + size +size*sqrt(3)/2, y+halfSize);//
  vertex(x + halfSize + halfSize * sqrt(3),y + size + halfSize);
  vertex(x + halfSize, y + sqrt(3) * halfSize+size);
  vertex(x - halfSize, y + sqrt(3) * halfSize+size);
  vertex(x - halfSize - halfSize * sqrt(3),y + size + halfSize);
  vertex(x - size - size*sqrt(3)/2, y+halfSize);
  vertex(x - size - size*sqrt(3)/2, y-halfSize);
  vertex(x - halfSize - halfSize * sqrt(3),y - size - halfSize);
  endShape(CLOSE);
}

void drawSquare1(float x, float y, float size)
{
  translate(x,y);
  rotate(PI/6);
  drawSquare(0,0,size);
  rotate(-PI/6);
  translate(-x,-y);
}

void drawSquare2(float x, float y, float size)
{
  translate(x,y);
  rotate(-PI/6);
  drawSquare(0,0,size);
  rotate(PI/6);
  translate(-x,-y);
}

void drawHexagon1(float x, float y, float size)
{
  translate(x,y);
  rotate(PI/2);
  drawHexagon(0,0,size);
  rotate(-PI/2);
  translate(-x,-y);
}

void fillThePlaneWithSquares(float size)
{
  float from = size/2;
  for(float i=from; i<=960; i+=size)
  {
    for(float j=from; j<=580; j+=size)
    {
      drawSquare(i,j,size);
    }
  }
}

void fillThePlaneWithHexagones(float size)
{
  float colStep = size*sqrt(3);
  float rowStep = colStep*sqrt(3);
  for(float i=0; i<=960; i+=rowStep)
  {
    for(float j=0; j<=580; j+=colStep)
    {
      drawHexagon(i,j,size);
      drawHexagon(i+rowStep/2,j+colStep/2,size);
    }
  }
}

void fillThePlaneWithDodecagones(float size)
{
  float colStep = 4*(size+size*sqrt(3)/2)-2*size/(1+sqrt(3));
  float rowStep = 2*(size+size*sqrt(3)/2);
  for(float i=0; i<=960; i+=rowStep)
  {
    for(float j=0; j<=580; j+=colStep)
    {
      drawDodecagon(i,j,size);
      drawDodecagon(i+size+size*sqrt(3)/2,j+2*(size+size*sqrt(3)/2)-size/(1+sqrt(3)),size);
    }
  }
}

void fillThePlane(float size)
{
  //fill(255,0,0);
  float rowStep = sqrt(3)*(size/2)+size+size/2;
  float colStep = size/2+sqrt(3)*size+size*sqrt(3)/2+size;
  for(float i=0; i<960; i+=2*colStep)
  {
    for(float j=0; j<580; j+=2*rowStep)
    {
      drawDodecagon(i,j,size);
      drawDodecagon(i+size/2+sqrt(3)*size+size*sqrt(3)/2+size,j+sqrt(3)*(size/2)+size+size/2,size);
    }
  }
  
  //fill(255,255,0);
  float rowStep1 = size+2*size+sqrt(3)*size;
  float colStep1 = 2*size*sqrt(3)+3*size+sqrt(3)*size;
  for(float i=0; i<960; i+=colStep1)
  {
    for(float j=0; j<580; j+=rowStep1)
    {
      //First Group of hexagones
      drawHexagon1(i-(size+sqrt(3)*size)+size/2+sqrt(3)*size/2, j+sqrt(3)*(size/2)+size+size/2, size);
      drawHexagon1(i-(size+sqrt(3)*size)+size/2+sqrt(3)*size/2+size*sqrt(3)+size, j+sqrt(3)*(size/2)+size+size/2, size);
      
      //Second Group of Hexagones
      drawHexagon1(i+size+size*sqrt(3),j,size);
      drawHexagon1(i+size+size*sqrt(3)+size+sqrt(3)*size,j,size);
    }
  }
  
  //fill(0,255,0);
  float rowStep2=3*size+size*sqrt(3);
  float colStep2=2*sqrt(3)*size+2*size+sqrt(3)*size+size;
  for(float i=0; i<960; i+=colStep2)
  {
    for(float j=0; j<580; j+=rowStep2)
    {
      drawSquare(i,j+sqrt(3)*(size/2)+size+size/2,size);
      drawSquare(i+size/2+sqrt(3)*size+size+size*sqrt(3)/2,j,size);
    }
  }
  
  float rowStep3=3*size+sqrt(3)*size;
  float colStep3=3*sqrt(3)*size+3*size;
  for(float i=0; i<960; i+=colStep3)
  {
    for(float j=0; j<580; j+=rowStep3)
    {
      //fill(0,0,255);
      //Squares at +30 degre
      drawSquare1(i+size+size*sqrt(3)/2+size*(sqrt(3)-1)/4,j+size+size*(sqrt(3)-1)/4,size);
      drawSquare1(i+size+size*sqrt(3)/2+size*(sqrt(3)-1)/4 + size +sqrt(3)*size+sqrt(3)*size/2+size/2,j+size+size*(sqrt(3)-1)/4 + 1.5*size+size*sqrt(3)/2,size);
      
      //fill(120,185,255);
      //Squares at -30 degre
      drawSquare2(i+size+size*sqrt(3)/2+size*(sqrt(3)-1)/4 + sqrt(3)*size+size+sqrt(3)*size/2+size/2,j+size+size*(sqrt(3)-1)/4,size);
      drawSquare2(i+size+size*sqrt(3)/2+size*(sqrt(3)-1)/4,j+size+size*(sqrt(3)-1)/4+1.5*size+size*sqrt(3)/2,size);
    }
  }
}

void setup() 
{
  size(860, 480);
  //fillThePlaneWithSquares(30);
  //fillThePlaneWithHexagones(30);
  //fillThePlaneWithDodecagones(30);
  fillThePlane(30);
}
 