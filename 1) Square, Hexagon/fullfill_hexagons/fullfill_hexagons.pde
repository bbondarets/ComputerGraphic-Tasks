void drawHexagon(float x, float y, float gs) 
{
  beginShape();
  vertex(x - gs, y - sqrt(3) * gs);
  vertex(x + gs, y - sqrt(3) * gs);
  vertex(x + 2 * gs, y);
  vertex(x + gs, y + sqrt(3) * gs);
  vertex(x - gs, y + sqrt(3) * gs);
  vertex(x - 2 * gs, y);
  endShape(CLOSE);
}

void setup() 
{
  size(860, 480);
  
  for(int i=0; i<=860; i+=240)
  {
    for(int j=0; j<=480; j+=140)
    {
      drawHexagon(i,j,40);
    }
  }
  for(int i=120; i<=860; i+=240)
  {
    for(int j=70; j<=480+140; j+=140)
    {
      drawHexagon(i,j,40);
    }
  }
  
  /*drawHexagon(0,0,40);
  drawHexagon(240,0,40);
  drawHexagon(480,0,40);
  drawHexagon(720,0,40);
  
  drawHexagon(120, 70, 40);
  drawHexagon(360, 70, 40);
  drawHexagon(600, 70, 40);
  drawHexagon(840, 70, 40);
  
  drawHexagon(0,140,40);
  drawHexagon(240,140,40);
  drawHexagon(480,140,40);
  drawHexagon(720,140,40);
  
  drawHexagon(120, 210, 40);
  drawHexagon(360, 210, 40);
  drawHexagon(600, 210, 40);
  drawHexagon(840, 210, 40);*/
}
 