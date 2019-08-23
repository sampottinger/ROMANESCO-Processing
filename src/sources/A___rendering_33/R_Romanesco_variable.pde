/**
* Romanesco Manager
* 2013-2019
* v 1.7.4
*/
Romanesco_manager rom_manager;

void romanesco_build_item() {
  rom_manager = new Romanesco_manager(this);
  rom_manager.add_item();
  rom_manager.set_item(preference_path+"gui_info_en.csv");
  rom_manager.finish_index();
  rom_manager.write_info_user();
  println("Romanesco setup done");
}




void update_font_item() {
  for(int i = 0 ; i < rom_manager.size() ; i++) {
    Romanesco item = rom_manager.get(i);
    item.set_font(current_font);
  }
}




//Update the var of the object
int which_movie_ref, which_bitmap_ref, which_shape_ref, which_text_ref;
void update_var_items(Romanesco item) {
  int id = item.get_id();
  // info
  item_info_display[id] = displayInfo?true:false;
  
  //initialization
  if(!init_value_mouse[id]) { 
    mouse[id] = mouse[0].copy();
    pen[id] = pen[0].copy();
    init_value_mouse[id] = true;
  }
  if(!init_value_controller[id]) {
    item.set_font(current_font);
    update_slider_value(item) ;
    init_value_controller[id] = true;
    which_bitmap[id] = which_bitmap[0];
    which_text[id] = which_text[0];
    which_shape[id] = which_shape[0];
    which_movie[id] = which_movie[0];
  }

  if(item.parameter_is()) {
    if(which_bitmap_ref != which_bitmap[0]) {
      which_bitmap[id] = which_bitmap[0];
      which_bitmap_ref = which_bitmap[0];
    }

    if(which_text_ref !=  which_text[0]) {
      which_text[id] = which_text[0];
      which_text_ref = which_text[0];
    }

    if(which_movie_ref !=  which_movie[0]) {
      which_movie[id] = which_movie[0];
      which_movie_ref = which_movie[0];
    }

    if(which_shape_ref !=  which_shape[0]) {
      which_shape[id] = which_shape[0];
      which_shape_ref = which_shape[0];
    }

    item.set_font(current_font);
    update_slider_value(item);
  }
  update_var_sound(item);
  
  if(item.action_is()){
    if(space_is()) {
      pen[id].set(pen[0]);
      mouse[id].set(mouse[0]);
    }
    
    if(key_n || birth_button_alert_is()) item.switch_birth();
    if(key_x) item.switch_colour();
    if(key_d || dimension_button_alert_is()) item.switch_dimension();
    if(key_h) item.switch_horizon();
    if(key_m) item.switch_motion();
    if(key_f) item.switch_follow();
    if(key_r) item.switch_reverse();
    if(key_w) item.switch_wire();
    if(key_s) item.switch_special();

    if(key_a) item.switch_alpha();
    if(key_j) item.switch_fill();
    if(key_k) item.switch_stroke();

    clickLongLeft[id] = ORDER_ONE;
    clickLongRight[id] = ORDER_TWO;
    clickShortLeft[id] = clickShortLeft[0];
    clickShortRight[id] = clickShortRight[0];

    change_bitmap_from_pad(id);
    change_movie_from_pad(id);
    change_text_from_pad(id);
    change_svg_from_pad(id);

    if(item.motion_is()) {
      if(movie[id] != null) movie[id].loop();
    } else {
      if(movie[id] != null) movie[id].pause();
    }
  }
}









void update_slider_value(Romanesco item) {
  int id = item.get_id();
  boolean init = first_opening_item[id];
  
  // COL 1
  update_slider_value_aspect(init,item);
  if (size_x_raw != size_x_ref || !init) item.set_size_x_raw(size_x_raw,2,0); 
  if (size_y_raw != size_y_ref || !init) item.set_size_y_raw(size_y_raw,2,0); 
  if (size_z_raw != size_z_ref || !init) item.set_size_z_raw(size_z_raw,2,0);
  if (diameter_raw != diameter_ref || !init) item.set_diameter_raw(diameter_raw,0,0); 
  if (canvas_x_raw != canvas_x_ref || !init) item.set_canvas_x_raw(canvas_x_raw,2,0); 
  if (canvas_y_raw != canvas_y_ref || !init) item.set_canvas_y_raw(canvas_y_raw,2,0); 
  if (canvas_z_raw != canvas_z_ref || !init) item.set_canvas_z_raw(canvas_z_raw,2,0);

  // COL 2
  if (frequence_raw != frequence_ref || !init) item.set_frequence_raw(frequence_raw,0,0); 
  if (speed_x_raw != speed_x_ref || !init) item.set_speed_x_raw(speed_x_raw,2,0); 
  if (speed_y_raw != speed_y_ref || !init) item.set_speed_y_raw(speed_y_raw,2,0); 
  if (speed_z_raw != speed_z_ref || !init) item.set_speed_z_raw(speed_z_raw,2,0);
  if (spurt_x_raw != spurt_x_ref || !init) item.set_spurt_x_raw(spurt_x_raw,2,0); 
  if (spurt_y_raw != spurt_y_ref || !init) item.set_spurt_y_raw(spurt_y_raw,2,0); 
  if (spurt_z_raw != spurt_z_ref || !init) item.set_spurt_z_raw(spurt_z_raw,2,0);
  if (dir_x_raw != dir_x_ref || !init) item.set_dir_x_raw(dir_x_raw,0,0); 
  if (dir_y_raw != dir_y_ref || !init) item.set_dir_y_raw(dir_y_raw,0,0); 
  if (dir_z_raw != dir_z_ref || !init) item.set_dir_z_raw(dir_z_raw,0,0);
  if (jitter_x_raw != jitter_x_ref || !init) item.set_jitter_x_raw(jitter_x_raw,0,0); 
  if (jitter_y_raw != jitter_y_ref || !init) item.set_jitter_y_raw(jitter_y_raw,0,0); 
  if (jitter_z_raw != jitter_z_ref || !init) item.set_jitter_z_raw(jitter_z_raw,0,0);
  if (swing_x_raw != swing_x_ref || !init) item.set_swing_x_raw(swing_x_raw,0,0); 
  if (swing_y_raw != swing_y_ref || !init) item.set_swing_y_raw(swing_y_raw,0,0); 
  if (swing_z_raw != swing_z_ref || !init) item.set_swing_z_raw(swing_z_raw,0,0);

  // COL 3
  if (quantity_raw != quantity_ref || !init) item.set_quantity_raw(quantity_raw,0,0);
  if (variety_raw != variety_ref || !init) item.set_variety_raw(variety_raw,0,0);
  if (life_raw != life_ref || !init) item.set_life_raw(life_raw,0,0);
  if (flow_raw != flow_ref || !init) item.set_flow_raw(flow_raw,0,0);
  if (quality_raw != quality_ref || !init) item.set_quality_raw(quality_raw,0,0);
  if (area_raw != area_ref || !init) item.set_area_raw(area_raw,2,0);
  if (angle_raw != angle_ref || !init) item.set_angle_raw(angle_raw,0,0);
  if (scope_raw != scope_ref || !init) item.set_scope_raw(scope_raw,0,0);
  if (scan_raw != scan_ref || !init) item.set_scan_raw(scan_raw,0,0);
  if (alignment_raw != alignment_ref || !init) item.set_alignment_raw(alignment_raw,0,0);
  if (repulsion_raw != repulsion_ref || !init) item.set_repulsion_raw(repulsion_raw,0,0);
  if (attraction_raw != attraction_ref || !init) item.set_attraction_raw(attraction_raw,0,0);
  if (density_raw != density_ref || !init) item.set_density_raw(density_raw,0,0);
  if (influence_raw != influence_ref || !init) item.set_influence_raw(influence_raw,0,0);
  if (calm_raw != calm_ref || !init) item.set_calm_raw(calm_raw,0,0);
  if (spectrum_raw != spectrum_ref || !init) item.set_spectrum_raw(spectrum_raw,0,0);

  // COL 4
  if (grid_raw != grid_ref || !init) item.set_grid_raw(grid_raw,0,0);
  if (viscosity_raw != viscosity_ref || !init) item.set_viscosity_raw(viscosity_raw,0,0);
  if (diffusion_raw != diffusion_ref || !init) item.set_diffusion_raw(diffusion_raw,0,0);
  if (power_raw != power_ref || !init) item.set_power_raw(power_raw,0,0);
  if (mass_raw != mass_ref || !init) item.set_mass_raw(mass_raw,0,0);
  if (coord_x_raw != coord_x_ref || !init) item.set_coord_x_raw(coord_x_raw,0,0); 
  if (coord_y_raw != coord_y_ref || !init) item.set_coord_y_raw(coord_y_raw,0,0); 
  if (coord_z_raw != coord_z_ref || !init) item.set_coord_z_raw(coord_z_raw,0,0);
  /** 
  make the obj has be never update in the future except by the moving slider 
  */
  first_opening_item[id] = true; 
}

vec4 fill_local_ref;
vec4 stroke_local_ref;
void change_slider_ref() {
  fill_local_ref = vec4(fill_hue_raw,fill_sat_raw,fill_bright_raw,fill_alpha_raw);
  stroke_local_ref = vec4(stroke_hue_raw,stroke_sat_raw,stroke_bright_raw,stroke_alpha_raw);
}


void update_slider_value_aspect(boolean init, Romanesco item) {
  int id = item.get_id();
  if(FULL_RENDERING) {
    if(!init) {
      fill_item_ref[id] = vec4(fill_hue_raw,fill_sat_raw,fill_bright_raw,fill_alpha_raw);
      fill_local_ref = vec4(fill_hue_raw,fill_sat_raw,fill_bright_raw,fill_alpha_raw);
      item.set_fill(fill_hue_raw,fill_sat_raw,fill_bright_raw,fill_alpha_raw);
      stroke_item_ref[id] = vec4(stroke_hue_raw,stroke_sat_raw,stroke_bright_raw,stroke_alpha_raw);
      stroke_local_ref = vec4(stroke_hue_raw,stroke_sat_raw,stroke_bright_raw,stroke_alpha_raw);
      item.set_stroke(stroke_hue_raw,stroke_sat_raw,stroke_bright_raw,stroke_alpha_raw);  
    }
    
    // FILL part
    bvec4 fill_is = bvec4();
    // check hsba value
    if(fill_local_ref.hue() != fill_hue_raw) fill_is.x = true;
    if(fill_local_ref.sat() != fill_sat_raw) fill_is.y = true;
    if(fill_local_ref.bri() != fill_bright_raw) fill_is.z = true;
    if(fill_local_ref.alp() != fill_alpha_raw) fill_is.w = true;

    if(fill_is.x) {
      item.set_fill(fill_hue_raw,fill_item_ref[id].sat(),fill_item_ref[id].bri(),fill_item_ref[id].alp());
      fill_item_ref[id] = to_hsba(item.get_fill());
    }

    if(fill_is.y) {
      item.set_fill(fill_item_ref[id].hue(),fill_sat_raw,fill_item_ref[id].bri(),fill_item_ref[id].alp());
      fill_item_ref[id] = to_hsba(item.get_fill());
    }

    if(fill_is.z) {
      item.set_fill(fill_item_ref[id].hue(),fill_item_ref[id].sat(),fill_bright_raw,fill_item_ref[id].alp());
      fill_item_ref[id] = to_hsba(item.get_fill());
    }

    if(fill_is.w) {
      item.set_fill(fill_item_ref[id].hue(),fill_item_ref[id].sat(),fill_item_ref[id].bri(),fill_alpha_raw); 
      fill_item_ref[id] = to_hsba(item.get_fill());
    }

    // zero security value
    if(fill_item_ref[id].hue() == 0) {
      fill_item_ref[id].hue(fill_hue_raw);
    }

    if(fill_item_ref[id].sat() == 0) {
      fill_item_ref[id].sat(fill_sat_raw);
    }

    if(fill_item_ref[id].bri() == 0) {
      fill_item_ref[id].bri(fill_bright_raw);
    }
    
    // STROKE part
    bvec4 stroke_is = bvec4();
    // check hsba value
    if(stroke_local_ref.hue() != stroke_hue_raw) stroke_is.x = true;
    if(stroke_local_ref.sat() != stroke_sat_raw) stroke_is.y = true;
    if(stroke_local_ref.bri() != stroke_bright_raw) stroke_is.z = true;
    if(stroke_local_ref.alp() != stroke_alpha_raw) stroke_is.w = true;
    

    if(stroke_is.x) {
      item.set_stroke(stroke_hue_raw,stroke_item_ref[id].sat(),stroke_item_ref[id].bri(),stroke_item_ref[id].alp());
      stroke_item_ref[id] = to_hsba(item.get_stroke());
    }

    if(stroke_is.y) {
      item.set_stroke(stroke_item_ref[id].hue(),stroke_sat_raw,stroke_item_ref[id].bri(),stroke_item_ref[id].alp());
      stroke_item_ref[id] = to_hsba(item.get_stroke());
    }

    if(stroke_is.z) {
      item.set_stroke(stroke_item_ref[id].hue(),stroke_item_ref[id].sat(),stroke_bright_raw,stroke_item_ref[id].alp());
      stroke_item_ref[id] = to_hsba(item.get_stroke());
    }

    if(stroke_is.w) {
      item.set_stroke(stroke_item_ref[id].hue(),stroke_item_ref[id].sat(),stroke_item_ref[id].bri(),stroke_alpha_raw); 
      stroke_item_ref[id] = to_hsba(item.get_stroke());
    }


    // zero security value
    if(stroke_item_ref[id].hue() == 0) {
      stroke_item_ref[id].hue(stroke_hue_raw);
    }

    if(stroke_item_ref[id].sat() == 0) {
      stroke_item_ref[id].sat(stroke_sat_raw);
    }

    if(stroke_item_ref[id].bri() == 0) {
      stroke_item_ref[id].bri(stroke_bright_raw);
    }

    // thickness
    if (thickness_raw != thickness_ref || !init) {
      item.set_thickness_raw(thickness_raw,0,0);
    }
  } else {
    // preview display
    item.set_fill(to_hsba(COLOR_FILL_ITEM_PREVIEW).array());
    item.set_stroke(to_hsba(COLOR_STROKE_ITEM_PREVIEW).array());
    item.set_thickness_raw(THICKNESS_ITEM_PREVIEW,0,0);
  }
}







//
void update_var_sound(Romanesco item) {
  int id = item.get_id();
  if(item.sound_is()) {
    left[id] = left[0];// value(0,1)
    right[id] = right[0]; //float value(0,1)
    mix[id] = mix[0]; //   is average volume between the left and the right / float value(0,1)
    
    transient_value[0][id] = transient_value[0][0]; // is transient master detection on all spectrum : value 1,10 

    transient_value[1][id] = transient_value[1][0]; // is extra_bass transient detection by default : value 1,10 
    transient_value[2][id] = transient_value[2][0]; // is bass transient detection by default : value 1,10 
    transient_value[3][id] = transient_value[3][0]; // is medium transient detection by default : value 1,10 
    transient_value[4][id] = transient_value[4][0]; // is hight transient detection by default : value 1,10 


    tempo_rom[id] = tempo_rom[0]; // global speed of track  / float value(0,1)
    tempo_rom_beat[id] = tempo_rom_beat[0]; // speed of track calculate on the beat
    tempo_rom_kick[id] = tempo_rom_kick[0]; // speed of track calculate on the kick
    tempo_rom_snare[id] = tempo_rom_snare[0]; // speed of track calculate on the snare
    tempo_rom_hat[id] = tempo_rom_hat[0]; // speed of track calculte on the hat
    
    for (int i = 0 ; i <NUM_BANDS ; i++) {
      band[id][i] = band[0][i];
    }
  } else {
    left[id] = 1;// value(0,1)
    right[id] = 1; //float value(0,1)
    mix[id] = 1; //   is average volume between the left and the right / float value(0,1)
    
    transient_value[0][id] = 1; // is transient master detection on all spectrum : value 1,10 

    transient_value[1][id] = 1; // is extra_bass transient detection by default : value 1,10 
    transient_value[2][id] = 1; // is bass transient detection by default : value 1,10 
    transient_value[3][id] = 1; // is medium transient detection by default : value 1,10 
    transient_value[4][id] = 1; // is hight transient detection by default : value 1,10 
    
    tempo_rom[id] = 1; // global speed of track  / float value(0,1)
    tempo_rom_beat[id] = 1; // speed of track calculate on the beat
    tempo_rom_kick[id] = 1; // speed of track calculate on the kick
    tempo_rom_snare[id] = 1; // speed of track calculate on the snare
    tempo_rom_hat[id] = 1; // speed of track calculte on the hat
    
    for (int i = 0 ; i < NUM_BANDS ; i++) {
      band[id][i] = 1 ;
    }
  }
}












// RESET list and item
boolean reset(Romanesco item) {
  boolean state = false;
  //global delete
  if (space_is()) state = true;
  //SPECIFIC DELETE when the paramer button of contrôleur is ON
  else if (key_delete) if (item.action_is() || item.parameter_is()) state = true ;
  return state;
}
