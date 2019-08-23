/**
* Force Field
* 2018-2019
* v 0.1.2
*/
class FF extends Romanesco {
	public FF() {
		item_name = "FF Force Field";
		item_author  = "Stan le Punk";
		item_version = "Version 0.1.2";
		item_pack = "Force 2018-2019";
    item_costume = "line/triangle/rect/cross/pentagon/flower/Star 5/Star 7/Super Star 8/Super Star 12/none";
    item_mode = "fluid/magnetic/gravity/perlin/equation/chaos/image";

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
    size_y_is = true;
    size_z_is = true;
    diameter_is = true;
    // canvas_x_is = true;
    // canvas_y_is = true;
    // canvas_z_is = true;

    frequence_is = true;
    // speed_x_is = true;
    // speed_y_is = true;
    // speed_z_is = true;
    // spurt_x_is = true;
    // spurt_y_is = true;
    // spurt_z_is = true;
    // dir_x_is = true;
    // dir_y_is = true;
    // dir_z_is = true;
    // jit_x_is = true;
    // jit_y_is = true;
    // jit_z_is = true;
    // swing_x_is = true;
    // swing_y_is = true;
    // swing_z_is = true;

    // quantity_is = true;
    // variety_is = true;
    // life_is = true;
    // flow_is = true;
    // quality_is = true;
    area_is = true;
    // angle_is = true;
    scope_is = true;
    // scan_is = true;
    // align_is = true;
    // repulsion_is = true;
    // attraction_is = true;
    // density_is = true;
    // influence_is = true;
    // calm_is = true;
    spectrum_is = true;

    grid_is = true;
    viscosity_is = true;
    diffusion_is = true;
    power_is = true;
    mass_is = true;
  }





  void setup() {
    set_item_pos(0,0,0);
  }
  

  int ref_mode = 0 ;
  float ref_cell = 0;
  float ref_detection = 0;
  void draw() { 
    minimum_spot();
    set_ff();
    if(ref_cell != get_grid().value() || ref_mode != get_mode_id() || ref_detection != get_area().value() || birth_is()) {
      ref_mode = get_mode_id();
      ref_cell = get_grid().value();
      ref_detection = get_area().value();
      birth_is(false);
      init_force_field(get_spot_num());
      // EQUATION
      if(get_pattern_force_field() == EQUATION) {
        generate_ff_equation();
      }
      
    }

    update_force_field_is(true);
    ivec2 aspect_colour = ivec2(get_fill(),get_stroke());
    aspect_is(fill_is(), stroke_is(), alpha_is());

    float thickness = get_thickness().value();
    float scale = get_size_x().value() *.1;
    float range = 0 ;
    if(reverse_is()) {
      range = -1 *get_spectrum().normal();
    } else {
      range = get_spectrum().normal();
    }
    
    Force_field ff = get_force_field();
    
    if(get_costume().get_type() == NULL) {
      // nothing
    } else {
      show_field(ff,scale,range,aspect_colour,thickness,get_area().value(),get_costume());
    }
    
    info();
  }



  private void generate_ff_equation() {
    init_eq();
    float x = random(-1,1);
    float y = random(-1,1);

    eq_center_dir(x,y);
    x = random(-1,1);
    y = random(-1,1);
    eq_center_len(x,y);

    eq_reverse_len(false);
    int swap_rand = floor(random(4));
    if(swap_rand == 0) eq_swap_xy("x","y");
    else if(swap_rand == 1) eq_swap_xy("y","x");
    else if(swap_rand == 2) eq_swap_xy("y","y");
    else if(swap_rand == 3) eq_swap_xy("x","x");
    else eq_swap_xy("x","y");
    // eq_swap_xy("x","y");
    // eq_swap_xy("y","y");
    int pow_x_rand = floor(random(-5,5));
    int pow_y_rand = floor(random(-5,5));
    if(pow_x_rand == 0) pow_x_rand = 1 ;
    if(pow_y_rand == 0) pow_y_rand = 1 ;
    eq_pow(pow_x_rand,pow_y_rand);
    float mult_x_rand = random(-5,5);
    float mult_y_rand = random(-5,5);
    if(mult_x_rand == 0) mult_x_rand = 1 ;
    if(mult_y_rand == 0) mult_y_rand = 1 ;
    eq_mult(mult_x_rand,mult_x_rand);
  }


  private void info() {
    if(get_force_field().get_type() == FLUID) info("Cell: "+get_grid(),"Force field: FLUID frequence: "+ get_force_field().get_frequence(),"viscosity: "+ get_force_field().get_viscosity(),"diffusion: "+ get_force_field().get_diffusion());
    else if(get_force_field().get_type() == MAGNETIC) info("Cell: "+get_grid(),"Force field: MAGNETIC");
    else if(get_force_field().get_type() == GRAVITY) info("Cell: "+get_grid(),"Force field: GRAVITY");
    else if(get_force_field().get_pattern() == PERLIN) info("Cell: "+get_grid(),"Force field: PERLIN");
    else if(get_force_field().get_pattern() == EQUATION) info("Cell: "+get_grid(),"Force field: EQUATION");
    else if(get_force_field().get_pattern() == CHAOS) info("Cell: "+get_grid(),"Force field: CHAOS");
    else if(get_force_field().get_pattern() == IMAGE) info("Cell: "+get_grid(),"Force field: IMAGE");
  }

  /**
  MINIMUM SPOT
  Use this method when there is no puppet master for the dynamic force field
  */
  boolean puppet_master_is = false ;
  private void minimum_spot() {
    if(!puppet_master_is() ) {

      if(get_spot_num() != 2) {
        clear_spot();
        add_spot(2);
        
      }
      // to re-init the value of specific spot in case there is not puppet master
      if(puppet_master_is) {
        // MAGNETIC CASE
        set_force_magnetic_tesla(50,-50);
        set_force_magnetic_diam(50);
        // GRAVITY CASE
        set_force_gravity_mass(50);
        puppet_master_is = false;
      }

      // update spot position
      if(motion_is()) {
        force_field_romanesco.set_spot_pos(mouse[0].x,mouse[0].y,0);
        force_field_romanesco.set_spot_pos(width -mouse[0].x,height -mouse[0].y,1);
      }
    } else {
      puppet_master_is = true;
    }
  }







  /**
  SET FORCE
  */
  private void set_ff() {
    // set detection
    int level_detection = (int)map(get_scope().value(),get_scope().min(),get_scope().max(),10,1);
    set_spot_detection_force_field(level_detection);

    // set cell
    int cell_size = (int)map(get_grid().value(),get_grid().min(),get_grid().max(),height/10,2);
    set_cell_force_field(cell_size);
    // set type
    if(get_mode_id() == 0) {
      set_type_force_field(FLUID);
    } else if(get_mode_id() == 1) {
      set_type_force_field(MAGNETIC);
    } else if(get_mode_id() == 2) {
      set_type_force_field(GRAVITY);
    } else {
      set_type_force_field(STATIC);
    }
    // set pattern
    if(get_mode_id() == 3) {
      set_pattern_force_field(PERLIN);
    } else if(get_mode_id() == 4) {
      set_pattern_force_field(EQUATION);
    } else if(get_mode_id() == 5) {
      set_pattern_force_field(CHAOS);
    } else if(get_mode_id() == 6) {
      set_pattern_force_field(IMAGE);
    } else {
      set_pattern_force_field(BLANK);
    }

    // set different force field FLUID
    if(get_type_force_field() == FLUID) {
      set_fluid_field();  
    } else if(get_type_force_field() == MAGNETIC) {
      set_magnetic_field();

    } else if(get_type_force_field() == GRAVITY) {
      set_gravity_field();
    }
  }

  private void set_magnetic_field() {
    int tesla = ceil(map(get_power().value(),get_power().min(),get_power().max(),1,height/3));
    set_force_magnetic_tesla(tesla,-tesla);

    int diam = ceil(get_diameter().value());
    set_force_magnetic_diam(diam);
  }

  private void set_gravity_field() {
    int mass = ceil(map(get_mass().value(),get_mass().min(),get_mass().max(),1,height/3));
    set_force_gravity_mass(mass);
  }

  private void set_fluid_field() {
    /*
      set_force_fluid_frequence(2/frameRate);
      set_force_fluid_viscosity(.001);
      set_force_fluid_diffusion(1.);
      */
      float frequence = map(get_frequence().value(),get_frequence().min(),get_frequence().max(),.01,.1);
      // set_force_fluid_frequence(frequence/frameRate);
      set_force_fluid_frequence(frequence);
      float viscosity = (get_viscosity().normal() *get_viscosity().normal() *get_viscosity().normal())*.25;
      set_force_fluid_viscosity(viscosity);
      float diffusion = get_diffusion().value();
      set_force_fluid_diffusion(diffusion);

  }



  /**
  SHOW FIELD
  */
  private void show_field(Force_field ff, float scale, float range_colour, ivec2 aspect, float thickness, float ratio, Costume costume) {
    if(ff != null) {
      vec2 offset = vec2(ff.get_resolution());
      offset.sub(ff.get_resolution()/2);
      //
      for (int x = 0; x < ff.cols; x++) {
        for (int y = 0; y < ff.rows; y++) {
          vec2 pos = vec2(x *ff.get_resolution(), y *ff.get_resolution());
          vec2 dir = vec2(ff.field[x][y].x,ff.field[x][y].y);
          if(ff.get_super_type() == r.STATIC) {
            float mag = ff.field[x][y].w;
            pattern_field(dir, mag, pos, ff.resolution *scale,range_colour,aspect,thickness,ratio,costume);
          } else {
            pos.add(offset);
            float mag = (float)Math.sqrt(dir.x*dir.x + dir.y*dir.y + dir.z*dir.z); ;
            pattern_field(dir, mag, pos, ff.resolution *scale,range_colour,aspect,thickness,ratio,costume);
          }
        }
      }
    }  
  }

  // Renders a vector object 'v' as an arrow and a position 'x,y'
  private void pattern_field(vec2 dir, float mag, vec2 pos, float scale, float range_colour, ivec2 aspect,float thickness, float ratio, Costume costume) {
    int color_mode_ref = (int)getColorMode()[0];
    vec4 color_arg_ref = vec4(getColorMode()[1],getColorMode()[2],getColorMode()[3],getColorMode()[4]);
    colorMode(HSB,1);

    pushMatrix();
    // Translate to position to render vector
    translate(pos);
    // Call vector heading function to get direction (note that pointing to the right is a heading of 0) and rotate
    rotate(dir.angle());
    // Calculate length of vector & scale it to be dir_vector or smaller if dir_vector
    if(mag > 1) mag = 1; // limit for the huge mag of gravity and magnetic field
    float size = mag *scale;

    float max = range_colour *mag;

    // float value = map(abs(len), 0, scale,max,min);
    int colour_fill = aspect.x;
    float hue_fill = hue(colour_fill)+max;
    if(hue_fill >= g.colorModeX) hue_fill -= g.colorModeX;
    if(hue_fill < 0) hue_fill = (g.colorModeX +hue_fill);
    vec4 c_fill = vec4(hue_fill,saturation(colour_fill),brightness(colour_fill),alpha(colour_fill));

    int colour_stroke = aspect.y;
    float hue_stroke = hue(colour_stroke)+max;
    if(hue_stroke >= g.colorModeX) hue_stroke -= g.colorModeX;
    if(hue_stroke < 0) hue_stroke = (g.colorModeX +hue_stroke);
    vec4 c_stroke = vec4(hue_stroke,saturation(colour_stroke),brightness(colour_stroke),alpha(colour_stroke));

    
    aspect(c_fill,c_stroke,thickness);
    set_ratio_costume_size(map(ratio,width*.1, width*TAU,0,1));
    
    // costume_rope(vec2(),vec3(size),costume);
    // pass by costume for the line is very slow
    if(costume.get_type() != LINE) {
      set_ratio_costume_size(map(ratio,width*.1, width*TAU,0,1));
      costume(vec2(),vec3(size),costume);
    } else {
      if(size > scale) size = scale;
      line(-size,0,size,0);
    }
    popMatrix();

    colorMode(color_mode_ref,color_arg_ref.red(),color_arg_ref.gre(),color_arg_ref.blu(),color_arg_ref.alp());
  }
}
