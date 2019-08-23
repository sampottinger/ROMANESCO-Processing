/**
ROMANESCO MASKING
v 1.0.0
2018-2018

WARNING
The method is advence for border mask but not for the option with different bloclk mask
*/
boolean border_is;
boolean default_mask_is = true;
void masking(boolean change_is) {
  // use border mask setting: masking(change_is,0,0,0);
  masking(change_is,0,0,0);
}
/**
master method
*/
// PGraphics pg_mask;
void masking(boolean change_is, int type_mask, int num_mask, int num_point_mask) {
  if(type_mask == 0) {
    border_is = true ;
    if(border_is) {
      if(display_mask_is(0)) {
        masking_border(change_is, default_mask_is);
      }
    }
  } else {
    masking_blocks(change_is, num_mask, num_point_mask);  
  }

  
  boolean mask_state_is = false;
  for(int i = 0 ; i < display_mask.length ; i++){
    if(display_mask[i]) {
      mask_state_is = true;
      break;
    }
  }

  // vertex solution
  if(get_mask_border() != null && mask_state_is) {
    g.image(get_mask_border(),0,0);
  }
  /*
  // pixel set solution
  println("DISPLAY MASK",pg_mask,mask_state_is,display_mask.length);
  if(pg_mask != null && mask_state_is) {
    pg_mask.loadPixels();
    loadPixels();
    for(int i = 0 ; i < pg_mask.pixels.length ; i++) {
      if(pg_mask.pixels[i] == r.BLACK) {
        g.pixels[i] = r.BLACK;
      } else if(pg_mask.pixels[i] == r.RED) {
        g.pixels[i] = r.RED;
      } else if(pg_mask.pixels[i] == r.WHITE) {
        g.pixels[i] = r.WHITE;
      }
    }
    updatePixels();
  }
  */

  if(change_is) {
    mask_border_reset();
  }
}
























/**
border mask
*/
Masking mask_border;
boolean init_mask_is ;
void masking_border(boolean change_is, boolean default_mask_is) {
  if(!init_mask_is) {
    // build mask
    if(mask_border == null || default_mask_is) {
      masking_border_default();
      println("set default mask");
      mask_border = new Masking(coord_connected,coord_block_1,coord_block_2,coord_block_3,coord_block_4);
      init_mask_is = true;
    } else if(mask_loaded_is) {
      println("set load mask");
      mask_border = new Masking(coord_connected,coord_block_1,coord_block_2,coord_block_3,coord_block_4);
      mask_loaded_is = false;
      init_mask_is = true;
    }
  } else {
    // display mask
    if(mask_border != null && display_mask_is(0)) {
      mask_border.draw(change_is);
    }
  }

  // save
  if(change_is) {
    save_mask_border();
  }
}




void save_mask_border() {
  coord_connected = mask_border.get_coord();
  coord_block_1 = mask_border.get_coord_block_1();
  coord_block_2 = mask_border.get_coord_block_2();
  coord_block_3 = mask_border.get_coord_block_3();
  coord_block_4 = mask_border.get_coord_block_4();
  //write_file_mask_mapping(get_file_mask_mapping());
  write_file_masking();
  save_file_masking(get_file_masking(),sketchPath(1)+ "/save/last_border_mask.csv");
}

ivec2 [] coord_connected;
ivec2 [] coord_block_1,coord_block_2,coord_block_3,coord_block_4;
void masking_border_default() {
  int marge = 40;
  coord_connected = new ivec2 [8];
  // outside
  coord_connected[0] = ivec2(0,0);
  coord_connected[1] = ivec2(width,0);
  coord_connected[2] = ivec2(width,height);
  coord_connected[3] = ivec2(0,height);
  // inside
  coord_connected[4] = ivec2(marge,marge);
  coord_connected[5] = ivec2(width-marge,marge);
  coord_connected[6] = ivec2(width-marge,height-marge);
  coord_connected[7] = ivec2(marge,height-marge);
  
  // coord_block_1
  coord_block_1 = new ivec2 [2];
  coord_block_1[0] = ivec2(width -width/3,marge);
  coord_block_1[1] = ivec2(width/3,marge);

  // coord_block_2
  coord_block_2 = new ivec2 [0];

  // coord_block_3
  coord_block_3 = new ivec2 [2];
  coord_block_3[0] = ivec2(width/3,height-marge);
  coord_block_3[1] = ivec2(width-width/3,height-marge);

  // coord_block_4
  coord_block_4 = new ivec2 [0];
}


void mask_border_reset() {
  if(mask_border == null) {
    masking_border(true,true);
  } else {
    mask_border.reset();
  }
  
}

PGraphics get_mask_border() {
  if(mask_border == null) {
    return null;
  } else {
    return mask_border.get_mask();
  }
}









































/**
block mask
*/

/**
block mask
*/
Masking [] masks;
Coord_mask [] coord_mask;

void masking_blocks(boolean change_is, int num, int num_point_mask) {
  if(masks == null) {
    coord_mask = new Coord_mask[num];
    masks = new Masking[coord_mask.length];
    // pg_mask = createGraphics(width,height);
    
    data_masking_blocks(coord_mask, num_point_mask);
    for(int i = 0 ; i < num ; i++) {
      masks[i] = new Masking(coord_mask[i].get());
    }
  } else {
    if(display_mask_is(0)) {
      for(int i = 0 ; i < num ;i++) {
        if(display_mask_is(i+1)) {
          masks[i].draw(change_is);
        }
      }
    }    
  }
}





// blocks
void data_masking_blocks(Coord_mask [] coord, int num_points_by_mask) {
  int marge = 100;

  for(int i = 0 ; i < coord.length ; i++) {
    ivec2 [] coord_mask = new ivec2[num_points_by_mask];
    ivec2 p = ivec2((int)random(marge,width-marge),(int)random(marge,height-marge));
    for(int k = 0 ; k < coord_mask.length ; k++) {
      int range = marge/2 ;
      coord_mask[k] = ivec2(p.x + int(random(-range,range)),p.y + int(random(-range,range)));
    }
    coord[i] = new Coord_mask(coord_mask);
  }
}

class Coord_mask {
  ivec2 [] coord;
  Coord_mask(ivec2 [] coord_pos) {
    this.coord = new ivec2[coord_pos.length];
    for(int i = 0 ; i < this.coord.length ;i++) {
      this.coord[i]= ivec2(coord_pos[i]);
    }
  }

  ivec2 [] get() {
    return coord;
  }

  void set(int i,int x, int y) {
    if(coord[i] != null) {
      coord[i].set(x,y);
    } else {
      coord[i] = ivec2(x,y);
    }
  }
}
/*
Mapping [] masks;
void mask_mapping_2_blocks(boolean change_is) {
  if(masks == null) {
    data_mask_mapping_blocks();
    masks = new Mapping[num_mask_mapping];
    masks[0] = new Mapping(coord_mask_0);
    masks[1] = new Mapping(coord_mask_1);
  } else {
    masks[0].draw(change_is);
    masks[1].draw(change_is);
  }
}

// blocks
ivec2 [] coord_mask_0, coord_mask_1;
int num_mask_mapping;
void data_mask_mapping_blocks() {
  int marge = 40;
  coord_mask_0 = new ivec2[4];
  coord_mask_0[0] = ivec2(0,0);
  coord_mask_0[1] = ivec2(width,0);
  coord_mask_0[2] = ivec2(width,marge);
  coord_mask_0[3] = ivec2(0,marge);

  coord_mask_1 = new ivec2[4];
  coord_mask_1[0] = ivec2(0,height-marge);
  coord_mask_1[1] = ivec2(width,height-marge);
  coord_mask_1[2] = ivec2(width,height);
  coord_mask_1[3] = ivec2(0,height);

  num_mask_mapping = 2;
}
*/



















void keyPressed_mask_set(char c) {
  if(key == c) {
    if(!display_mask[0]) {
      display_mask[0] = true;
    }
    set_mask();
  }
}

void keyPressed_mask_border_hide(char c) {
  if(key == c) {
    display_mask[0] = !!((display_mask[0] == false));
  }
}


void keyPressed_mask_save(char c) {
  if(key == c) {
    save_mask();
  }
}


void keyPressed_mask_load(char c) {
  if(key == c) {
    selectInput("Select a file to load data mask:", "load_save_mask");
  }
}











void enable_mask_is_on_top_for_bug_reason() {
  char [] key_num_under_num = {'0','1','2','3','4','5','6','7','8','9'};
  /*
  char [] key_num_under_num = new char[10];
  key_num_under_num[0] = '0';
  key_num_under_num[1] = '1';
  key_num_under_num[2] = '2';
  key_num_under_num[3] = '3';
  key_num_under_num[4] = '4';
  key_num_under_num[5] = '5';
  key_num_under_num[6] = '6';
  key_num_under_num[7] = '7';
  key_num_under_num[8] = '8';
  key_num_under_num[9] = '9'; 
  */

  for(int i = 0 ; i < display_mask.length && i < key_num_under_num.length ; i++) {
    if(key == key_num_under_num[i]) {
      display_mask[i] = !!((display_mask[i] == false));
      if(display_mask[i]) display_mask[0] = true;
      break;
    }
  } 
}

// boolean [] display_mask = {true,true,true,true,true,true,true,true,true,true};
boolean [] display_mask;

void init_masking() {
  display_mask = new boolean[10];
  for(int i = 0 ; i < display_mask.length ; i++) {
    display_mask[i] = false;
  }
}






/**
DATA CONTROL
v 0.1.0
SET and RETURN / boolean, int...
use to dial between the keyboard, the controller and the user
the mess
*/
boolean set_mask_is;
void set_mask() {
  set_mask_is = !!((set_mask_is == false));
}

boolean set_mask_is() {
  return set_mask_is;
}

boolean display_mask_is(int target) {
  if(target < display_mask.length && target >= 0) {
    return display_mask[target];
  } else return false;
}

void enable_mask() {
  enable_mask_is_on_top_for_bug_reason();

/**
the method is not with her family for bug reason...Java or Processing that's create an exception due of key_num_under_num[3] = '"';
problem to manage double quote assignation in char.
the char assignation must be write before the key and keyCode interrogation ?
*/
  /*
  char [] key_num_under_num = new char[10];
  key_num_under_num[0] = 'à'; 
  key_num_under_num[1] = '&';
  key_num_under_num[2] = 'é';
  key_num_under_num[3] = '"';
  key_num_under_num[4] = '\'';
  key_num_under_num[5] = '(';
  key_num_under_num[6] = '§';
  key_num_under_num[7] = 'è';
  key_num_under_num[8] = '!';
  key_num_under_num[9] = 'ç';
  for(int i = 0 ; i < display_mask.length && i < key_num_under_num.length ; i++) {
    if(key == key_num_under_num[i]) {
      display_mask[i] = !!((display_mask[i] == false)); 
      break;
    }
  } 
  */
}
































/**
load data save
*/
boolean mask_loaded_is ;
void load_save_mask(File selection) {
  if (selection == null) {
    println("No file has been selected for data mask");
  } else {
    processing.data.Table t = loadTable(selection.getAbsolutePath(),"header");
    set_file_masking(t);
    // mask border part
    if(get_file_masking().getRowCount() > 7) {
      int target = 0;
      for (TableRow row : get_file_masking().findRows("coord_connected", "name")) {
        int x = row.getInt("x");
        int y = row.getInt("y");
        coord_connected[target].set(x,y);
        target++;
      }
      target = 0;
      for (TableRow row : get_file_masking().findRows("coord_block_1", "name")) {
        int x = row.getInt("x");
        int y = row.getInt("y");
        coord_block_1[target].set(x,y);
        target++ ;
      }
      target = 0;
      for (TableRow row : get_file_masking().findRows("coord_block_2", "name")) {
        int x = row.getInt("x");
        int y = row.getInt("y");
        coord_block_2[target].set(x,y);
        target++ ;
      }
      target = 0;
      for (TableRow row : get_file_masking().findRows("coord_block_3", "name")) {
        int x = row.getInt("x");
        int y = row.getInt("y");
        coord_block_3[target].set(x,y);
        target++ ;
      }
      target = 0;
      for (TableRow row : get_file_masking().findRows("coord_block_4", "name")) {
        int x = row.getInt("x");
        int y = row.getInt("y");
        coord_block_4[target].set(x,y);
        target++ ;
      }
      // mapping block indépendant
      for (TableRow row : get_file_masking().findRows("Total_mask", "name")) {
        int num = row.getInt("num");
        coord_mask = new Coord_mask[num];
        break;
      }
      
      // find num
      masks = new Masking[coord_mask.length];
      for(int i = 0 ; i < masks.length ; i++) {
        for (TableRow row : get_file_masking().findRows("coord_mask_"+i, "name")) {
          int x = row.getInt("x");
          int y = row.getInt("y");
          coord_mask[i].set(target,x,y);
        }

        // data_mask_mapping_blocks(coord_mask, num_point_mask);
        /*
        for(int i = 0 ; i < num ; i++) {
          masks[i] = new Mapping(coord_mask[i].get());
        }
        */
      }

    }
    init_mask_is = false;
    default_mask_is = false;
    mask_loaded_is = true;
    // mask_mapping(false);
  }  
}





























/**
SAVE MASKING
*/
/**
SAVE / LOAD
v 0.0.5
*/
void save_mask() {
  write_file_masking();
  selectOutput("Select a file to write to:", "selected_file_to_save"); 
}


void selected_file_to_save(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected",selection.getAbsolutePath(),"for save force file");
    save_file_masking(get_file_masking(),selection.getAbsolutePath()+".csv");
  }
}

// mask file
processing.data.Table file_msk;
processing.data.Table get_file_masking() {
  return file_msk;
}

void set_file_masking(processing.data.Table t) {
  file_msk = t ;
}

void save_file_masking(processing.data.Table s_msk, String path) {
  if(s_msk != null) {
    saveTable(s_msk, path);
  }
} 

void write_file_masking() {
  file_msk = new processing.data.Table();
  file_msk.addColumn("name");
  file_msk.addColumn("num");
  file_msk.addColumn("is");
  file_msk.addColumn("x");
  file_msk.addColumn("y");

  TableRow newRow;
  newRow = file_msk.addRow();
  newRow = file_msk.addRow();
  newRow.setString("name", "Total_mask");
  int num_mask = 4;
  newRow.setInt("num", num_mask);

  if(coord_connected != null) {
    for(int i = 0 ; i < coord_connected.length ;i++) {
      newRow = file_msk.addRow();
      newRow.setString("name", "coord_connected");
      newRow.setString("is", "true");
      newRow.setInt("x", coord_connected[i].x);
      newRow.setInt("y", coord_connected[i].y);
    }
  }
  
  if(coord_block_1 != null) {
    for(int i = 0 ; i < coord_block_1.length ;i++) {
      newRow = file_msk.addRow();
      newRow.setString("name", "coord_block_1");
      newRow.setString("is", "true");
      newRow.setInt("x", coord_block_1[i].x);
      newRow.setInt("y", coord_block_1[i].y);
    }
  }

  if(coord_block_2 != null) {
    for(int i = 0 ; i < coord_block_2.length ;i++) {
      newRow = file_msk.addRow();
      newRow.setString("name", "coord_block_2");
      newRow.setString("is", "true");
      newRow.setInt("x", coord_block_2[i].x);
      newRow.setInt("y", coord_block_2[i].y);
    }
  }

  if(coord_block_3 != null) {
    for(int i = 0 ; i < coord_block_3.length ;i++) {
      newRow = file_msk.addRow();
      newRow.setString("name", "coord_block_3");
      newRow.setString("is", "true");
      newRow.setInt("x", coord_block_3[i].x);
      newRow.setInt("y", coord_block_3[i].y);
    }
  }

  if(coord_block_4 != null) {
    for(int i = 0 ; i < coord_block_4.length ;i++) {
      newRow = file_msk.addRow();
      newRow.setString("name", "coord_block_4");
      newRow.setString("is", "true");
      newRow.setInt("x", coord_block_4[i].x);
      newRow.setInt("y", coord_block_4[i].y);
    }
  }

  // save block indépendant
  /*
  if(coord_mask != null && coord_mask.length > 0) {
    for(int i = 0 ; i < coord_mask.length ;i++) {
      if(coord_mask[i] != null) {
        newRow = file_msk.addRow();
        newRow.setString("name", "coord_mask_" +i);
        newRow.setInt("num", coord_mask[i].get().length);
        for(int k = 0 ; k < coord_mask[i].get().length ; k++) {
          newRow = file_msk.addRow();
          newRow.setString("name", "coord_mask_" +i);
          newRow.setString("is", "true");
          newRow.setInt("x", masks[i].get_coord()[k].x);
          newRow.setInt("y", masks[i].get_coord()[k].x);
        }
      }     
    }
    
  }
  */
}
