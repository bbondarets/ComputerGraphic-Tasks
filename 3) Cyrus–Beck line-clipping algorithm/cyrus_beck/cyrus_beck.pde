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
     fill(255,244,0);
     //noFill();
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
  poly.drawPolygon();
  if(isConvex)
  {
    if(p1.x>p2.x)
    {
      point ex = p1;
      p1 = p2;
      p2 = ex;
    }
    float tEnter = 0, tLeave = 1;
    for (int i = 0; i<poly.size; i++)
    {
      point normal = new point();
      normal.x = (poly.points[i].y - poly.points[i+1].y);
      normal.y = (poly.points[i + 1].x - poly.points[i].x);
      
      point pei = poly.points[i];
      
      float numerator = normal.x*(p1.x - pei.x) + normal.y*(p1.y - pei.y);
      float denominator = normal.x*(p2.x - p1.x) + normal.y*(p2.y - p1.y);
      
      float t=0;
      if (denominator != 0)
      {
        t = -numerator / denominator;
      }
      //лінія паралельна бо denomanator==0
      else
      {
        println("Лінія паралельна!");
        if(numerator < 0)
        {
          println("Вибачте1! Лінія за межами многокутника!");
          return;
        }
        else
        {
          continue;
        }
      }
      //Ззовні в середину
      if(denominator > 0)
      {
        tEnter = (tEnter>t)?tEnter:t;
      }
      //Зсередини на зовні
      else
      {
        tLeave = (tLeave<t)?tLeave:t;
      }
    }
    if(tEnter > tLeave)
    {
        println("Вибачте2! Лінія за межами многокутника!");
        return;
    }

    point startPoint = new point();
    point endPoint = new point();
    startPoint.x = p1.x + (p2.x - p1.x)*tEnter;
    startPoint.y = p1.y + (p2.y - p1.y)*tEnter;
    endPoint.x = p1.x + (p2.x - p1.x)*tLeave;
    endPoint.y = p1.y + (p2.y - p1.y)*tLeave;
  
    println("Тип відсікання: "+((inside)?"внутрішнє":"зовнішнє"));
    if(inside)
    {
      stroke(0,255,0);
      //strokeWeight(2);
      line(startPoint.x, startPoint.y, endPoint.x, endPoint.y);
    }
    else
    {
      background(255,255,255);
      poly.drawPolygon();
      stroke(0,255,0);
      line(p1.x,p1.y,startPoint.x,startPoint.y);
      line(p2.x,p2.y,endPoint.x,endPoint.y);
      stroke(255,0,0);
      line(startPoint.x, startPoint.y, endPoint.x, endPoint.y);
    }
  }
  else
  {
    stroke(255,0,0);
    line(p1.x,p1.y,p2.x,p2.y);
    println("Будьласка задайте опуклий многокутник!!!!");
  }
}

void clipFiguresByPriority(polygon[] polygones, point p1, point p2)
{
  int maxPriorityIndex = 0;
  int maxPriority = polygones[0].priority;
  for(int i=1; i<polygones.length; ++i)
  {
    if(polygones[i].priority>maxPriority)
    {
      maxPriorityIndex = i;
      maxPriority = polygones[i].priority;
    }
  }
  for(int i=0; i<polygones.length; ++i)
  {
    if(i!=maxPriorityIndex)
    {
      polygones[i].drawPolygon();
    }
  }
  stroke(255,0,0);
  line(p1.x,p1.y,p2.x,p2.y);
  clip(polygones[maxPriorityIndex],p1,p2,true);
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
  polygon poly = new polygon(6,test,1);
  
  point p1 = new point(-19,-8);
  point p2 = new point(20,8);
  
  point p3 = new point(0,-9);
  point p4 = new point(15,5);
  
  point p5 = new point(-5,-18);
  point p6 = new point(20,3);
  
  stroke(255,0,0);
  line(p1.x,p1.y,p2.x,p2.y);
  //line(p3.x,p3.y,p4.x,p4.y);
  //line(p5.x,p5.y,p6.x,p6.y);
  clip(poly,p1,p2,true);
  
  
  /*
  point[] hex1 = new point[7];
  hex1[0] = new point(-5,2);
  hex1[1] = new point(0,2);
  hex1[2] = new point(2,-3);
  hex1[3] = new point(0,-7);
  hex1[4] = new point(-5,-7);
  hex1[5] = new point(-7,-3);
  hex1[6] = hex1[0];
  
  point[] hex2 = new point[8];
  hex2[0] = new point(-2,0);
  hex2[1] = new point(-2,5);
  hex2[2] = new point(0,7);
  hex2[3] = new point(4,8);
  hex2[4] = new point(8,6);
  hex2[5] = new point(7,0);
  hex2[6] = new point(0,-2);
  hex2[7] = hex2[0];
  
  point[] hex3 = new point[4];
  hex3[0] = new point(6,0);
  hex3[1] = new point(-10,4);
  hex3[2] = new point(4,10);
  hex3[3] = hex3[0];
  
  polygon[] hexagones = new polygon[3];
  hexagones[0] = new polygon(6,hex1,2);
  hexagones[1] = new polygon(7,hex2,3);
  hexagones[2] = new polygon(3,hex3,1);
  
  point start = new point(-8,-6);
  point end = new point(13,8);
  stroke(255,0,0);
  line(start.x,start.y,end.x,end.y);
  clipFiguresByPriority(hexagones,start,end);
  */
  //Coordinates
  stroke(0,0,0);
  drawCoordinatePlot();
}