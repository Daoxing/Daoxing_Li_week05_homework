boolean GlobalCircleOrX=true;//This variable is about controlling that I should draw a circle or a X
int CountForObjects=0;
//This is array to save every object in every square.If in that variable it is 1,it means there is a circle.If it is 2,it means X.If it is 0,it means nothing so far. 
int[] CircleOrXObjects=new int[9];
boolean State=true;//I use it to prevent the user wants to draw something again.If state is false,you can do nothing.
int Timer=0;//If state is false,in next 5 seconds,you can not draw.This is for timing that.
void setup()
{
  size(620,620);
  background(255);
  SetBackground();
  for(int i=0;i<CircleOrXObjects.length;i++)
  {
    CircleOrXObjects[i]=0;
  }
  
}

void draw()
{
  
}

void mousePressed()
{
  if(GlobalCircleOrX)
  {
    DrawObject(mouseX,mouseY,GlobalCircleOrX);
  }
  else
  {
    DrawObject(mouseX,mouseY,GlobalCircleOrX);
  }
  
  if(State==false&&(frameCount-Timer)/60>5)
  {
    Reset();
  }
}

void SetBackground()
{
  for(int i=0;i<=620;i+=200)
  {
    for(int j=0;j<620;j+=200)
    {
      noStroke();
      fill(random(50,200),random(50,200),random(50,200));
      rectMode(CORNER);
      rect(i,j,200,200,5);      
      j+=10; 
    }
    i+=10;
  }
  
}

void DrawObject(int CurrentmouseX,int CurrentmouseY,boolean CircleOrX)
{
  if(CountForObjects>8||State==false)return;
  if(CurrentmouseY/200==0&&CircleOrXObjects[(CurrentmouseX/200)*(CurrentmouseY/200+1)+0]!=0)return;
  if(CurrentmouseY/200==1&&CircleOrXObjects[(CurrentmouseX/200)*(CurrentmouseY/200-0)+3]!=0)return;
  if(CurrentmouseY/200==2&&CircleOrXObjects[(CurrentmouseX/200)*(CurrentmouseY/200-1)+6]!=0)return;
  for(int i=0;i<=620;i+=200)
  {
    for(int j=0;j<620;j+=200)
    {
      if((CurrentmouseX>i&&CurrentmouseX<i+200&&CurrentmouseY>j&&CurrentmouseY<j+200))
      {
        if(CircleOrX)
        {
          ellipseMode(CENTER);
          noFill();
          stroke(0);
          strokeWeight(20);
          ellipse(i+100,j+100,160,160);
          CountForObjects++;
          PushObjects(CircleOrXObjects,i,j,1);
          if(CheckResult(CircleOrXObjects)==1||CheckResult(CircleOrXObjects)==2)
          {
            ShowResult(CheckResult(CircleOrXObjects));
          }
          if(CountForObjects>8)ShowResult(CheckResult(CircleOrXObjects));
        }
        else 
        {
          strokeWeight(20);
          stroke(0);
          line(i+100,j+100,i+100-80,j+100-80);
          line(i+100,j+100,i+100+80,j+100-80);
          line(i+100,j+100,i+100-80,j+100+80);
          line(i+100,j+100,i+100+80,j+100+80);
          CountForObjects++;
          PushObjects(CircleOrXObjects,i,j,2);
          if(CheckResult(CircleOrXObjects)==1||CheckResult(CircleOrXObjects)==2)
          {
            ShowResult(CheckResult(CircleOrXObjects));
          }
          if(CountForObjects>8)ShowResult(CheckResult(CircleOrXObjects));
        }
      }    
      j+=10; 
    }
    i+=10;
  }
  if(GlobalCircleOrX==false)
    GlobalCircleOrX=true;
  else GlobalCircleOrX=false;
}

int CheckResult(int[] CircleOrXObjects)
{
  for(int i=0;i<9;i+=3)
  {
    if(
      CircleOrXObjects[i]==1&&CircleOrXObjects[i+1]==1&&CircleOrXObjects[i+2]==1
      )
      return 1;
    if(
      CircleOrXObjects[i]==2&&CircleOrXObjects[i+1]==2&&CircleOrXObjects[i+2]==2
      )
      return 2;
  }
  for(int i=0;i<3;i++)
  {
    if(
      CircleOrXObjects[i]==1&&CircleOrXObjects[i+3]==1&&CircleOrXObjects[i+6]==1
      )
      return 1;
    if(
      CircleOrXObjects[i]==2&&CircleOrXObjects[i+3]==2&&CircleOrXObjects[i+6]==2
      )
      return 2;
  }
  if(
    CircleOrXObjects[0]==1&&CircleOrXObjects[4]==1&&CircleOrXObjects[8]==1
    )
    return 1;
  if(
    CircleOrXObjects[0]==2&&CircleOrXObjects[4]==2&&CircleOrXObjects[8]==2
    )
    return 2;
  if(
    CircleOrXObjects[2]==1&&CircleOrXObjects[4]==1&&CircleOrXObjects[6]==1
    )
    return 1;
  if(
    CircleOrXObjects[2]==2&&CircleOrXObjects[4]==2&&CircleOrXObjects[6]==2
    )
    return 2;
  return 0;
}
void PushObjects(int[] CircleOrXObjects,int i,int j,int CircleOrX)
{
  if(j/200==0)CircleOrXObjects[(i/200)*(j/200+1)+0]=CircleOrX;
  if(j/200==1)CircleOrXObjects[(i/200)*(j/200-0)+3]=CircleOrX;
  if(j/200==2)CircleOrXObjects[(i/200)*(j/200-1)+6]=CircleOrX;
}
void ShowResult(int Result)
{
  switch(Result)
  {
    case 0:
    SetBackground();
    textAlign(CENTER,CENTER);
    textSize(50);
    fill(0);
    text("No Winner!",310,310);
    break;
    
    case 1:
    SetBackground();
    textAlign(CENTER,CENTER);
    textSize(50);
    fill(0);
    text("o is Winner!",310,310);
    break;
    
    case 2:
    SetBackground();
    textAlign(CENTER,CENTER);
    textSize(50);
    fill(0);
    text("x is Winner!",310,310);
    break;
  }
  State=false;
  Timer=frameCount;
}
void Reset()
{
  background(255);
  SetBackground();
  for(int i=0;i<CircleOrXObjects.length;i++)
  {
    CircleOrXObjects[i]=0;
  }
  CountForObjects=0;
  State=true;
  GlobalCircleOrX=true;
}
