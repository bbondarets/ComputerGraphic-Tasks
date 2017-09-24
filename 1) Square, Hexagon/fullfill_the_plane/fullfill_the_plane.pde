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

void setup() 
{
  size(860, 480);
  //fillThePlaneWithSquares(30);
  //fillThePlaneWithHexagones(30);
  fillThePlaneWithDodecagones(30);
}
 