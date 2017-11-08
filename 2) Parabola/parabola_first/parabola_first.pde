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

void drawNotParametricParabola(float a, int quantity, float[] xpoints)
{
  int calculating_start_time = millis();
  //float[] xpoints = new float[quantity];
  float[] ypoints = new float[quantity];
  //float xstep = (float)((width/2)/15+15)/quantity;
  //float x=0;
  for(int i=0; i<quantity; ++i)
  {
    //xpoints[i] = x;
    //ypoints[i] = 2*sqrt(a*x);
    ypoints[i] = 2*sqrt(a*xpoints[i]);
    //x+=xstep;
    delay(1);
  }
  println("Непараметричні точки");
  for(int i=0; i<5; ++i)
  {
    println(xpoints[i] + "-" + ypoints[i]);
  }
  println("Час для обрахунку непараметричного задання:"+(millis()-calculating_start_time));
  
  int drawing_start_time=millis();
  float prev_x = width/2+xpoints[0]*15;
  float prev_y = height/2-ypoints[0]*15;
  float inverse_prev_y = height/2+ypoints[0]*15;
  float cur_x, cur_y, inverse_cur_y;
  for(int i=1; i<quantity; ++i)
  {
    cur_x = width/2+xpoints[i]*15;
    cur_y = height/2-ypoints[i]*15;
    inverse_cur_y=height/2+ypoints[i]*15;
    stroke(255,0,0);
    line(prev_x,prev_y,cur_x,cur_y);
    line(prev_x,inverse_prev_y,cur_x,inverse_cur_y);
    prev_x = cur_x;
    prev_y = cur_y;
    inverse_prev_y = inverse_cur_y;
    delay(1);
  }
  println("Час для малювання непараметричного задання:"+(millis()-drawing_start_time));
}

float[] drawParametricParabola(float a, float delta_theta, int quantity)
{
  int calculating_start_time = millis();
  float[] xpoints = new float[quantity];
  float[] ypoints = new float[quantity];
  xpoints[0]=0;
  ypoints[0]=0;
  for(int i=1; i<quantity; ++i)
  {
    xpoints[i] = xpoints[i-1]+ypoints[i-1]*delta_theta+a*delta_theta*delta_theta;
    ypoints[i] = ypoints[i-1]+2*a*delta_theta;
    //println(xpoints[i] + "-" + ypoints[i]);
    delay(1);
  }
  println("Час для обрахунку параметричного задання:"+(millis()-calculating_start_time));
  
  int drawing_start_time=millis();
  float prev_x = width/2+xpoints[0]*15;
  float prev_y = height/2-ypoints[0]*15;
  float inverse_prev_y = height/2+ypoints[0]*15;
  float cur_x, cur_y, inverse_cur_y;
  for(int i=1; i<quantity; ++i)
  {
    cur_x = width/2+xpoints[i]*15;
    cur_y = height/2-ypoints[i]*15;
    inverse_cur_y=height/2+ypoints[i]*15;
    stroke(0,0,255);
    line(prev_x,prev_y,cur_x,cur_y);
    line(prev_x,inverse_prev_y,cur_x,inverse_cur_y);
    prev_x = cur_x;
    prev_y = cur_y;
    inverse_prev_y = inverse_cur_y;
    delay(1);
  }
  println("Час для малювання параметричного задання:"+(millis()-drawing_start_time));
  return xpoints;
}


void drawNotParametricParabolaPrimitive(float a)
{
  float prevx = width/2;
  float prevy = height/2;
  float inerse_prevy = height/2;
  for(float x=width/2; x<=width; x++)
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

void setup()
{
  background(255, 255, 255);
  size(800,700);
  drawCoordinatePlot();
  int size = 100;
  float[] points = new float[size];
  points = drawParametricParabola(1,0.33,size);
  drawNotParametricParabola(1,size,points);
  
  //drawNotParametricParabolaPrimitive(1);
}