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

float[] drawParametricParabola(float a, float delta_theta, int quantity, float[] xpoints, float[] ypoints)
{
  int calculating_start_time = millis();
  //float[] xpoints = new float[quantity];
  //float[] ypoints = new float[quantity];
  xpoints[0]=0;
  ypoints[0]=0;
  for(int i=1; i<quantity; ++i)
  {
    xpoints[i] = xpoints[i-1]+ypoints[i-1]*delta_theta+a*delta_theta*delta_theta;
    ypoints[i] = ypoints[i-1]+2*a*delta_theta;
    delay(1);
  }
  println("Параметричні точки----------");
  for(int i=0; i<5; ++i)
  {
    println(xpoints[i] + "-" + ypoints[i]);
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

void drawNotParametricParabola(float a, int quantity, float[] xpoints, float[] ypoints)
{
  int calculating_start_time = millis();
  //float[] ypoints = new float[quantity];
  for(int i=0; i<quantity; ++i)
  {
    ypoints[i] = 2*sqrt(a*xpoints[i]);
    delay(1);
  }
  println("Непараметричні точки----------");
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

float calculate_vec_norma(float[] vec, int lenght)
{
   float norma = abs(vec[0]);
   for (int i = 1; i < lenght; ++i)
   {
      if (abs(vec[i]) > norma)
      {
        norma = abs(vec[i]);
      }
   }
   return norma;
}

float integral(float b, int quantity, float[] xpoints, float[] ypoints)
{
  int count = 0;
  for(int i=0; i<quantity; ++i)
  {
    if(xpoints[i]<=b)
    {
      ++count;
    }
    else
    {
      break;
    }
  }
  float h=(xpoints[count]-xpoints[0])/count;
  float q=(ypoints[0]+ypoints[count])/2;
  for(int i=0; i<count; ++i)
  {
    q+=ypoints[i];
  }
  return q*h;
}

void setup()
{
  background(255, 255, 255);
  size(800,700);
  drawCoordinatePlot();
  
  int size = 100;
  float[] xpoints = new float[size];
  float[] ypoints1 = new float[size];//Parametric
  float[] ypoints2 = new float[size];//Not parametric
  drawParametricParabola(1,0.33,size,xpoints,ypoints1);
  drawNotParametricParabola(1,size,xpoints,ypoints2);
  
  float[] norma_vec = new float[size];
  for(int i=0; i<size; ++i)
  {
    norma_vec[i] = ypoints1[i]-ypoints2[i];
  }
  float norma = calculate_vec_norma(norma_vec, size);
  println("Порівняння аналітичних і рекурентних співвідношень: "+norma);
  
  float parametric_norma = calculate_vec_norma(ypoints1, size);
  float norma_main = norma/parametric_norma;
  println("Норма: "+norma_main);
  println("Відсоткове співвідношення: "+norma_main*100+" %");
  
  float area_start_point = 0;
  float area_end_point = 20;
  stroke(0,255,0);
  line(width/2+area_start_point*15,0,width/2+area_start_point*15,height);
  line(width/2+area_end_point*15,0,width/2+area_end_point*15,height);
  float parametric_integral = integral(area_end_point,size,xpoints,ypoints1);
  float notparametric_integral = integral(area_end_point,size,xpoints,ypoints2);
  println("Площа параметричного задання: "+parametric_integral);
  println("Площа непараметричного задання: "+notparametric_integral);
}