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

void drawNotParametricParabola(float a, int quantity)
{
  int calculating_start_time = millis();
  float[] xpoints = new float[quantity];
  float[] ypoints = new float[quantity];
  //float xstep = (float)((width/2)/15+15)/quantity;
  float xstep = 1;
  float x=0;
  for(int i=0; i<quantity; ++i)
  {
    xpoints[i] = x;
    ypoints[i] = pow(x,2)/(4*a);
    x+=xstep;
    delay(1);
  }
  println("Час для обрахунку непараметричного задання:"+(millis()-calculating_start_time));
  
  int drawing_start_time=millis();
  float prev_x = width/2+xpoints[0]*15;
  float prev_y = height/2-ypoints[0]*15;
  float inverse_prev_x = width/2-xpoints[0]*15;
  float cur_x, cur_y, inverse_cur_x;
  for(int i=0; i<quantity; ++i)
  {
    cur_x = width/2+xpoints[i]*15;
    cur_y = height/2-ypoints[i]*15;
    inverse_cur_x=width/2-xpoints[i]*15;
    stroke(255,0,0);
    line(prev_x,prev_y,cur_x,cur_y);
    line(inverse_prev_x,prev_y,inverse_cur_x,cur_y);
    prev_x = cur_x;
    prev_y = cur_y;
    inverse_prev_x = inverse_cur_x;
    delay(1);
  }
  println("Час для малювання непараметричного задання:"+(millis()-drawing_start_time));
}

void drawParametricParabola(float a, float delta_theta, int quantity)
{
  int calculating_start_time = millis();
  float[] xpoints = new float[quantity];
  float[] ypoints = new float[quantity];
  xpoints[0]=0;
  ypoints[0]=0;
  for(int i=1; i<quantity; ++i)
  {
    xpoints[i] = xpoints[i-1]+2*a*delta_theta;
    ypoints[i] = ypoints[i-1]+xpoints[i-1]*delta_theta+a*delta_theta*delta_theta;
    //println(xpoints[i] + "-" + ypoints[i]);
    delay(1);
  }
  println("Час для обрахунку параметричного задання:"+(millis()-calculating_start_time));
  
  int drawing_start_time=millis();
  float prev_x = width/2+xpoints[0]*15;
  float prev_y = height/2-ypoints[0]*15;
  float inverse_prev_x = width/2-xpoints[0]*15;
  float cur_x, cur_y, inverse_cur_x;
  for(int i=1; i<quantity; ++i)
  {
    cur_x = width/2+xpoints[i]*15;
    cur_y = height/2-ypoints[i]*15;
    inverse_cur_x=width/2-xpoints[i]*15;
    stroke(0,0,255);
    line(prev_x,prev_y,cur_x,cur_y);
    line(inverse_prev_x,prev_y,inverse_cur_x,cur_y);
    prev_x = cur_x;
    prev_y = cur_y;
    inverse_prev_x = inverse_cur_x;
    delay(1);
  }
  println("Час для малювання параметричного задання:"+(millis()-drawing_start_time));
}


void drawNotParametricParabolaPrimitive(float a)
{
  int calculating_start_time = millis();
  int quantity = 9;
  float[] xpoints = new float[quantity];
  float[] ypoints = new float[quantity];
  float xstep = 2;
  float x=0;
  for(int i=0; i<quantity; ++i)
  {
    xpoints[i] = x;
    ypoints[i] = pow(x,2)/(4*a);
    //println(xpoints[i] + "-" + ypoints[i]);
    x+=xstep;
    delay(1);
  }
  println("(ПР)Час для обрахунку непараметричного задання:"+(float)(millis()-calculating_start_time));
  
  int drawing_start_time=millis();
  float prev_x = width/2+xpoints[0]*15;
  float prev_y = height/2-ypoints[0]*15;
  float inverse_prev_x = width/2-xpoints[0]*15;
  float cur_x, cur_y, inverse_cur_x;
  for(int i=0; i<quantity; i++)
  {
    cur_x = width/2+xpoints[i]*15;
    cur_y = height/2-ypoints[i]*15;
    inverse_cur_x=width/2-xpoints[i]*15;
    stroke(255,0,0);
    line(prev_x,prev_y,cur_x,cur_y);
    line(inverse_prev_x,prev_y,inverse_cur_x,cur_y);
    prev_x = cur_x;
    prev_y = cur_y;
    inverse_prev_x = inverse_cur_x;
    delay(1);
  }
  println("(ПР)Час для малювання непараметричного задання:"+(float)(millis()-drawing_start_time));
}

void drawParametricParabolaPrimitive(float a, float delta_theta)
{
  int calculating_start_time = millis();
  int quantity=9;
  float[] xpoints = new float[quantity];
  float[] ypoints = new float[quantity];
  xpoints[0]=0;
  ypoints[0]=0;
  for(int i=1; i<quantity; ++i)
  {
    xpoints[i] = xpoints[i-1]+2*a*delta_theta;
    ypoints[i] = ypoints[i-1]+xpoints[i-1]*delta_theta+a*delta_theta*delta_theta;
    //println(xpoints[i] + "-" + ypoints[i]);
    delay(1);
  }
  println("(ПР)Час для обрахунку параметричного задання:"+(float)(millis()-calculating_start_time));
  
  int drawing_start_time=millis();
  float prev_x = width/2+xpoints[0]*15;
  float prev_y = height/2-ypoints[0]*15;
  float inverse_prev_x = width/2-xpoints[0]*15;
  float cur_x, cur_y, inverse_cur_x;
  for(int i=1; i<quantity; ++i)
  {
    cur_x = width/2+xpoints[i]*15;
    cur_y = height/2-ypoints[i]*15;
    inverse_cur_x=width/2-xpoints[i]*15;
    stroke(0,255,0);
    line(prev_x,prev_y,cur_x,cur_y);
    line(inverse_prev_x,prev_y,inverse_cur_x,cur_y);
    prev_x = cur_x;
    prev_y = cur_y;
    inverse_prev_x = inverse_cur_x;
    delay(1);
  }
  println("(ПР)Час для малювання параметричного задання:"+(float)(millis()-drawing_start_time));
}

void setup()
{
  background(255, 255, 255);
  size(800,700);
  drawCoordinatePlot();
  
  drawNotParametricParabola(1,100);
  drawParametricParabola(1,0.5,100);
  
  //drawNotParametricParabolaPrimitive(1);
  //drawParametricParabolaPrimitive(1,1);
}