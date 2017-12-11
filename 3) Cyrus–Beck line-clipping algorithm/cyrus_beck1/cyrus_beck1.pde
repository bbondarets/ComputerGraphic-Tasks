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
   
   public polygon(int _size, point[] _points, int _priority)
   {
     size = _size;
     points = _points;
     priority = _priority;
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
   
   float GetAngle(float Ax, float Ay, float Bx, float By, float Cx, float Cy)
   {
            // Get the dot product.
            float BAx = Ax - Bx;
            float BAy = Ay - By;
            float BCx = Cx - Bx;
            float BCy = Cy - By;
            float dot_product = (BAx * BCx + BAy * BCy);
            
            
            BAx = Ax - Bx;
            BAy = Ay - By;
            BCx = Cx - Bx;
            BCy = Cy - By;
            // Get the cross product.
            float cross_product = (BAx * BCy - BAy * BCx);

            // Calculate the angle.
            return (float)atan2(cross_product, dot_product);
        }
   
   boolean pointInPolygon(float X, float Y)
   {
      int max_point = points.length - 1;
      float total_angle = GetAngle(points[max_point].x, points[max_point].y,X, Y,points[0].x, points[0].y);
      for (int i = 0; i < max_point; i++)
      {
         total_angle += GetAngle(points[i].x, points[i].y,X, Y,points[i + 1].x, points[i + 1].y);
      }
      return (abs(total_angle) > 0.000001);
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
  if(isConvex)
  {
    float tEnter = 0, tLeave = 1;
    for (int i = 0; i<poly.size; i++)
    {
      point n = new point();
      n.x = (poly.points[i + 1].y - poly.points[i].y);
      n.y = (poly.points[i + 1].x - poly.points[i].x);
      
      point pei = poly.points[i];
      
      float numerator = n.x*(pei.x - p1.x) - n.y*(pei.y - p1.y);
      float denominator = n.x*(p2.x - p1.x) + n.y*(p1.y - p2.y);
      
      float t=0;
      if (denominator != 0)
      {
        t = (numerator / denominator);
        println("t="+t);
      }
      //лінія паралельна бо denomanator==0
      else
      {
        println("Лінія паралельна!");
        if(numerator < 0)
        {
          println("Вибачте! Лінія за межами вікна!");
          poly.drawPolygon();
          return;
        }
        else
        {
          continue;
        }
      }
      if(denominator > 0) //outside to inside case
      {
         tEnter = (tEnter>t)?tEnter:t;
      }
      else //den < 0, inside to outside case
      {
         tLeave = (tLeave<t)?tLeave:t;
      }
      println("enter: "+tEnter+" leave:"+tLeave);
      
    }
    if(tEnter > tLeave)
    {
      poly.drawPolygon();
      println("FUCK");
      return;
    }

    point pi = new point();
    point pl = new point();
    pi.x = p1.x + (p2.x - p1.x)*tEnter;
    pi.y = p1.y + (p2.y - p1.y)*tEnter;
    pl.x = p1.x + (p2.x - p1.x)*tLeave;
    pl.y = p1.y + (p2.y - p1.y)*tLeave;
  
    poly.drawPolygon();
  
    println("Тип відсікання: "+((inside)?"внутрішнє":"зовнішнє"));
    if(inside)
    {
      stroke(255,0,0);
      println(pi.x+" "+pi.y+" "+pl.x+" "+pl.y);
      line(pi.x, pi.y, pl.x, pl.y);
    }
    else
    {
      //background(255,255,255);
      poly.drawPolygon();
      stroke(255,0,0);
      line(p1.x,p1.y,pi.x,pi.y);
      line(p2.x,p2.y,pl.x,pl.y);
      stroke(0,0,255);
      line(pi.x, pi.y, pl.x, pl.y);
    }
  }
  else
  {
    //background(255,255,255);
    poly.drawPolygon();
    line(p1.x,p1.y,p2.x,p2.y);
    println("Будьласка задайте опуклий многокутник!!!!");
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

  
  point[] test1 = new point[4];
  test1[0] = new point(0,0);
  test1[1] = new point(0,6);
  test1[2] = new point(6,0);
  test1[3] = test1[0];
  
  polygon poly = new polygon(6,test,1);
  polygon poly1 = new polygon(3,test1,2);
  
  //point p1 = new point(-30,0);
  //point p2 = new point(20,5);
  //point p1 = new point(0,0);
  //point p2 = new point(9,9);
  point p1 = new point(0,0);
  point p2 = new point(7,7);
  stroke(0,0,255);
  line(p1.x,p1.y,p2.x,p2.y);
  //clip(poly,p1,p2,true);
  
  clip(poly1,p1,p2,true);
  stroke(0,0,0);
  drawCoordinatePlot();
}