
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
  
  beginShape();
  vertex(x - halfSize, y - sqrt(3) * halfSize);
  vertex(x + halfSize, y - sqrt(3) * halfSize);
  vertex(x + size, y);
  vertex(x + halfSize, y + sqrt(3) * halfSize);
  vertex(x - halfSize, y + sqrt(3) * halfSize);
  vertex(x - size, y);
  endShape(CLOSE);
  
  line(x - halfSize, y - sqrt(3) * halfSize-size,x - halfSize, y - sqrt(3) * halfSize);
  line(x + halfSize, y - sqrt(3) * halfSize-size,x + halfSize, y - sqrt(3) * halfSize);
  line(x - halfSize, y + sqrt(3) * halfSize+size,x - halfSize, y + sqrt(3) * halfSize);
  line(x + halfSize, y + sqrt(3) * halfSize+size,x + halfSize, y + sqrt(3) * halfSize);
  
  line(x - halfSize - halfSize * sqrt(3),y + size + halfSize, x - halfSize, y + sqrt(3) * halfSize);
  line(x - size - size*sqrt(3)/2, y+halfSize, x - size, y);
  
  line(x + halfSize, y + sqrt(3) * halfSize, x + halfSize + halfSize * sqrt(3),y + size + halfSize);
  line(x - halfSize - halfSize * sqrt(3),y - size - halfSize,x - halfSize, y - sqrt(3) * halfSize);
  line(x - size - size*sqrt(3)/2, y-halfSize,x - size, y);
  line(x + size, y,x + size +size*sqrt(3)/2, y+halfSize);
  line(x + size, y,x + size +size*sqrt(3)/2, y-halfSize);
  line(x + halfSize, y - sqrt(3) * halfSize,x + halfSize + halfSize * sqrt(3),y - size - halfSize);
}


void setup() 
{
  size(860, 480);
  drawDodecagon(360,240,100);
}
 