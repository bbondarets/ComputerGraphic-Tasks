void drawNotParametricParabolaPrimitive(float a)
{
  float prevx = width/2;
  float prevy = height/2;
  float inerse_prevy = height/2;
  for(float x=width/2; x<=width; x+=15)
  {
    float newy = 2*sqrt(a*(x-width/2)/15);
    stroke(255,0,0);
    line(prevx,prevy,x,height/2-newy*15);
    line(prevx,inerse_prevy,x,height/2+newy*15);
    prevx = x;
    prevy = height/2-newy*15;
    inerse_prevy=height/2+newy*15;
  }
}

void drawParametricParabolaPrimitive(float a, float delta_theta)
{
  
}

void drawCoordinatePlot()
{
  int halfHeight = height/2;
  int halfwidth = width/2;
  line(0,halfHeight,width,halfHeight);
  line(halfwidth,0,halfwidth,height);
  //Make the X Axis
  int inversex = halfwidth-15;
  int xLabel = 1;
  int xLabelInv = -1;
  textSize(8);
  fill(0,0,0);
  for(int x=halfwidth+15; x<=width; x+=15)
  {
    line(x,halfHeight-3,x,halfHeight+3);
    line(inversex,halfHeight-3,inversex,halfHeight+3);
    text(xLabel++,x-2,halfHeight+12);
    text(xLabelInv--,inversex-6,halfHeight+12);
    inversex-=15;
  }
  //Make the Y Axis
  int inversey = halfHeight-15;
  int yLabel = 1;
  int yLabelInv = -1;
  textSize(8);
  fill(0,0,0);
  for(int y=halfHeight+15; y<=height; y+=15)
  {
    line(halfwidth-3,y,halfwidth+3,y);
    line(halfwidth-3,inversey,halfwidth+3,inversey);
    
    text(yLabel++,halfwidth-14,inversey+3);
    text(yLabelInv--,halfwidth-20,y+3);
    inversey-=15;
  }
}

void setup()
{
  background(255, 255, 255);
  size(800,700);
  drawCoordinatePlot();
  drawNotParametricParabolaPrimitive(1);
  //println("Час для обрахунку непараметричного задання:"+0.56);
  //println("Час для обрахунку параметричного задання:"+0.13);
}