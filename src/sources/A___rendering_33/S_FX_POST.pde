/**
FILTER
* 2018-2019
* v 0.1.5
* here is calling classic FX ROPE + FX FORCE FIELD
*/

/**
slider available
* "red",
* "green",
* "blue",
* "position X"
* "position Y
* "size X"
* "size Y"
* "strength X"
* "strength Y"
* "quantity"
* "quality"
* "speed"
* "angle"
* "threshold"
*/
ArrayList<FX> fx_filter_manager;


float sl_fx_color_x;
float sl_fx_color_y;
float sl_fx_color_z;
float sl_fx_pos_x;
float sl_fx_pos_y;
float sl_fx_size_x;
float sl_fx_size_y;
float sl_fx_strength_x;
float sl_fx_strength_y;
float sl_fx_quantity;
float sl_fx_quality;
float sl_fx_speed;
float sl_fx_angle;
float sl_fx_threshold;
void update_fx_filter_slider() {
  sl_fx_color_x = map(value_slider_fx_filter[0],0,MAX_VALUE_SLIDER,0,1);
  sl_fx_color_y = map(value_slider_fx_filter[1],0,MAX_VALUE_SLIDER,0,1);
  sl_fx_color_z = map(value_slider_fx_filter[2],0,MAX_VALUE_SLIDER,0,1);

  sl_fx_pos_x = map(value_slider_fx_filter[3],0,MAX_VALUE_SLIDER,0,1);
  sl_fx_pos_y = map(value_slider_fx_filter[4],0,MAX_VALUE_SLIDER,0,1);

  sl_fx_size_x = map(value_slider_fx_filter[5],0,MAX_VALUE_SLIDER,0,1);
  sl_fx_size_y = map(value_slider_fx_filter[6],0,MAX_VALUE_SLIDER,0,1);

  sl_fx_strength_x = map(value_slider_fx_filter[7],0,MAX_VALUE_SLIDER,0,1);
  sl_fx_strength_y = map(value_slider_fx_filter[8],0,MAX_VALUE_SLIDER,0,1);

  sl_fx_quantity = map(value_slider_fx_filter[9],0,MAX_VALUE_SLIDER,0,1);

  sl_fx_quality = map(value_slider_fx_filter[10],0,MAX_VALUE_SLIDER,0,1);

  sl_fx_speed = map(value_slider_fx_filter[11],0,MAX_VALUE_SLIDER,0,1);

  sl_fx_angle = map(value_slider_fx_filter[12],0,MAX_VALUE_SLIDER,0,1);

  sl_fx_threshold = map(value_slider_fx_filter[13],0,MAX_VALUE_SLIDER,0,1);
}









void init_fx_filter() {
  if(FULL_RENDERING) {
    fx_filter_manager = new ArrayList<FX>();

    // FORCE FIELD FX
    type_field = r.FLUID;
    pattern_field = r.BLANK;
    set_type_force_field(type_field);
    init_force_field();
    // set_different_force_field();
    println("init filter FORCE FIELD");
    // warp force
    init_warp_force();
    println("init filter FORCE WARP FX");


    // FX CLASSIC
    // set path fx shader;
    // set_fx_post_path(sketchpath()+"data/shader/fx_post/");
    // set_fx_post_path(preference_path+"shader/fx_post/");
    get_fx_post_path();
    if(fx_post_path_exist()) {
      println("FX FILTER shader loaded");
    } else {
      printErr("fx filter path",get_fx_post_path(),"don't exists");
    }

    setting_fx_filter(fx_filter_manager);

    // CLASSIC FX + FORCE FIELD FX
    write_fx_filter_index();
  }
}


boolean move_fx_filter;
boolean extra_fx_filter;
int num_special_fx_filter;
int ref_num_active_fx_filter;
ArrayList<Integer>active_fx_filter;
int fx_filter_classic_num;
void fx_filter() {
  move_fx_filter = fx_filter_button_is(1);
  extra_fx_filter = fx_filter_button_is(2);

  // add fx
  if(extra_fx_filter) {
    if(active_fx_filter == null) {
      active_fx_filter = new ArrayList<Integer>();
    }

    boolean add_fx_filter = true;
    if(active_fx_filter.size() > 0) {  
      for(Integer i : active_fx_filter) {
        if(i == which_fx_filter) {
          add_fx_filter = false;
          break;
        }
      }
    }
    if(add_fx_filter) {
      active_fx_filter.add(which_fx_filter);
    }
  }

  if(active_fx_filter != null) {
    if(reset_fx_filter_button_alert_is()) {
      active_fx_filter.clear();
    }
  }
  if(active_fx_filter != null && ref_num_active_fx_filter != active_fx_filter.size()) {
    save_dial_scene(preference_path);
    ref_num_active_fx_filter = active_fx_filter.size();
  }


  if(FULL_RENDERING && fx_filter_button_is(0)) {
    update_fx_filter_slider();
    update_fx_filter(fx_filter_manager);
    if(extra_fx_filter && active_fx_filter != null && active_fx_filter.size() > 0) {
      for(int i : active_fx_filter) {
        draw_fx_filter(i);
      }
    } else {
      draw_fx_filter(which_fx_filter);
    }
  } 
}



int which_current_movie;
boolean draw_fx_filter_before_rendering_is;
boolean draw_fx_filter_before_rendering_is() {
  return draw_fx_filter_before_rendering_is;
}

void draw_fx_filter(int which) {
  draw_fx_filter_before_rendering_is = false;
  // select fx 
  num_special_fx_filter = 1 ;
  if(which < num_special_fx_filter) {
    apply_force_field();
    warp_force(sl_fx_strength_x,sl_fx_speed,vec3(sl_fx_color_x,sl_fx_color_y,sl_fx_color_z));
   } else {
    int target = which- num_special_fx_filter; // min 1 cause the first one is a special one;
    for(int i = 0 ; i < fx_filter_classic_num ; i++) {
      if(target == i) {
        if(get_fx(fx_filter_manager,target).get_type() == FX_WARP_TEX_A) {
          if(fx_filter_pattern == null) {
            draw_fx_filter_pattern(16,16,2,RGB,true);
          } else {
            draw_fx_filter_pattern(16,16,2,RGB,reset_fx_filter_button_alert_is());
          }
          select_fx_post(g,get_fx_filter_pattern(0),get_fx_filter_pattern(1),get_fx(fx_filter_manager,target));
        } else if (get_fx(fx_filter_manager,target).get_type() == FX_DATAMOSH) {
          draw_fx_filter_before_rendering_is = true;
          if(movie[which_current_movie] == null) {
            for(int which_movie = 0 ; which_movie < rom_manager.size() ; which_movie++) {
              if(movie[which_movie] != null) {
                which_current_movie = which_movie;
                break;
              }
            }         
          } else {
            movie[which_current_movie].loop();
            select_fx_post(movie[which_current_movie],null,null,get_fx(fx_filter_manager,target));
          }
        } else {
          select_fx_post(g,null,null,get_fx(fx_filter_manager,target));
        }      
      }
    }
  }
}





/**
UTIL FILTER
*/
PImage [] fx_filter_pattern;
PImage get_fx_filter_pattern(int which) {
  if(fx_filter_pattern != null && which < fx_filter_pattern.length) {
    return fx_filter_pattern[which];
  } else {
    return null;
  }
}


void draw_fx_filter_pattern(int w, int h, int num, int mode, boolean event) {
  if(fx_filter_pattern == null || num < fx_filter_pattern.length) {
    fx_filter_pattern = new PImage[num];
  }
  for(int i = 0; i < fx_filter_pattern.length ; i++) {
    if(event || fx_filter_pattern[i] == null) {
      if(mode == RGB) {
        fx_filter_pattern[i] = generate_fx_filter_pattern(3,w,h); // warp RGB
      } else if(mode == GRAY) {
        fx_filter_pattern[i] = generate_fx_filter_pattern(0,w,h); // warp GRAY
      } 
    }
  }  
}


PGraphics generate_fx_filter_pattern(int mode, int sx, int sw) {
  vec3 inc = vec3(random(1)*random(1),random(1)*random(1),random(1)*random(1));
  if(mode == 0) {
    // black and white
    return pattern_noise(sx,sw,inc.x);
  } else if(mode == 3) {
    // rgb
    return pattern_noise(sx,sw,inc.array());
  } else return null;
}


void write_fx_filter_index() {
  processing.data.Table index_fx = new processing.data.Table();
  index_fx.addColumn("Name");
  index_fx.addColumn("Author");
  index_fx.addColumn("Version");
  index_fx.addColumn("Pack");
  index_fx.addColumn("Slider");
  

  int num = fx_filter_classic_num+1; // +1 cause of the special force field fx
  TableRow [] info_fx = new TableRow [num];

  for(int i = 0 ; i < info_fx.length ; i++) {
    info_fx[i] = index_fx.addRow();
  }

  info_fx[0].setString("Name","Force");
  info_fx[0].setString("Author","Stan le Punk");
  info_fx[0].setString("Version","0.1.0");
  info_fx[0].setString("Pack","Base 2014");


  for(int i = 0 ; i < fx_filter_classic_num ; i++) {
    FX fx = get_fx(fx_filter_manager,i); 
    int target = i+1;
    info_fx[target].setString("Name",fx.get_name());
    info_fx[target].setString("Author",fx.get_author());
    info_fx[target].setString("Version",fx.get_version());
    info_fx[target].setString("Pack",fx.get_pack());
    String s = "";
    int max =  fx.get_name_slider().length;
    for(int k = 0 ; k < max ; k++) {
      if(k < max - 1) {
        s += (fx.get_name_slider()[k]+"/");
      } else {
        s += (fx.get_name_slider()[k]);
      }
    }
    info_fx[target].setString("Slider",s);
  }
  saveTable(index_fx, preference_path+"index_fx.csv"); 

}













































/**
FX ROMANESCO
* classic FX class
* v 0.0.1
* 2019-2019
*/

void setting_fx_filter(ArrayList<FX> fx_list) {
  setting_fx_blur_circular(fx_list);
  setting_fx_blur_gaussian(fx_list);
  setting_fx_blur_radial(fx_list);

  setting_fx_datamosh(fx_list);

  setting_fx_dither_bayer(fx_list);

  setting_fx_haltone_dot(fx_list);
  setting_fx_haltone_line(fx_list);
  setting_fx_haltone_multi(fx_list);

  setting_fx_pixel(fx_list);

  setting_fx_split_rgb(fx_list);

  setting_fx_threshold(fx_list);

  setting_fx_warp_proc(fx_list);
  setting_fx_warp_tex(fx_list);
}

/**
* sl_fx_color_x;
* sl_fx_color_y;
* sl_fx_color_z;
* sl_fx_pos_x;
* sl_fx_pos_y;
* sl_fx_size_x;
* sl_fx_size_y;
* sl_fx_strength_x;
* sl_fx_strength_y;
* sl_fx_quantity;
* sl_fx_quality;
* sl_fx_speed;
* sl_fx_angle;
* sl_fx_threshold;
*/
vec3 mouse_fx_filter;
void update_fx_filter(ArrayList<FX> fx_list) {
  if(mouse_fx_filter == null) {
    mouse_fx_filter = vec3(.5,.5,0);
  }

  if(space_is()) {
    float norm_x = map(mouse[0].x(),get_render_canvas().x(),get_render_canvas().y(),0,1);
    float norm_y = map(mouse[0].y(),get_render_canvas().z(),get_render_canvas().w(),0,1);
    float norm_z = map(mouse[0].z(),get_render_canvas().e(),get_render_canvas().f(),0,1);
    mouse_fx_filter.set(norm_x,norm_y,norm_z);
  }

  update_fx_blur_circular(fx_list,move_fx_filter,sl_fx_quantity,sl_fx_strength_x);
  update_fx_blur_gaussian(fx_list,move_fx_filter,sl_fx_strength_x);
  update_fx_blur_radial(fx_list,move_fx_filter,mouse_fx_filter.xy(),sl_fx_strength_x);

  update_fx_datamosh(fx_list,move_fx_filter,sl_fx_strength_x,sl_fx_threshold,vec3(sl_fx_color_x,sl_fx_color_y,sl_fx_color_z));
  
  int mode_dither = 1 ; // rgb
  update_fx_dither_bayer(fx_list,move_fx_filter,vec3(sl_fx_color_x,sl_fx_color_y,sl_fx_color_z),mode_dither);
  
  update_fx_haltone_dot(fx_list,move_fx_filter,sl_fx_quantity,sl_fx_angle);
  update_fx_haltone_line(fx_list,move_fx_filter,mouse_fx_filter.xy(),sl_fx_quantity,sl_fx_angle);
  update_fx_haltone_multi(fx_list,move_fx_filter,sl_fx_color_x,sl_fx_color_y,mouse_fx_filter.xy(),sl_fx_quantity,sl_fx_angle,sl_fx_threshold);

  update_fx_pixel(fx_list,move_fx_filter,sl_fx_quantity,vec2(sl_fx_size_x,sl_fx_size_y),vec3(sl_fx_color_x,sl_fx_color_y,sl_fx_color_z));

  update_fx_split_rgb(fx_list,move_fx_filter,vec2(sl_fx_strength_x,sl_fx_strength_y),sl_fx_speed);
  
  int mode_threshold = 1; // rgb
  update_fx_threshold(fx_list,move_fx_filter,vec3(sl_fx_color_x,sl_fx_color_y,sl_fx_color_z),mode_threshold);
  
  update_fx_warp_proc(fx_list,move_fx_filter,sl_fx_strength_x,sl_fx_speed);
  update_fx_warp_tex(fx_list,move_fx_filter,sl_fx_strength_x);

}


/**
* blur circular
*/
String set_blur_circular = "blur circular";
void setting_fx_blur_circular(ArrayList<FX> fx_list) {
  String version = "0.0.1";
  int revision = 1;
  String author = "Stan le Punk";
  String pack = "Base 2019";
  String [] slider = {"quantity","strength X"};
  int id = fx_filter_classic_num;
  init_fx(fx_list,set_blur_circular,FX_BLUR_CIRCULAR,id,author,pack,version,revision,slider,null);
  fx_filter_classic_num++;
}

void update_fx_blur_circular(ArrayList<FX> fx_list, boolean move_is, float num, float str_x) {
  if(move_is) {
    int iteration = (int)map(num,0,1,2,64);
    fx_set_num(fx_list,set_blur_circular,iteration);

    int max_blur = width;
    float str = (str_x*str_x)*max_blur;
    fx_set_strength(fx_list,set_blur_circular,str);
  }
}



/**
* gaussian blur
*/
String set_blur_gaussian = "blur gaussian";
void setting_fx_blur_gaussian(ArrayList<FX> fx_list) {
  String version = "0.1.0";
  int revision = 3;
  String author = "Stan le Punk";
  String pack = "Base 2019";
  String [] slider = {"strength X"};
  int id = fx_filter_classic_num;
  init_fx(fx_list,set_blur_gaussian,FX_BLUR_GAUSSIAN,id,author,pack,version,revision,slider,null);
  fx_filter_classic_num++;
}

void update_fx_blur_gaussian(ArrayList<FX> fx_list, boolean move_is, float strength_x) {
  if(move_is) {
    int max_blur = height/10;
    float str = strength_x*max_blur;
    fx_set_strength(fx_list,set_blur_gaussian,str);
  }
}




/**
* blur radial
*/
String set_blur_radial = "blur radial";
void setting_fx_blur_radial(ArrayList<FX> fx_list) {
  String version = "0.0.1";
  int revision = 1;
  String author = "Stan le Punk";
  String pack = "Base 2019";
  String [] slider = {"strength X"};
  int id = fx_filter_classic_num;
  init_fx(fx_list,set_blur_radial,FX_BLUR_RADIAL,id,author,pack,version,revision,slider,null);
  fx_filter_classic_num++;
}

void update_fx_blur_radial(ArrayList<FX> fx_list, boolean move_is, vec2 pos,float strength) {
  if(move_is) {
    fx_set_pos(fx_list,set_blur_radial,pos.x,pos.y);
        
    float str = (strength*strength)*(height/20);
    fx_set_strength(fx_list,set_blur_radial,str);
  }
}




/**
* datamosh
*/
String set_datamosh = "datamosh";
void setting_fx_datamosh(ArrayList<FX> fx_list) {
  String version = "0.0.1";
  int revision = 1;
  String author = "Alexandre Rivaux refactoring by Stan le Punk";
  String pack = "Base 2019";
  String [] slider = {"red","green","blue","strength X","threshold"};
  int id = fx_filter_classic_num;
  init_fx(fx_list,set_datamosh,FX_DATAMOSH,id,author,pack,version,revision,slider,null);
  fx_filter_classic_num++;
}

void update_fx_datamosh(ArrayList<FX> fx_list, boolean move_is, float strength, float threshold, vec3 colour) {
  if(move_is) {
    fx_set_strength(fx_list,set_datamosh, map(strength,0,1,-100,100));
    fx_set_threshold(fx_list,set_datamosh, (1.0 -threshold) *0.1);
    vec2 offset_red = vec2(-colour.red(), colour.red()).mult(.1);
    vec2 offset_green = vec2(-colour.gre(), colour.gre()).mult(.1);
    vec2 offset_blue = vec2(-colour.blu(), colour.blu()).mult(.1);
    fx_set_pair(fx_list,set_datamosh,0, offset_red.array());
    fx_set_pair(fx_list,set_datamosh,1, offset_green.array());
    fx_set_pair(fx_list,set_datamosh,2, offset_blue.array());
  }
}





/**
* dither bayer
*/
String set_dither_bayer = "dither bayer";
void setting_fx_dither_bayer(ArrayList<FX> fx_list) {
  String version = "0.0.1";
  int revision = 1;
  String author = "Mattias / Shader Toy";
  String pack = "Base 2019";
  String [] slider = {"red","green","blue"};
  int id = fx_filter_classic_num;
  init_fx(fx_list,set_dither_bayer,FX_DITHER_BAYER_8,id,author,pack,version,revision,slider,null);
  fx_filter_classic_num++;
}

void update_fx_dither_bayer(ArrayList<FX> fx_list, boolean move_is, vec3 colour, int mode) {
  if(move_is) {
    fx_set_mode(fx_list,set_dither_bayer,mode);
    fx_set_level_source(fx_list,set_dither_bayer,colour.array());
  }
}









/**
* halftone line
*/
String set_halftone_dot = "halftone dot";
void setting_fx_haltone_dot(ArrayList<FX> fx_list) {
  String version = "0.0.1";
  int revision = 1;
  String author = "Stan le Punk";
  String pack = "Base 2019";
  String [] slider = {"angle","quantity"};
  int id = fx_filter_classic_num;
  init_fx(fx_list,set_halftone_dot,FX_HALFTONE_DOT,id,author,pack,version,revision,slider,null);
  fx_filter_classic_num++; 
}

void update_fx_haltone_dot(ArrayList<FX> fx_list, boolean move_is, float quantity, float angle) {
  if(move_is) {
    
    float temp = map(quantity,0,1,1,0);
    temp = pow(temp,4);
    temp = 1-temp;
    float pix_size = map(temp,0,1,height/4,.01);
    fx_set_size(fx_list,set_halftone_dot,pix_size);  

    angle = map(angle,0,1,-TAU,TAU);
    fx_set_angle(fx_list,set_halftone_dot,angle);

    fx_set_threshold(fx_list,set_halftone_dot,1);
  }
}
















/**
* halftone line
*/
String set_halftone_line = "halftone line";
void setting_fx_haltone_line(ArrayList<FX> fx_list) {
  String version = "0.0.2";
  int revision = 1;
  String author = "Stan le Punk";
  String pack = "Base 2019";
  String [] slider = {"quantity","angle"};
  int id = fx_filter_classic_num;
  init_fx(fx_list,set_halftone_line,FX_HALFTONE_LINE,id,author,pack,version,revision,slider,null);
  fx_filter_classic_num++; 
}

void update_fx_haltone_line(ArrayList<FX> fx_list, boolean move_is, vec2 pos, float num, float angle) {
  if(move_is) {
    fx_set_mode(fx_list,set_halftone_line,0); 

    int num_line = (int)map(num,0,1,20,100); 
    fx_set_num(fx_list,set_halftone_line,num_line);  

    // pass nothing with this two parameter
    // fx_set_quality(set_halftone_line,quality);
    // fx_set_threshold(set_halftone_line,threshold);

    angle = map(angle,0,1,-TAU,TAU);
    fx_set_angle(fx_list,set_halftone_line,angle);

    fx_set_pos(fx_list,set_halftone_line,pos.array());
  }
}


/*
* "red",
* "green",
* "blue",
* "position X"
* "position Y
* "size X"
* "size Y"
* "strength X"
* "strength Y"
* "quantity"
* "quality"
* "speed"
* "angle"
* "threshold"
*/
/**
* halftone multi
*/
String set_halftone_multi = "halftone multi";
void setting_fx_haltone_multi(ArrayList<FX> fx_list) {
  String version = "0.0.1";
  int revision = 1;
  String author = "Stan le Punk";
  String pack = "Base 2019";
  String [] slider = {"red","green","quantity","angle","threshold",};
  int id = fx_filter_classic_num;
  init_fx(fx_list,set_halftone_multi,FX_HALFTONE_MULTI,id,author,pack,version,revision,slider,null);
  fx_filter_classic_num++; 
}

void update_fx_haltone_multi(ArrayList<FX> fx_list, boolean move_is, float red, float green, vec2 pos, float quantity, float angle, float threshold) {

  fx_set_mode(fx_list,set_halftone_multi,0); 

  if(move_is) {
    float quality = (int)map(red,0,1,0,32); // use red for hue...because that's talk about the number of color, I believe???
    fx_set_quality(fx_list,set_halftone_multi,quality); // 1 to 16++

    // green because the seconde comp in green > same line of saturation r-G-b <> h-S-b
    fx_set_saturation(fx_list,set_halftone_multi,green); // from 0 to 1

    float temp = map(quantity,0,1,1,0);
    temp = pow(temp,4);
    temp = 1-temp;
    float pix_size = map(temp,0,1,height/4,.01);
    fx_set_size(fx_list,set_halftone_multi,pix_size);

    angle = map(angle,0,1,-TAU,TAU);
    fx_set_angle(fx_list,set_halftone_multi,angle);

    threshold = map(threshold,0,1,0,3);
    fx_set_threshold(fx_list,set_halftone_multi,threshold); // from 0 to 2++

    fx_set_pos(fx_list,set_halftone_multi,pos.array());
  }
}






/**
* pixel
*/
String set_pixel = "pixel";
// boolean effect_pixel_is;
void setting_fx_pixel(ArrayList<FX> fx_list) {
  String version = "0.0.2";
  int revision = 1;
  String author = "Stan le Punk";
  String pack = "Base 2019";
  String [] slider = {"quantity","size X","size Y","red","green","blue"};
  int id = fx_filter_classic_num;
  init_fx(fx_list,set_pixel,FX_PIXEL,id,author,pack,version,revision,slider,null);
  fx_filter_classic_num++;
}

void update_fx_pixel(ArrayList<FX> fx_list, boolean move_is, float num, vec2 size, vec3 hsb) {

  if(move_is) {
    float sx = map(size.x *size.x *size.x,0,1,1,width);
    float sy = map(size.y *size.y *size.y,0,1,1,height);
    fx_set_size(fx_list,set_pixel,sx,sy);

    int palette_num = (int)map(num,0,1,2,16);
    fx_set_num(fx_list,set_pixel,palette_num);
    
    float h = hsb.x; // from 0 to 1 where
    float s = hsb.y; // from 0 to 1 where
    float b = hsb.z; // from 0 to 1 where
    if(s < 0) s = 0; else if (s > 1) s = 1;
    if(b < 0) b = 0; else if (b > 1) s = 1;
    fx_set_level_source(fx_list,set_pixel,h,s,b); // not used ????

    fx_set_event(fx_list,set_pixel,0,false);
  }
}




/**
* split
*/
String set_split_rgb = "split rgb";
void setting_fx_split_rgb(ArrayList<FX> fx_list) {
  String version = "0.0.2";
  int revision = 1;
  String author = "Stan le Punk";
  String pack = "Base 2019";
  String [] slider = {"strength X","strength Y","speed"};
  int id = fx_filter_classic_num;
  init_fx(fx_list,set_split_rgb,FX_SPLIT_RGB,id,author,pack,version,revision,slider,null);
  fx_filter_classic_num++; 
}


void update_fx_split_rgb(ArrayList<FX> fx_list, boolean move_is, vec2 str, float speed) {
  if(move_is) {
    vec2 strength = map(str.pow(2),0,1,0,6);

    vec2 offset_red = vec2().cos_wave(frameCount,speed*.2,speed *.5);
    offset_red.x = map(offset_red.x,-1,1,-strength.x,strength.x);
    offset_red.y = map(offset_red.y,-1,1,-strength.y,strength.y);

    vec2 offset_green = vec2().sin_wave(frameCount,speed *.2,speed *.1);
    offset_green.x = map(offset_green.x,-1,1,-strength.x,strength.x);
    offset_green.y = map(offset_green.y,-1,1,-strength.y,strength.y);

    vec2 offset_blue = vec2().cos_wave(frameCount,speed*.1,speed *.2);
    offset_blue.x = map(offset_blue.x,-1,1,-strength.x,strength.x);
    offset_blue.y = map(offset_blue.y,-1,1,-strength.y,strength.y);

    fx_set_pair(fx_list,set_split_rgb,0,offset_red.array());
    fx_set_pair(fx_list,set_split_rgb,1,offset_green.array());
    fx_set_pair(fx_list,set_split_rgb,2,offset_blue.array());
  }
}




/**
* threshold
*/
String set_threshold = "threshold";
void setting_fx_threshold(ArrayList<FX> fx_list) {
  String version = "0.0.1";
  int revision = 1;
  String author = "Stan le Punk";
  String pack = "Base 2019";
  String [] slider = {"red","green","blue"};
  int id = fx_filter_classic_num;
  init_fx(fx_list,set_threshold,FX_THRESHOLD,id,author,pack,version,revision,slider,null);
  fx_filter_classic_num++;
}

void update_fx_threshold(ArrayList<FX> fx_list, boolean move_is, vec3 colour, int mode) {
  if(move_is) {
    fx_set_mode(fx_list,set_threshold,mode);
    fx_set_level_source(fx_list,set_threshold,colour.array());
  }
}




/**
* warp proc
*/
String set_warp_proc = "warp proc";
void setting_fx_warp_proc(ArrayList<FX> fx_list) {
  String version = "0.0.1";
  int revision = 1;
  String author = "Stan le Punk";
  String pack = "Base 2019";
  String [] slider = {"strength X","speed"};
  int id = fx_filter_classic_num;
  init_fx(fx_list,set_warp_proc,FX_WARP_PROC,id,author,pack,version,revision,slider,null);
  fx_filter_classic_num++; 
}


void update_fx_warp_proc(ArrayList<FX> fx_list, boolean move_is, float str, float speed) {
  if(move_is) {
    float max = map(str,0,1,1,height/20);
    float strength = sin(frameCount *(speed*speed)) *max;
    fx_set_strength(fx_list,set_warp_proc,strength);
  }
}


/**
* warp tex
*/
String set_warp_tex = "warp tex";
void setting_fx_warp_tex(ArrayList<FX> fx_list) {
  String version = "0.0.1";
  int revision = 1;
  String author = "Stan le Punk";
  String pack = "Base 2019";
  String [] slider = {"strength X"};
  int id = fx_filter_classic_num;
  init_fx(fx_list,set_warp_tex,FX_WARP_TEX_A,id,author,pack,version,revision,slider,null);
  fx_filter_classic_num++; 
}


void update_fx_warp_tex(ArrayList<FX> fx_list, boolean move_is, float str) {
  if(move_is) {
    fx_set_strength(fx_list,set_warp_tex,str);
  }
}





























/**
* FORCE WARP
* X SPECIAL
* this FX is linked with item and call a huge method and 
* class Force Field and class Force
* 2018-2019
* v 0.0.5
*/
Warp_Force warp_force_romanesco;
void init_warp_force() {
  if(warp_force_romanesco == null) {
    warp_force_romanesco = new Warp_Force();
    warp_force_romanesco.add(g);
  }
}


void warp_force(float strength, float speed, vec3 colour) {
  strength *= strength;
  strength = map(strength,0,1,0,10);
  
  // cycling
  float cycling = 1;
  float ratio = map(speed,0,1,0,.8);
  if(ratio > 0) {
    ratio = (ratio*ratio*ratio);
    cycling = abs(sin(frameCount *ratio));
  }

  vec4 refresh_warp_force = vec4(colour.x,colour.y,colour.z,1);
  if(ratio > 0) {
    refresh_warp_force.mult(cycling);
  }
  warp_force_romanesco.refresh(refresh_warp_force);
  warp_force_romanesco.shader_init();
  warp_force_romanesco.shader_filter(extra_fx_filter);
  warp_force_romanesco.shader_mode(0);
  // here Force_field is pass
  warp_force_romanesco.show(force_field_romanesco,strength);

  if(warp_force_reset) {
    warp_force_romanesco.reset();
    warp_force_reset = false;
  }

}




boolean warp_force_reset;
void warp_force_keyPressed(char c_1) {
  if(key == c_1) {
    println("Reset Warp Force",frameCount);
    warp_force_reset = true;
  }
}
