/**
LETTER
2012-2019
v 1.5.2
*/
//GEOMERATIVE
import geomerative.*;

class Letter extends Romanesco {
  public Letter() {
    item_name = "Letter" ;
    item_author  = "Stan le Punk";
    item_version = "Version 1.5.2";
    item_pack = "Base 2012-2019" ;

    item_costume = "Point/Line/Triangle";
    item_mode = "";
    // define slider
    hue_fill_is = true;
    sat_fill_is = true;
    bright_fill_is = true;
    alpha_fill_is = true;
    hue_stroke_is = true;
    sat_stroke_is = true;
    bright_stroke_is = true;
    alpha_stroke_is = true;
    thickness_is = true;
    size_x_is = true;
    // size_y_is = true;
    // size_z_is = true;
    // diameter_is = true;
    // canvas_x_is = true;
    // canvas_y_is = true;
    // canvas_z_is = true;

    // frequence_is = true;
    speed_x_is = true;
    // speed_y_is = true;
    // speed_z_is = true;
    // spurt_x_is = true;
    // spurt_y_is = true;
    // spurt_z_is = true;
    // dir_x_is = true;
    // dir_y_is = true;
    // dir_z_is = true;
    jit_x_is = true;
    jit_y_is = true;
    jit_z_is = true;
    // swing_x_is = true;
    // swing_y_is = true;
    // swing_z_is = true;

    quantity_is = true;
    // variety_is = true;
    // life_is = true;
    // flow_is = true;
    // quality_is = true;
    // area_is = true;
    // angle_is = true;
    // scope_is = true;
    // scan_is = true;
    // align_is = true;
    // repulsion_is = true;
    // attraction_is = true;
    // density_is = true;
    // influence_is = true;
    // calm_is = true;
    // spectrum_is = true;
  }
  //GLOBAL
  RFont r_font;
  RShape r_grp;
  
  int sizeRef, sizeFont ;
  String sentenceRef = ("") ; 
  String pathRef = ("") ;
 
  int whichLetter ;
  int axeLetter ;
  int startDirection = -1 ;
  int numLetter ;

  
  //SETUP
  void setup() {
    set_item_pos(width/2,height/2,0);
    geomerative.RG.init(papplet); // Geomerative
  }
  
  
  
  
  //DRAW
  float speed = 0 ;
  String sentence;
  void draw() {
    load_txt(ID_item) ;
    // test the font is a ttf or not
    boolean warning_font = false;
    if(!get_font_type().equals("ttf") && !get_font_type().equals("TTF")) {
      select_font_type("ttf");
      warning_font = true;
    }

    sizeFont = int(map(get_size_x().value(),get_size_x().min(), get_size_x().max(), (float)height *.01, (float)height *.7));
    int max_string = 49;
    if(get_text().length() < max_string) max_string = get_text().length();
    sentence = get_text().substring(0,max_string);
    

    //check if something change to update the RG.getText
    boolean reset = false;
    boolean reset_font = false;

    if (sizeRef != sizeFont || !sentenceRef.equals(sentence) || !pathRef.equals(get_font_path())) {
      sizeRef = sizeFont;
      sentenceRef = (sentence);
      pathRef = get_font_path();
      reset = true;
      reset_font = true;
    } else if(birth_is()) {
      reset = true; 
      birth_is(false);
    } 

    update(reset,reset_font);

    // INFO
    String warning_font_type = "font type accepted is TTF";
    if(warning_font) warning_font_type = "font type is not TTF, instead class Letter use a first TTF from library";
    info("Quantity of letter display:",numLetter," - Speed:",int(speed*100),"font",get_font_name(),warning_font_type);

  }


  void update(boolean reset,boolean reset_font) {
    if(r_grp == null) {
      r_grp = geomerative.RG.getText(sentence,get_font_path(),(int)sizeFont,CENTER);
    }
    if(reset || reset_font) {
      r_grp = geomerative.RG.getText(sentence,get_font_path(),(int)sizeFont,CENTER);
      axeLetter = int(random (r_grp.countChildren()));
    }

    if(reverse_is()) {
      int choiceDir = floor(random(2));
      if(choiceDir == 0 ) {
        startDirection = -1; 
      } else {
        startDirection = 1;
      }
    }
    
    if(all_transient(ID_item) > 10 || key_n ) {
      axeLetter = int(random (r_grp.countChildren())) ;
    }

    /////////
    //ENGINE
    if(motion_is()) {
      if(sound_is()) {
        speed = map(get_speed_x().normal() *get_speed_x().normal(),0,1,0.,.3) *tempo_rom[ID_item];
      } else {
        speed = map(get_speed_x().normal()*get_speed_x().normal(),0,1,0.,.1);
      } 
    } else {
      speed = 0;
    }
    //to stop the move
    //if (!action_is()) speed = 0.0 ; 
    if(reverse_is()) speed = -speed ;
    
    //num letter to display
    numLetter = (int)map(get_quantity().value(),get_quantity().min(),get_quantity().max(), 0,r_grp.countChildren() +1) ;
    
    //DISPLAY
    // thickness
    float thicknessLetter = map(get_thickness().value(),get_thickness().min(),get_thickness().max(), 0.1, height /10) ; ;

    // color
    if(get_costume().get_type() != TRIANGLE) {
      noFill() ; 
      stroke(get_fill()) ; 
      strokeWeight(thicknessLetter) ;
    } else {
      fill(get_fill()) ; 
      stroke(get_stroke()) ; 
      strokeWeight(thicknessLetter) ;
    }
    //jitter
    // float jitterX = map(get_jitter_x(),0,1, 0, (float)width *.1) ;
    // float jitterY = map(get_jitter_y(),0,1, 0, (float)width *.1) ;
    // float jitterZ = map(get_jitter_z(),0,1, 0, (float)width *.1) ;
    // vec3 jitter = vec3(jitterX *jitterX, jitterY *jitterY, jitterZ *jitterZ) ;
    vec3 jitter = map(get_jitter(),get_jitter_x().min(),get_jitter_x().max(),0,width*.1);
    jitter.pow(2);

    letters(speed, axeLetter, jitter) ;
    //END YOUR WORK

  }
  
  
  // ANNEXE
  float rotation ;
  
  void letters(float speed, int axeLetter, vec3 jttr) {
    if (sound_is()) {
      whichLetter = (int)all_transient(ID_item) ; 
    } else {
      whichLetter = 0 ;
    }
    
    //security against the array out bounds
    if(whichLetter < 0 ) {
      whichLetter = 0 ; 
    } else if (whichLetter >= r_grp.countChildren()) {
      whichLetter = r_grp.countChildren() -1  ;
    }

    wheelLetter(numLetter, speed, jttr) ;

    
    if(axeLetter < 0 ) {
      axeLetter = 0 ; 
    } else if (axeLetter >= r_grp.countChildren()) {
      axeLetter = r_grp.countChildren() - 1 ;
    }
    displayLetter(axeLetter,jttr);
  }





  
  int whichOneChangeDirection = 1 ;
  
  void wheelLetter(int num, float speed, vec3 jttr) {
    // direction rotation for each one
    if(frameCount%160 == 0 || key_n) whichOneChangeDirection = round(random(1,num)) ;
    //position
    for (int i = 0 ; i < num ; i++) {
      int targetLetter ;
      targetLetter = whichLetter +i ;
      if (targetLetter < r_grp.countChildren() ) {
        if(i%whichOneChangeDirection == 0 ) {
          speed  = speed *-1  ;
        }
        speed = speed *startDirection ;
        if(speed != 0) {
          r_grp.children[targetLetter].rotate(speed, r_grp.children[axeLetter].getCenter());
        }
        displayLetter(targetLetter,jttr);
      }
    }
  }
  
  void displayLetter(int which, vec3 ampJttr) {
    RPoint[] pnts = r_grp.children[which].getPoints(); 
    vec3 [] points = geomerativeFontPoints(pnts);

    for (int i = 0; i < points.length; i++) {
      points[i].add(jitterPVector(ampJttr));
      float factor = 40.;
      points[i].z = points[i].z +(all_transient(ID_item) *factor); 
      if(get_costume().get_type() == POINT) point(points[i]);
      if(get_costume().get_type() == LINE) if(i > 0 ) line( points[i-1],points[i]);
      if(get_costume().get_type() == TRIANGLE) if(i > 1 ) {
        beginShape();
        vertex(points[i-2]);
        vertex(points[i-1]);
        vertex(points[i]);
        endShape(CLOSE);
        // triangle(points[i-2].x, points[i-2].y, points[i-2].z,   points[i-1].x, points[i-1].y, points[i-1].z, points[i].x, points[i].y, points[i].z );
      }
      
    }
  }
  
  //ANNEXE VOID
  //jitter for PVector points
  vec3 jitterPVector(vec3 range) {
    float factor = 0.0 ;
    if(sound_is()) factor = 2.0 ; else factor = .1;
    int rangeX = int(range.x *left[ID_item] *factor);
    int rangeY = int(range.y *right[ID_item] *factor);
    int rangeZ = int(range.z *mix[ID_item] *factor);
    vec3 jitting = vec3();
    jitting.x = random(-rangeX, rangeX);
    jitting.y = random(-rangeY, rangeY);
    jitting.z = random(-rangeZ, rangeZ);
    return jitting;
  }
  
  //void work with geomerative
  vec3 [] geomerativeFontPoints(RPoint[] p) {
    vec3 [] pts = new vec3[p.length] ;
    for(int i = 0 ; i < pts.length ; i++) {
      pts[i] = vec3();
      pts[i].x = p[i].x ; 
      pts[i].y = p[i].y ;  
    }
    return pts ;
  }
}
