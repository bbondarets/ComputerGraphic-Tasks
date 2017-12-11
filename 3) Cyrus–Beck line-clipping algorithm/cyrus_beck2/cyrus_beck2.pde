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

float dotProduct(point p1, point p2)
{
    return p1.x*p2.x + p1.y*p2.y;
}

point getInsideNormal(point p1, point p2, point z)
{
    float delX = p2.x - p1.x;
    float delY = p2.y - p1.y;
    point n = new point(-delY, delX);
    point v = new point(z.x-p1.x, z.y-p1.y);
    float dot = dotProduct(v,n);
    if(dot==0)
    {
        //printf("Error - 3 collinear points along polygon\n");
        //delay(2000);
        //exit(0);
    }
    if(dot < 0) //outside normal
    {
        n.x*=-1;
        n.y*=-1;
    }
    return n;
}

void clip(polygon poly, point p1, point p2, boolean inside)
{
    float delX = p2.x - p1.x;
    float delY = p2.y - p1.y;
    //vector D = Direction vector
    point D = new point(delX, delY);

    //iterate over edges of polygon
    point boundaryPoint = poly.points[0];
    float tEnter = 0;
    float tLeave = 1;
    for (int i = 0; i<poly.size; i++)
    {
        point p = poly.points[i];
        point q = poly.points[i+1];
        point n = getInsideNormal(p,q,boundaryPoint);

        point w = new point(p1.x-p.x, p1.y - p.y);
        float num = dotProduct(w, n);
        float den = dotProduct(D, n);
        if(den == 0)
        {
            if(num < 0)
            {
                return;
            }
            else
            {
                continue;
            }
        }

        float t = -num/den;
        if(den > 0) //outside to inside case
        {
            tEnter = (tEnter>t)?tEnter:t;
        }
        else //den < 0, inside to outside case
        {
            tLeave = (tLeave<t)?tLeave:t;
        }
        boundaryPoint = p;
    }
    if(tEnter > tLeave)
    {
        return;
    }
    float x1 = p1.x + delX * tEnter;
    float y1 = p1.y + delY * tEnter;
    float x2 = p1.x + delX * tLeave;
    float y2 = p1.y + delY * tLeave;
    stroke(255,0,0);
    println(x1+" "+x1+" "+x2+" "+y2);
    line(x1,y1,x2,y2);
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
  poly1.drawPolygon();
  clip(poly1,p1,p2,true);
  stroke(0,0,0);
  drawCoordinatePlot();
}