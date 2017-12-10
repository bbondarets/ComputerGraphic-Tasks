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
  float ex,ey;
  public point(){}
  public point(float _x, float _y)
  {
    x=width/2+_x*15;
    y=height/2-_y*15;
    ex=_x;
    ey=_y;
  }
};

class polygon
{
   point[] points;
   int size;
   int priority;
   
   public polygon(int _size)
   {
     size = _size;
     points = new point[size+1];
   }
   
   public polygon(int _size, point[] _points)
   {
     size = _size;
     points = _points;
   }
   
   void drawPolygon()
   {
     stroke(0,0,0);
     fill(249,255,1);
     beginShape();
     for(int i=0; i<size; ++i)
     {
       vertex(points[i].x, points[i].y);
     }
     endShape(CLOSE);
   }
   
   boolean isConvex()
   {
      boolean got_negative = false;
      boolean got_positive = false;

      int B, C;
      for (int A = 0; A < size; A++)
      {
        B = (A + 1) % size;
        C = (B + 1) % size;
        
        float BAx = points[A].ex - points[B].ex;
        float BAy = points[A].ey - points[B].ey;
        float BCx = points[C].ex - points[B].ex;
        float BCy = points[C].ey - points[B].ey;
        
        float cross_product = BAx * BCy - BAy * BCx;
        
        if (cross_product < 0)
        {
          got_negative = true;
        }
        else if (cross_product > 0)
        {
          got_positive = true;
        }
        if (got_negative && got_positive) return false;
      }
      return true;
   }
}

void clip(polygon poly, point p1, point p2, boolean inside)
{
  boolean isConvex = poly.isConvex();
  println("Многокутник: "+((isConvex)?"опуклий":"неопуклий"));
  float t_enter = 0, t_leave = 1;
  for (int i = 0; i<poly.size; i++)
  {
    point n = new point();
    n.x = (poly.points[i + 1].y - poly.points[i].y);
    n.y = (poly.points[i + 1].x - poly.points[i].x);
    
    point pei = new point();
    pei = poly.points[i];
    float numerator = n.x*(pei.x - p1.x) - n.y*(pei.y - p1.y);
    float denominator = n.x*(p2.x - p1.x) + n.y*(p1.y - p2.y);
    float t=0;
    if (denominator != 0)
    {
      t = numerator / denominator;
    }

    if (t >= 0 && t <= 1)
    {
      if (denominator<0)
      {
        if (t>t_enter)
        {
          t_enter = t;
        }
      }
      else if (denominator>0)
      {
        if (t<t_leave)
        {
          t_leave = t;
        }
      }
    }
  }

  point pi = new point();
  point pl = new point();
  pi.x = p1.x + (p2.x - p1.x)*t_enter;
  pi.y = p1.y + (p2.y - p1.y)*t_enter;
  pl.x = p1.x + (p2.x - p1.x)*t_leave;
  pl.y = p1.y + (p2.y - p1.y)*t_leave;
  
  //drawPolygone(pol);
  poly.drawPolygon();
  
  println("Тип відсікання: "+((inside)?"внутрішнє":"зовнішнє"));
  if(inside)
  {
    stroke(255,0,0);
    line(pi.x, pi.y, pl.x, pl.y);
  }
  else
  {
    background(255,255,255);
    poly.drawPolygon();
    stroke(255,0,0);
    line(p1.x,p1.y,pi.x,pi.y);
    line(p2.x,p2.y,pl.x,pl.y);
    stroke(0,0,255);
    line(pi.x, pi.y, pl.x, pl.y);
  }
}

void setup()
{
  background(255,255,255);
  size(1000,900);
  
  point[] test = new point[7];
  test[0] = new point(-5,-5);
  test[1] = new point(0,10);
  test[2] = new point(4,12);
  test[3] = new point(14,12);
  test[4] = new point(14,5);
  test[5] = new point(10,0);
  test[6] = test[0];
  
  polygon poly = new polygon(6,test);
  
  point p1 = new point(-10,-10);
  point p2 = new point(21,21);
  stroke(0,0,255);
  line(p1.x,p1.y,p2.x,p2.y);
  clip(poly,p1,p2,true);
  stroke(0,0,0);
  drawCoordinatePlot();
}