//+------------------------------------------------------------------+
//|                                                       Colors.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Класс для работы с цветом                                        |
//+------------------------------------------------------------------+
class CColors
  {
private:
   double            Arctan2(const double x,const double y);
   double            Hue_To_RGB(double v1,double v2,double vH);
public:
                     CColors();
                    ~CColors();
   //--- Список функций с сайта > http://www.easyrgb.com/index.php?X=MATH
   //    start of list <
   void              RGBtoXYZ(const double aR,const double aG,const double aB,double &oX,double &oY,double &oZ);
   void              XYZtoRGB(const double aX,const double aY,const double aZ,double &oR,double &oG,double &oB);
   void              XYZtoYxy(const double aX,const double aY,const double aZ,double &oY,double &ox,double &oy);
   void              YxyToXYZ(const double aY,const double ax,const double ay,double &oX,double &oY,double &oZ);
   void              XYZtoHunterLab(const double aX,const double aY,const double aZ,double &oL,double &oa,double &ob);
   void              HunterLabToXYZ(const double aL,const double aa,const double ab,double &oX,double &oY,double &oZ);
   void              XYZtoCIELab(const double aX,const double aY,const double aZ,double &oCIEL,double &oCIEa,double &oCIEb);
   void              CIELabToXYZ(const double aCIEL,const double aCIEa,const double aCIEb,double &oX,double &oY,double &oZ);
   void              CIELabToCIELCH(const double aCIEL,const double aCIEa,const double aCIEb,double &oCIEL,double &oCIEC,double &oCIEH);
   void              CIELCHtoCIELab(const double aCIEL,const double aCIEC,const double aCIEH,double &oCIEL,double &oCIEa,double &oCIEb);
   void              XYZtoCIELuv(const double aX,const double aY,const double aZ,double &oCIEL,double &oCIEu,double &oCIEv);
   void              CIELuvToXYZ(const double aCIEL,const double aCIEu,const double aCIEv,double &oX,double &oY,double &oZ);
   void              RGBtoHSL(const double aR,const double aG,const double aB,double &oH,double &oS,double &oL);
   void              HSLtoRGB(const double aH,const double aS,const double aL,double &oR,double &oG,double &oB);
   void              RGBtoHSV(const double aR,const double aG,const double aB,double &oH,double &oS,double &oV);
   void              HSVtoRGB(const double aH,const double aS,const double aV,double &oR,double &oG,double &oB);
   void              RGBtoCMY(const double aR,const double aG,const double aB,double &oC,double &oM,double &oY);
   void              CMYtoRGB(const double aC,const double aM,const double aY,double &oR,double &oG,double &oB);
   void              CMYtoCMYK(const double aC,const double aM,const double aY,double &oC,double &oM,double &oY,double &oK);
   void              CMYKtoCMY(const double aC,const double aM,const double aY,const double aK,double &oC,double &oM,double &oY);
   //--- > end of list
   //
   void              ColorToRGB(const color aColor,double &aR,double &aG,double &aB);
   double            GetR(const color aColor);
   double            GetG(const color aColor);
   double            GetB(const color aColor);
   color             RGBToColor(const double aR,const double aG,const double aB);
   color             MixColors(const color aCol1,const color aCol2,const double aK);
   void              Gradient(color &aColors[],color &aOut[],int aOutCount,bool aCycle=false);
   void              RGBtoXYZsimple(double aR,double aG,double aB,double &oX,double &oY,double &oZ);
   void              XYZtoRGBsimple(const double aX,const double aY,const double aZ,double &oR,double &oG,double &oB);
   color             Negative(const color aColor);
   color             StandardColor(const color aColor,int &aIndex);
   double            RGBtoGray(double aR,double aG,double aB);
   double            RGBtoGraySimple(double aR,double aG,double aB);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CColors::CColors(void)
  {
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CColors::~CColors(void)
  {
  }
//+------------------------------------------------------------------+
//| Arctan2                                                          |
//+------------------------------------------------------------------+
double CColors::Arctan2(const double x,const double y)
  {
   if(y==0)
     {
      if(x<0)
         return(M_PI);
      //---
      return(0);
     }
   else
     {
      if(x>0)
         return(::MathArctan(y/x));
      //---
      if(x<0)
        {
         if(y>0)
            return(::MathArctan(y/x)+M_PI);
         //---
         return(::MathArctan(y/x)-M_PI);
        }
      else
        {
         if(y<0)
            return(-M_PI_2);
         //---
         return(M_PI_2);
        }
     }
  }
//+------------------------------------------------------------------+
//| Hue_To_RGB                                                       |
//+------------------------------------------------------------------+
double CColors::Hue_To_RGB(double v1,double v2,double vH)
  {
   if(vH<0)
      vH+=1.0;
   if(vH>1.0)
      vH-=1;
   if((6.0*vH)<1.0)
      return(v1+(v2-v1)*6.0*vH);
   if((2.0*vH)<1.0)
      return(v2);
   if((3.0*vH)<2.0)
      return(v1+(v2-v1)*((2.0/3.0)-vH)*6.0);
//---
   return(v1);
  }
//+------------------------------------------------------------------+
//| Преобразование RGB в XYZ                                         |
//+------------------------------------------------------------------+
void CColors::RGBtoXYZ(const double aR,const double aG,const double aB,double &oX,double &oY,double &oZ)
  {
   double var_R=aR/255;
   double var_G=aG/255;
   double var_B=aB/255;
//---
   if(var_R>0.04045)
      var_R=::MathPow((var_R+0.055)/1.055,2.4);
   else
      var_R=var_R/12.92;
//---
   if(var_G>0.04045)
      var_G=::MathPow((var_G+0.055)/1.055,2.4);
   else
      var_G=var_G/12.92;
//---
   if(var_B>0.04045)
      var_B=::MathPow((var_B+0.055)/1.055,2.4);
   else
      var_B=var_B/12.92;
//---
   var_R =var_R*100.0;
   var_G =var_G*100.0;
   var_B =var_B*100.0;
   oX    =var_R*0.4124+var_G*0.3576+var_B*0.1805;
   oY    =var_R*0.2126+var_G*0.7152+var_B*0.0722;
   oZ    =var_R*0.0193+var_G*0.1192+var_B*0.9505;
  }
//+------------------------------------------------------------------+
//| Преобразование XYZ в RGB                                         |
//+------------------------------------------------------------------+
void CColors::XYZtoRGB(const double aX,const double aY,const double aZ,double &oR,double &oG,double &oB)
  {
   double var_X =aX/100;
   double var_Y =aY/100;
   double var_Z =aZ/100;
   double var_R =var_X*3.2406+var_Y*-1.5372+var_Z*-0.4986;
   double var_G =var_X*(-0.9689)+var_Y*1.8758+var_Z*0.0415;
   double var_B =var_X*0.0557+var_Y*(-0.2040)+var_Z*1.0570;
//---
   if(var_R>0.0031308)
      var_R=1.055*(::MathPow(var_R,1.0/2.4))-0.055;
   else
      var_R=12.92*var_R;
//---
   if(var_G>0.0031308)
      var_G=1.055*(::MathPow(var_G,1.0/2.4))-0.055;
   else
      var_G=12.92*var_G;
//---
   if(var_B>0.0031308)
      var_B=1.055*(::MathPow(var_B,1.0/2.4))-0.055;
   else
      var_B=12.92*var_B;
//---
   oR =var_R*255.0;
   oG =var_G*255.0;
   oB =var_B*255.0;
  }
//+------------------------------------------------------------------+
//| Преобразование XYZ в Yxy                                         |
//+------------------------------------------------------------------+
void CColors::XYZtoYxy(const double aX,const double aY,const double aZ,double &oY,double &ox,double &oy)
  {
   oY =aY;
   ox =aX/(aX+aY+aZ);
   oy =aY/(aX+aY+aZ);
  }
//+------------------------------------------------------------------+
//| Преобразование Yxy в XYZ                                         |
//+------------------------------------------------------------------+
void CColors::YxyToXYZ(const double aY,const double ax,const double ay,double &oX,double &oY,double &oZ)
  {
   oX =ax*(aY/ay);
   oY =aY;
   oZ =(1.0-ax-ay)*(aY/ay);
  }
//+------------------------------------------------------------------+
//| Преобразование XYZ в HunterLab                                   |
//+------------------------------------------------------------------+
void CColors::XYZtoHunterLab(const double aX,const double aY,const double aZ,double &oL,double &oa,double &ob)
  {
   oL =10.0*::MathSqrt(aY);
   oa =17.5*(((1.02*aX)-aY)/::MathSqrt(aY));
   ob =7.0*((aY-(0.847*aZ))/::MathSqrt(aY));
  }
//+------------------------------------------------------------------+
//| Преобразование HunterLab в XYZ                                   |
//+------------------------------------------------------------------+
void CColors::HunterLabToXYZ(const double aL,const double aa,const double ab,double &oX,double &oY,double  &oZ)
  {
   double var_Y =aL/10.0;
   double var_X =aa/17.5*aL/10.0;
   double var_Z =ab/7.0*aL/10.0;
//---
   oY =::MathPow(var_Y,2);
   oX =(var_X+oY)/1.02;
   oZ =-(var_Z-oY)/0.847;
  }
//+------------------------------------------------------------------+
//| Преобразование XYZ в CIELab                                      |
//+------------------------------------------------------------------+
void CColors::XYZtoCIELab(const double aX,const double aY,const double aZ,double &oCIEL,double &oCIEa,double &oCIEb)
  {
   double ref_X =95.047;
   double ref_Y =100.0;
   double ref_Z =108.883;
   double var_X =aX/ref_X;
   double var_Y =aY/ref_Y;
   double var_Z =aZ/ref_Z;
//---
   if(var_X>0.008856)
      var_X=::MathPow(var_X,1.0/3.0);
   else
      var_X=(7.787*var_X)+(16.0/116.0);
//---
   if(var_Y>0.008856)
      var_Y=::MathPow(var_Y,1.0/3.0);
   else
      var_Y=(7.787*var_Y)+(16.0/116.0);
//---
   if(var_Z>0.008856)
      var_Z=::MathPow(var_Z,1.0/3.0);
   else
      var_Z=(7.787*var_Z)+(16.0/116.0);
//---
   oCIEL =(116.0*var_Y)-16.0;
   oCIEa =500.0*(var_X-var_Y);
   oCIEb =200*(var_Y-var_Z);
  }
//+------------------------------------------------------------------+
//| Преобразование CIELab в ToXYZ                                    |
//+------------------------------------------------------------------+
void CColors::CIELabToXYZ(const double aCIEL,const double aCIEa,const double aCIEb,double &oX,double &oY,double &oZ)
  {
   double var_Y =(aCIEL+16.0)/116.0;
   double var_X =aCIEa/500.0+var_Y;
   double var_Z =var_Y-aCIEb/200.0;
//---
   if(::MathPow(var_Y,3)>0.008856)
      var_Y=::MathPow(var_Y,3);
   else
      var_Y=(var_Y-16.0/116.0)/7.787;
//---
   if(::MathPow(var_X,3)>0.008856)
      var_X=::MathPow(var_X,3);
   else
      var_X=(var_X-16.0/116.0)/7.787;
//---
   if(::MathPow(var_Z,3)>0.008856)
      var_Z=::MathPow(var_Z,3);
   else
      var_Z=(var_Z-16.0/116.0)/7.787;
//---
   double ref_X =95.047;
   double ref_Y =100.0;
   double ref_Z =108.883;
//---
   oX =ref_X*var_X;
   oY =ref_Y*var_Y;
   oZ =ref_Z*var_Z;
  }
//+------------------------------------------------------------------+
//| Преобразование CIELab в CIELCH                                   |
//+------------------------------------------------------------------+
void CColors::CIELabToCIELCH(const double aCIEL,const double aCIEa,const double aCIEb,double &oCIEL,double &oCIEC,double &oCIEH)
  {
   double var_H=this.Arctan2(aCIEb,aCIEa);
//---
   if(var_H>0)
      var_H=(var_H/M_PI)*180.0;
   else
      var_H=360.0-(::MathAbs(var_H)/M_PI)*180.0;
//---
   oCIEL =aCIEL;
   oCIEC =::MathSqrt(::MathPow(aCIEa,2)+::MathPow(aCIEb,2));
   oCIEH =var_H;
  }
//+------------------------------------------------------------------+
//| Преобразование CIELCH в CIELab                                   |
//+------------------------------------------------------------------+
void CColors::CIELCHtoCIELab(const double aCIEL,const double aCIEC,const double aCIEH,double &oCIEL,double &oCIEa,double &oCIEb)
  {
//--- Аргументы from 0 to 360°
   oCIEL =aCIEL;
   oCIEa =::MathCos(M_PI*aCIEH/180.0)*aCIEC;
   oCIEb =::MathSin(M_PI*aCIEH/180)*aCIEC;
  }
//+------------------------------------------------------------------+
//| Преобразование XYZ в CIELuv                                      |
//+------------------------------------------------------------------+
void CColors::XYZtoCIELuv(const double aX,const double aY,const double aZ,double &oCIEL,double &oCIEu,double &oCIEv)
  {
   double var_U =(4.0*aX)/(aX+(15.0*aY)+(3.0*aZ));
   double var_V =(9.0*aY)/(aX+(15.0*aY)+(3.0*aZ));
   double var_Y =aY/100.0;
//---
   if(var_Y>0.008856)
      var_Y=::MathPow(var_Y,1.0/3.0);
   else
      var_Y=(7.787*var_Y)+(16.0/116.0);
//---
   double ref_X =95.047;
   double ref_Y =100.000;
   double ref_Z =108.883;
   double ref_U =(4.0*ref_X)/(ref_X+(15.0*ref_Y)+(3.0*ref_Z));
   double ref_V =(9.0*ref_Y)/(ref_X+(15.0*ref_Y)+(3.0*ref_Z));
//---
   oCIEL =(116.0*var_Y)-16.0;
   oCIEu =13.0*oCIEL*(var_U-ref_U);
   oCIEv =13.0*oCIEL*(var_V-ref_V);
  }
//+------------------------------------------------------------------+
//| Преобразование CIELuv в XYZ                                      |
//+------------------------------------------------------------------+
void CColors::CIELuvToXYZ(const double aCIEL,const double aCIEu,const double aCIEv,double &oX,double &oY,double &oZ)
  {
   double var_Y=(aCIEL+16.0)/116.0;
//---
   if(::MathPow(var_Y,3)>0.008856)
      var_Y=::MathPow(var_Y,3);
   else
      var_Y=(var_Y-16.0/116.0)/7.787;
//---
   double ref_X =95.047;
   double ref_Y =100.000;
   double ref_Z =108.883;
   double ref_U =(4.0*ref_X)/(ref_X+(15.0*ref_Y)+(3.0*ref_Z));
   double ref_V =(9.0*ref_Y)/(ref_X+(15.0*ref_Y)+(3.0*ref_Z));
   double var_U =aCIEu/(13.0*aCIEL)+ref_U;
   double var_V =aCIEv/(13.0*aCIEL)+ref_V;
//---
   oY=var_Y*100.0;
   oX=-(9.0*oY*var_U)/((var_U-4.0)*var_V-var_U*var_V);
   oZ=(9.0*oY-(15.0*var_V*oY)-(var_V*oX))/(3.0*var_V);
  }
//+------------------------------------------------------------------+
//| Преобразование RGB в HSL                                         |
//+------------------------------------------------------------------+
void CColors::RGBtoHSL(const double aR,const double aG,const double aB,double &oH,double &oS,double &oL)
  {
   double var_R   =(aR/255);
   double var_G   =(aG/255);
   double var_B   =(aB/255);
   double var_Min =::MathMin(var_R,::MathMin(var_G,var_B));
   double var_Max =::MathMax(var_R,::MathMax(var_G,var_B));
   double del_Max =var_Max-var_Min;
//---
   oL=(var_Max+var_Min)/2;
//---
   if(del_Max==0)
     {
      oH=0;
      oS=0;
     }
   else
     {
      if(oL<0.5)
         oS=del_Max/(var_Max+var_Min);
      else
         oS=del_Max/(2.0-var_Max-var_Min);
      //---
      double del_R =(((var_Max-var_R)/6.0)+(del_Max/2.0))/del_Max;
      double del_G =(((var_Max-var_G)/6.0)+(del_Max/2.0))/del_Max;
      double del_B =(((var_Max-var_B)/6.0)+(del_Max/2.0))/del_Max;
      //---
      if(var_R==var_Max)
         oH=del_B-del_G;
      else if(var_G==var_Max)
         oH=(1.0/3.0)+del_R-del_B;
      else if(var_B==var_Max)
         oH=(2.0/3.0)+del_G-del_R;
      //---
      if(oH<0)
         oH+=1.0;
      //---
      if(oH>1)
         oH-=1.0;
     }
  }
//+------------------------------------------------------------------+
//| Преобразование HSL в RGB                                         |
//+------------------------------------------------------------------+
void CColors::HSLtoRGB(const double aH,const double aS,const double aL,double &oR,double &oG,double &oB)
  {
   if(aS==0)
     {
      oR=aL*255;
      oG=aL*255;
      oB=aL*255;
     }
   else
     {
      double var_2=0.0;
      //---
      if(aL<0.5)
         var_2=aL*(1.0+aS);
      else
         var_2=(aL+aS)-(aS*aL);
      //---
      double var_1=2.0*aL-var_2;
      oR =255.0*Hue_To_RGB(var_1,var_2,aH+(1.0/3.0));
      oG =255.0*Hue_To_RGB(var_1,var_2,aH);
      oB =255.0*Hue_To_RGB(var_1,var_2,aH-(1.0/3.0));
     }
  }
//+------------------------------------------------------------------+
//| Преобразование RGB в HSV                                         |
//+------------------------------------------------------------------+
void CColors::RGBtoHSV(const double aR,const double aG,const double aB,double &oH,double &oS,double &oV)
  {
   const double var_R   =(aR/255.0);
   const double var_G   =(aG/255.0);
   const double var_B   =(aB/255.0);
   const double var_Min =::MathMin(var_R,::MathMin(var_G, var_B));
   const double var_Max =::MathMax(var_R,::MathMax(var_G,var_B));
   const double del_Max =var_Max-var_Min;
//---
   oV=var_Max;
//---
   if(del_Max==0)
     {
      oH=0;
      oS=0;
     }
   else
     {
      oS=del_Max/var_Max;
      const double del_R =(((var_Max-var_R)/6.0)+(del_Max/2))/del_Max;
      const double del_G =(((var_Max-var_G)/6.0)+(del_Max/2))/del_Max;
      const double del_B =(((var_Max-var_B)/6.0)+(del_Max/2))/del_Max;
      //---
      if(var_R==var_Max)
         oH=del_B-del_G;
      else if(var_G==var_Max)
         oH=(1.0/3.0)+del_R-del_B;
      else if(var_B==var_Max)
         oH=(2.0/3.0)+del_G-del_R;
      //---
      if(oH<0)
         oH+=1.0;
      //---
      if(oH>1.0)
         oH-=1.0;
     }
  }
//+------------------------------------------------------------------+
//| Преобразование HSV в RGB                                         |
//+------------------------------------------------------------------+
void CColors::HSVtoRGB(const double aH,const double aS,const double aV,double &oR,double &oG,double &oB)
  {
   if(aS==0)
     {
      oR =aV*255.0;
      oG =aV*255.0;
      oB =aV*255.0;
     }
   else
     {
      double var_h=aH*6.0;
      //---
      if(var_h==6)
         var_h=0;
      //---
      int    var_i =int(var_h);
      double var_1 =aV*(1.0-aS);
      double var_2 =aV*(1.0-aS*(var_h-var_i));
      double var_3 =aV*(1.0-aS*(1.0-(var_h-var_i)));
      double var_r =0.0;
      double var_g =0.0;
      double var_b =0.0;
      //---
      if(var_i==0)
        {
         var_r =aV;
         var_g =var_3;
         var_b =var_1;
        }
      else if(var_i==1.0)
        {
         var_r=var_2;
         var_g=aV;
         var_b=var_1;
        }
      else if(var_i==2.0)
        {
         var_r=var_1;
         var_g=aV;
         var_b=var_3;
        }
      else if(var_i==3)
        {
         var_r=var_1;
         var_g=var_2;
         var_b=aV;
        }
      else if(var_i==4)
        {
         var_r=var_3;
         var_g=var_1;
         var_b=aV;
        }
      else
        {
         var_r=aV;
         var_g=var_1;
         var_b=var_2;
        }
      //---
      oR =var_r*255.0;
      oG =var_g*255.0;
      oB =var_b*255.0;
     }
  }
//+------------------------------------------------------------------+
//| Преобразование RGB в CMY                                         |
//+------------------------------------------------------------------+
void CColors::RGBtoCMY(const double aR,const double aG,const double aB,double &oC,double &oM,double &oY)
  {
   oC =1.0-(aR/255.0);
   oM =1.0-(aG/255.0);
   oY =1.0-(aB/255.0);
  }
//+------------------------------------------------------------------+
//| Преобразование CMY в RGB                                         |
//+------------------------------------------------------------------+
void CColors::CMYtoRGB(const double aC,const double aM,const double aY,double &oR,double &oG,double &oB)
  {
   oR =(1.0-aC)*255.0;
   oG =(1.0-aM)*255.0;
   oB =(1.0-aY)*255.0;
  }
//+------------------------------------------------------------------+
//| Преобразование CMY в CMYK                                        |
//+------------------------------------------------------------------+
void CColors::CMYtoCMYK(const double aC,const double aM,const double aY,double &oC,double &oM,double &oY,double &oK)
  {
   double var_K=1;
//---
   if(aC<var_K)
      var_K=aC;
   if(aM<var_K)
      var_K=aM;
   if(aY<var_K)
      var_K=aY;
//---
   if(var_K==1.0)
     {
      oC =0;
      oM =0;
      oY =0;
     }
   else
     {
      oC =(aC-var_K)/(1.0-var_K);
      oM =(aM-var_K)/(1.0-var_K);
      oY =(aY-var_K)/(1.0-var_K);
     }
//---
   oK=var_K;
  }
//+------------------------------------------------------------------+
//| Преобразование CMYK в CMY                                        |
//+------------------------------------------------------------------+
void CColors::CMYKtoCMY(const double aC,const double aM,const double aY,const double aK,double &oC,double &oM,double &oY)
  {
   oC =(aC*(1.0-aK)+aK);
   oM =(aM*(1.0-aK)+aK);
   oY =(aY*(1.0-aK)+aK);
  }
//+------------------------------------------------------------------+
//| Получение значений компонентов RGB                               |
//+------------------------------------------------------------------+
void CColors::ColorToRGB(const color aColor,double &aR,double &aG,double &aB)
  {
   aR =GetR(aColor);
   aG =GetG(aColor);
   aB =GetB(aColor);
  }
//+------------------------------------------------------------------+
//| Получение значения компонента R                                  |
//+------------------------------------------------------------------+
double CColors::GetR(const color aColor)
  {
   return(aColor&0xff);
  }
//+------------------------------------------------------------------+
//| Получение значения компонента G                                  |
//+------------------------------------------------------------------+
double CColors::GetG(const color aColor)
  {
   return((aColor>>8)&0xff);
  }
//+------------------------------------------------------------------+
//| Получение значения компонента B                                  |
//+------------------------------------------------------------------+
double CColors::GetB(const color aColor)
  {
   return((aColor>>16)&0xff);
  }
//+------------------------------------------------------------------+
//| Преобразование RGB в const color                                 |
//+------------------------------------------------------------------+
color CColors::RGBToColor(const double aR,const double aG,const double aB)
  {
   int int_r =(int)::MathRound(aR);
   int int_g =(int)::MathRound(aG);
   int int_b =(int)::MathRound(aB);
   int Color =0;
//---
   Color=int_b;
   Color<<=8;
   Color|=int_g;
   Color<<=8;
   Color|=int_r;
//---
   return((color)Color);
  }
//+------------------------------------------------------------------+
//| Получение значени промежуточного цвета между двух цветов         |
//+------------------------------------------------------------------+
color CColors::MixColors(const color aCol1,const color aCol2,const double aK)
  {
//--- aK - от 0 до 1
   double R1=0.0,G1=0.0,B1=0.0,R2=0.0,G2=0.0,B2=0.0;
//---
   ColorToRGB(aCol1,R1,G1,B1);
   ColorToRGB(aCol2,R2,G2,B2);
//---
   R1+=(int)::MathRound(aK*(R2-R1));
   G1+=(int)::MathRound(aK*(G2-G1));
   B1+=(int)::MathRound(aK*(B2-B1));
//---
   return(RGBToColor(R1,G1,B1));
  }
//+------------------------------------------------------------------+
//| Получение массива заданного размера с цветовым градиентом        |
//+------------------------------------------------------------------+
void CColors::Gradient(color &aColors[],   // Список цветов
                       color &aOut[],      // Возвращаемый массив
                       int   aOutCount,    // Установка размера возвращаемого массива
                       bool  aCycle=false) // Замкнутый цикл. Возвращаемый массив заканчивается таким же цветом, с которого начинается
  {
   ::ArrayResize(aOut,aOutCount);
//---
   int    InCount =::ArraySize(aColors)+aCycle;
   int    PrevJ   =0;
   int    nci     =0;
   double K       =0.0;
//---
   for(int i=1; i<InCount; i++)
     {
      int J=(aOutCount-1)*i/(InCount-1);
      //---
      for(int j=PrevJ; j<=J; j++)
        {
         if(aCycle && i==InCount-1)
           {
            nci =0;
            K   =1.0*(j-PrevJ)/(J-PrevJ+1);
           }
         else
           {
            nci =i;
            K   =1.0*(j-PrevJ)/(J-PrevJ);
           }
         aOut[j]=MixColors(aColors[i-1],aColors[nci],K);
        }
      PrevJ=J;
     }
  }
//+------------------------------------------------------------------+
//| Еще один вариант преобразования RGB в XYZ и                      |
//| соответствующее ему преобразование XYZ в RGB                     |
//+------------------------------------------------------------------+
void CColors::RGBtoXYZsimple(double aR,double aG,double aB,double &oX,double &oY,double &oZ)
  {
   aR/=255;
   aG/=255;
   aB/=255;
   aR*=100;
   aG*=100;
   aB*=100;
//---
   oX=0.431*aR+0.342*aG+0.178*aB;
   oY=0.222*aR+0.707*aG+0.071*aB;
   oZ=0.020*aR+0.130*aG+0.939*aB;
  }
//+------------------------------------------------------------------+
//| XYZtoRGBsimple                                                   |
//+------------------------------------------------------------------+
void CColors::XYZtoRGBsimple(const double aX,const double aY,const double aZ,double &oR,double &oG,double &oB)
  {
   oR=3.063*aX-1.393*aY-0.476*aZ;
   oG=-0.969*aX+1.876*aY+0.042*aZ;
   oB=0.068*aX-0.229*aY+1.069*aZ;
  }
//+------------------------------------------------------------------+
//| Негативный цвет                                                  |
//+------------------------------------------------------------------+
color CColors::Negative(const color aColor)
  {
   double R=0.0,G=0.0,B=0.0;
   ColorToRGB(aColor,R,G,B);
//---
   return(RGBToColor(255-R,255-G,255-B));
  }
//+------------------------------------------------------------------+
//| Поиск наиболее похожего цвета                                    |
//| в наборе стандартных цветов терминала                            |
//+------------------------------------------------------------------+
color CColors::StandardColor(const color aColor,int &aIndex)
  {
   color m_c[]=
     {
      clrBlack,clrDarkGreen,clrDarkSlateGray,clrOlive,clrGreen,clrTeal,clrNavy,clrPurple,clrMaroon,clrIndigo,
      clrMidnightBlue,clrDarkBlue,clrDarkOliveGreen,clrSaddleBrown,clrForestGreen,clrOliveDrab,clrSeaGreen,
      clrDarkGoldenrod,clrDarkSlateBlue,clrSienna,clrMediumBlue,clrBrown,clrDarkTurquoise,clrDimGray,
      clrLightSeaGreen,clrDarkViolet,clrFireBrick,clrMediumVioletRed,clrMediumSeaGreen,clrChocolate,clrCrimson,
      clrSteelBlue,clrGoldenrod,clrMediumSpringGreen,clrLawnGreen,clrCadetBlue,clrDarkOrchid,clrYellowGreen,
      clrLimeGreen,clrOrangeRed,clrDarkOrange,clrOrange,clrGold,clrYellow,clrChartreuse,clrLime,clrSpringGreen,
      clrAqua,clrDeepSkyBlue,clrBlue,clrFuchsia,clrRed,clrGray,clrSlateGray,clrPeru,clrBlueViolet,clrLightSlateGray,
      clrDeepPink,clrMediumTurquoise,clrDodgerBlue,clrTurquoise,clrRoyalBlue,clrSlateBlue,clrDarkKhaki,clrIndianRed,
      clrMediumOrchid,clrGreenYellow,clrMediumAquamarine,clrDarkSeaGreen,clrTomato,clrRosyBrown,clrOrchid,
      clrMediumPurple,clrPaleVioletRed,clrCoral,clrCornflowerBlue,clrDarkGray,clrSandyBrown,clrMediumSlateBlue,
      clrTan,clrDarkSalmon,clrBurlyWood,clrHotPink,clrSalmon,clrViolet,clrLightCoral,clrSkyBlue,clrLightSalmon,
      clrPlum,clrKhaki,clrLightGreen,clrAquamarine,clrSilver,clrLightSkyBlue,clrLightSteelBlue,clrLightBlue,
      clrPaleGreen,clrThistle,clrPowderBlue,clrPaleGoldenrod,clrPaleTurquoise,clrLightGray,clrWheat,clrNavajoWhite,
      clrMoccasin,clrLightPink,clrGainsboro,clrPeachPuff,clrPink,clrBisque,clrLightGoldenrod,clrBlanchedAlmond,
      clrLemonChiffon,clrBeige,clrAntiqueWhite,clrPapayaWhip,clrCornsilk,clrLightYellow,clrLightCyan,clrLinen,
      clrLavender,clrMistyRose,clrOldLace,clrWhiteSmoke,clrSeashell,clrIvory,clrHoneydew,clrAliceBlue,clrLavenderBlush,
      clrMintCream,clrSnow,clrWhite,clrDarkCyan,clrDarkRed,clrDarkMagenta,clrAzure,clrGhostWhite,clrFloralWhite
     };
//---
   double m_rv=0.0,m_gv=0.0,m_bv=0.0;
//---
   ColorToRGB(aColor,m_rv,m_gv,m_bv);
//---
   double m_md=0.3*::MathPow(255,2)+0.59*::MathPow(255,2)+0.11*::MathPow(255,2)+1;
   aIndex=0;
//---
   for(int i=0; i<138; i++)
     {
      double m_d=0.3*::MathPow(GetR(m_c[i])-m_rv,2)+0.59*::MathPow(GetG(m_c[i])-m_gv,2)+0.11*::MathPow(GetB(m_c[i])-m_bv,2);
      //---
      if(m_d<m_md)
        {
         m_md   =m_d;
         aIndex =i;
        }
     }
//---
   return(m_c[aIndex]);
  }
//+------------------------------------------------------------------+
//| Преобразование в серый цвет                                      |
//+------------------------------------------------------------------+
double CColors::RGBtoGray(double aR,double aG,double aB)
  {
   aR/=255;
   aG/=255;
   aB/=255;
//---
   aR=::MathPow(aR,2.2);
   aG=::MathPow(aG,2.2);
   aB=::MathPow(aB,2.2);
//---
   double rY=0.21*aR+0.72*aG+0.07*aB;
   rY=::MathPow(rY,1.0/2.2);
//---
   return(rY);
  }
//+------------------------------------------------------------------+
//| Простое преобразование в серый цвет                              |
//+------------------------------------------------------------------+
double CColors::RGBtoGraySimple(double aR,double aG,double aB)
  {
   aR/=255;
   aG/=255;
   aB/=255;
   double rY=0.3*aR+0.59*aG+0.11*aB;
//---
   return(rY);
  }
//+------------------------------------------------------------------+
