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

class point
{
  float x, y;
  public point(){}
  public point(float _x, float _y)
  {
    x=_x;
    y=_y;
  }
};

class polygone
{
  int size;
  point[] points;
}

void drawPolygone(point[] polygone)
{
  fill(249,255,1);
  beginShape();
  for(int i=0; i<polygone.length; ++i)
  {
    vertex(polygone[i].x*15+width/2,height/2-polygone[i].y*15);
  }
  endShape(CLOSE);
}

void clip(point[] pol, point p1, point p2)
{
  float t_enter = 0, t_leave = 1;
  for (int i = 0; i<pol.length-1; i++)
  {
    point n = new point();
    point pei = new point();
    pei = pol[i];
    n.x = (pol[i + 1].y - pol[i].y);
    n.y = (pol[i + 1].x - pol[i].x);
    float num, den;
    num = n.x*(pei.x - p1.x) - n.y*(pei.y - p1.y);
    den = n.x*(p2.x - p1.x) + n.y*(p1.y - p2.y);
    float t=0;
    if (den != 0)
      t = num*1.0 / den;

    if (t >= 0 && t <= 1)
    {
      if (den<0)
      {
        if (t>t_enter)
          t_enter = t;
      }
      else if (den>0)
      {
        if (t<t_leave)
          t_leave = t;
      }
    }
  }

  point pi = new point();
  point pl = new point();
  pi.x = p1.x + (p2.x - p1.x)*t_enter;
  pi.y = p1.y + (p2.y - p1.y)*t_enter;
  pl.x = p1.x + (p2.x - p1.x)*t_leave;
  pl.y = p1.y + (p2.y - p1.y)*t_leave;
  stroke(0,255,0);
  line(pi.x, pi.y, pl.x, pl.y);
}

void setup()
{
  background(255,255,255);
  size(1000,900);
  drawCoordinatePlot();
  point[] test = new point[4];
  test[0] = new point(0,0);
  test[1] = new point(0,10);
  test[2] = new point(10,0);
  test[3] = test[0];
  drawPolygone(test);
  point p1 = new point(width/2,height/2);
  point p2 = new point(width/2+150,height/2-150);
  stroke(0,0,255);
  line(p1.x,p1.y,p2.x,p2.y);
  clip(test,p1,p2);
}