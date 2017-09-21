void drawSquare(float x, float y, float size)
{
  beginShape();
  vertex(x, y);
  vertex(x+size, y);
  vertex(x+size, y-size);
  vertex(x, y-size);
  endShape(CLOSE);
}

void drawHexagon(float x, float y, float size)
{
  beginShape();
  vertex(x - size, y - sqrt(3) * size);
  vertex(x + size, y - sqrt(3) * size);
  vertex(x + 2 * size, y);
  vertex(x + size, y + sqrt(3) * size);
  vertex(x - size, y + sqrt(3) * size);
  vertex(x - 2 * size, y);
  endShape(CLOSE);
}

void fillThePlaneWithSquares(float size)
{
  for(float i=0; i<=860; i+=size)
  {
    for(float j=0; j<=480; j+=size)
    {
      drawSquare(i,j,size);
    }
  }
}

void fillThePlaneWithHexagones(float size)
{
  float colStep = 2*size*sqrt(3);
  float rowStep = colStep*sqrt(3);
  for(float i=0; i<=860; i+=rowStep)
  {
    for(float j=0; j<=480; j+=colStep)
    {
      drawHexagon(i,j,size);
      drawHexagon(i+rowStep/2,j+colStep/2,size);
    }
  }
}

void setup() 
{
  size(860, 480);
  //fillThePlaneWithSquares(30);
  fillThePlaneWithHexagones(15);
}
 