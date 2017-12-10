void drawRandomConvexPolygone(int vertexes)
{
  float x0=width/2; 
  float y0=height/2;
  float radius=400;
  fill(0,255,0);
  beginShape();
  for(float angle=0; angle<2*PI;)
  {
    float x=x0+(radius*cos(angle));
    float y=y0+(radius*sin(angle));
    angle+=random(20,260)/180.0;
    vertex(x,y);
    println(x+" "+y);
  }
  endShape();
}

void setup()
{
  background(255,255,255);
  size(1000,800);
  drawRandomConvexPolygone(6);
}