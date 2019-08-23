/**
* ECOSYSTEM UTIL
* v 1.1.2
* 2015-2019
* Processing 3.5.3
* @author @stanlepunk
* @see https://github.com/StanLepunK/Life
* HOST and SYMBIOSIS
* WORLD
* BIOMASS
* picking, hunting, fooding
* REPRODUCTION
* GENETIC
* SHOW and COSTUME
* INFO
* GROWTH, LIFE and DIE
*/

/**
* HOST SYMBIOSIS MANAGEMENT 0.0.5
*/
int [] target_host ;
vec4 [] symbiosis_area ;
vec3 pos_host, radius_host, canvas_host, size_host ;

vec4 [] get_symbiosis_area() {
  if(symbiosis_area != null) return symbiosis_area ; else return null ;
}

int symbiosis_area_size() {
  if(symbiosis_area != null) return symbiosis_area.length ;
  else return -1 ;
}

vec3 [] get_symbiosis_area_pos() {
  vec3 [] list = new vec3[symbiosis_area.length] ;
  for(int i = 0 ; i < list.length ; i++) {
    list[i] = vec3(symbiosis_area[i].x, symbiosis_area[i].y, symbiosis_area[i].z) ;
  }
  if(list != null) return list ; else return null ;
}

int [] get_symbiosis_area_id() {
  int [] list = new int[symbiosis_area.length] ;
  for(int i = 0 ; i < list.length ; i++) {
      list[i] = int(symbiosis_area[i].w) ;
  }
  return list ;
}


void init_symbiosis_area(int num) {
  symbiosis_area = new vec4[num];
}

void init_host_target(int num) {
  target_host = new int[num] ;
}

int [] get_host_address() {
  return target_host ;
}

void set_host_address(int target, int value) {
  if(target < target_host.length) {
    target_host[target] = value ;
  }
}

/**
pos host
*/
void pos_host(vec pos) {
  if(pos_host == null) {
    pos_host = vec3(pos.x,pos.y,pos.z) ;
  } else {
    pos_host.set(pos.x, pos.y, pos.z) ;
  }
}

void pos_host(float x, float y, float z) {
  if(pos_host == null) {
    pos_host = vec3(x,y,z) ;
  } else {
    pos_host.set(x,y,z) ;
  }
}

vec3 get_pos_host() {
  return pos_host ;
}

/**
radius host
*/
void radius_host(vec radius) {
  if(radius_host == null) {
    radius_host = vec3(radius.x,radius.y,radius.z) ;
  } else {
    radius_host.set(radius.x, radius.y, radius.z) ;
  }
}

void radius_host(float x, float y, float z) {
  if(radius_host == null) {
    radius_host = vec3(x,y,z) ;
  } else {
    radius_host.set(x,y,z) ;
  }
}

vec3 get_radius_host() {
  return radius_host ;
}

/**
size host
*/
void size_host(vec size) {
  if(size_host == null) {
    size_host = vec3(size.x,size.y,size.z) ;
  } else {
    size_host.set(size.x, size.y, size.z) ;
  }
}

void size_host(float x, float y, float z) {
  if(size_host == null) {
    size_host = vec3(x,y,z) ;
  } else {
    size_host.set(x,y,z) ;
  }
}

vec3 get_size_host() {
  return size_host ;
}


/**
canvas host
*/
void canvas_host(vec canvas) {
  if(canvas_host == null) {
    canvas_host = vec3(canvas.x,canvas.y,canvas.z) ;
  } else {
    canvas_host.set(canvas.x, canvas.y, canvas.z) ;
  }
}

void canvas_host(float x, float y, float z) {
  if(canvas_host == null) {
    canvas_host = vec3(x,y,z) ;
  } else {
    canvas_host.set(x,y,z) ;
  }
}

vec3 get_canvas_host() {
  return canvas_host ;
}


/**
symbiosis area
*/
void set_symbiosis_area(vec3 [] target_host_list) {
  for(int i = 0 ; i < symbiosis_area.length ; i++) {
    if(symbiosis_area[i] == null) symbiosis_area[i] = vec4() ;
    int where = (int)random(target_host_list.length) ;
    set_host_address(i, where) ;
    symbiosis_area[i].set(target_host_list[where].x, target_host_list[where].y, target_host_list[where].z, where) ;
  }
}



void update_symbiosis_area(vec3 [] target_host_list) {
  if(symbiosis_area != null) {
    for(int i = 0 ; i < symbiosis_area.length ; i++) {
      int where = (int)symbiosis_area[i].w ;
      vec3 pos = target_host_list[where] ;
      symbiosis_area[i].x = pos.x ;
      symbiosis_area[i].y = pos.y ;
      symbiosis_area[i].z = pos.z ;
    }
  }
}

/**
symbiosis 0.0.4
*/
void symbiosis(ArrayList<Agent> symbiotic_agent_list, vec3 [] list_coord_host, int [] address) {
  if(list_coord_host.length > 0 && address.length > 0 && symbiotic_agent_list.size() > 0) {
    int max_loop = address.length ;
    if(max_loop > symbiotic_agent_list.size()) max_loop = symbiotic_agent_list.size() ;
    for(int i = 0 ; i < max_loop ; i++) {
      Agent a = symbiotic_agent_list.get(i) ;
      int where = floor(random(address.length)) ;
      a.set_home(list_coord_host[address[where]], address[where]) ;
      a.set_pos(a.get_home_pos()) ;
    }
  }
}


void sync_symbiosis(ArrayList<Agent> symbiotic_agent_list, vec3 pos) {
  for(Agent a : symbiotic_agent_list) {
    if(a.get_home_id() != -1) {
      if(symbiosis_area_size() > a.get_home_id()) {
        a.set_home_pos(get_symbiosis_area_pos()[a.get_home_id()]) ;
      } else {
        symbiotic_agent_list.remove(a) ;
        break ;
      }
      if(pos != null && !pos.equals(vec3(0))) {
        a.set_pos(a.get_home_pos().add(pos)) ;
      } else {
        a.set_pos(a.get_home_pos()) ;
      }
    } else {
      // System.err.println("ID home is equal to -1, need to init your symbiotic ecosystem before sync it") ;
    }
  }
}


void sync_symbiosis(ArrayList<Agent> symbiotic_agent_list) {
  vec3 pos = vec3() ;
  sync_symbiosis(symbiotic_agent_list, pos) ;
}





















/**

WORLD 0.1.1

*/
boolean HORIZON_ALPHA = false ;
int HORIZON = 0 ;
int ENVIRONMENT = 2 ; // 2 is for 2D, 3 for 3D
vec3 ECO_BOX_SIZE = vec3(100,100,100) ;
vec3 ECO_BOX_POS = vec3() ;
vec6 LIMIT = vec6(0, ECO_BOX_SIZE.x, 0, ECO_BOX_SIZE.y, 0, ECO_BOX_SIZE.z) ;

boolean REBOUND ;
int SIZE_TEXT_INFO ;


void set_renderer(String renderer) {
  if(renderer.equals(P3D)) {
    ENVIRONMENT = 3 ;
  } else {
    ENVIRONMENT = 2 ;
  }
}


void use_horizon(boolean horizon) {
  HORIZON_ALPHA = horizon ;
}

void set_horizon(int value) {
   HORIZON = value ;
}

void use_rebound(boolean rebound) {
  REBOUND = rebound ;
}

vec3 get_box_pos() {
  return ECO_BOX_POS ;
}

vec3 get_box_size() {
  return ECO_BOX_SIZE ;
}

void build_box(vec3 pos, vec3 size) {
  set_pos_box(pos) ;
  set_size_box(size) ;
}

void set_size_box(vec3 size) {
  ECO_BOX_SIZE.set(size) ;
}

void set_pos_box(vec3 pos) {
  ECO_BOX_POS.set(pos) ;
}

void set_limit_box(float left, float right, float top, float bottom, float front, float back) {
  LIMIT.set(left,right, top, bottom, front, back) ;
}
























/**

BIOMASS

*/
class Biomass {
  float humus, humus_max ;
  Biomass() {}

  void humus_update(float var_humus) {
    humus +=var_humus ;
  }

  void set_humus(float humus) {
    this.humus = this.humus_max = humus ;
  }
}
























/**

AGENT DYNAMIC

*/

void picking_update(ArrayList<Agent> list_picker, ArrayList<Agent> list_target) {
  for(Agent a : list_picker) {
    if(a instanceof Agent_dynamic) {
      Agent_dynamic picker = (Agent_dynamic) a ;
      if(!picker.satiate) {
        search_flora(picker, list_target) ;
      }
      eat_flora(picker, list_target) ;
    }
  }
}

void hunting_update(ArrayList<Agent> list_hunter, boolean info, ArrayList<Agent>... all_list) {
  for( ArrayList list_target : all_list) {
    for(Agent a : list_hunter) {
      if(a instanceof Agent_dynamic) {
        Agent_dynamic hunter = (Agent_dynamic) a ;
        if(!hunter.satiate && !hunter.eating) hunt(hunter, list_target) ;
      }
    }
  }
}

void eating_update(ArrayList<Agent> list_hunter, ArrayList<Dead> list_dead) {
  for(Agent a : list_hunter) {
    if(a instanceof Agent_dynamic) {
      Agent_dynamic hunter = (Agent_dynamic) a ;
      // eat
      if(list_dead.size() >= 0 ) {
        eat_meat(hunter, list_dead) ;
      } else {
        hunter.eating = false ;
      }
    }
  }
}

/**

SEARCH

*/
/**
search flora
*/
void search_flora(Agent_dynamic grazer, ArrayList<Agent> list_target) {

  if(grazer.tracking && grazer.max_time_track > grazer.time_track) {
    if(grazer.focus_target(list_target)) {
      int which_target = (int)grazer.ID_target.x ;
      int ID_target = (int)grazer.ID_target.y ;
      Agent target = list_target.get(which_target) ;
      grazer.track(grazer.target) ;
    }
  } else {
    grazer.track_stop() ;
    int entry = floor(random(list_target.size())) ;
    for(int i = 0 ; i < list_target.size() ; i++) {
      int which = i + entry ;
      if(which >= list_target.size()) {
        which -= list_target.size() ;
      }
      Agent a = list_target.get(which) ;
      if(a instanceof Flora) {
        Flora target = (Flora) a ;
        grazer.watch(target, list_target) ;
        if(grazer.tracking) {
          break ;
        }
      }
    }
  }
}






/**
hunt creature
*/
void hunt(Agent_dynamic hunter, ArrayList<Agent> list_target) {
  // first watch the agent who watch just before without look in the list
  if(hunter.watching) find_target_hunter(hunter, list_target) ;

  if(hunter.tracking && hunter.max_time_track > hunter.time_track) {
    hunt_target(hunter, list_target) ;
  } else {
    hunter.track_stop() ;
  }
}



// Local method : The hunt is launching !
void hunt_target(Agent_dynamic hunter, ArrayList<Agent> list_target) {
   if (hunter.focus_target(list_target)) {
    hunt_and_kill_target(hunter, hunter.target) ;
   } else {
    hunter.track_stop() ;
  }
}
// super local method
void hunt_and_kill_target(Agent_dynamic hunter, Agent target) {
  if(target instanceof Agent_dynamic) {
    Agent_dynamic target_d = (Agent_dynamic) target ;
    if(hunter.dist_to_target(target_d) < hunter.sense_range) {
      hunter.track(target_d) ;
      hunter.kill(target_d) ;
    } else hunter.track_stop() ;
  }
}

/**
Find new target, Big Brother is hunting you !
*/
void find_target_hunter(Agent_dynamic hunter, ArrayList<Agent> list_target) {
  // float [] dist_list = new float[0] ;
  ArrayList <vec3> closest_target = new ArrayList<vec3>() ;
  // find the closest target
  for(Agent a : list_target) {
    if(a instanceof Agent_dynamic) {
      Agent_dynamic target_d = (Agent_dynamic) a ;
      if(hunter.dist_to_target(target_d) < hunter.sense_range) {
        float dist = hunter.dist_to_target(target_d) ;
        // catch distance to compare with the last one
        // plus catch index in the list and the ID target
        // and add in the nice target list

        vec3 new_target = vec3(dist, list_target.indexOf(target_d), target_d.get_ID()) ;
        closest_target.add(new_target) ;
        // compare the target to see which one is the closest.
        if(closest_target.size() > 1) if (closest_target.get(1).x <= closest_target.get(0).x ) closest_target.remove(0) ; else closest_target.remove(1) ;
      }
    }
  }

  // Start the hunt party with the selected target
  if(closest_target.size() > 0 ) {
    Agent a = list_target.get((int)closest_target.get(0).y) ;
    if(a instanceof Agent_dynamic) {
      Agent_dynamic target_d = (Agent_dynamic) a ;
      hunter.track(target_d) ;
      hunter.kill(target_d) ;
      if(hunter.tracking) hunter.ID_target.set(list_target.indexOf(target_d),target_d.get_ID()) ;
    }
  }
}




/**

EAT

*/
/**
eating flora
*/
void eat_flora(Agent_dynamic grazer, ArrayList<Agent> list_target) {
  if(grazer.eating) {
    Agent a ;
    if((int)grazer.ID_target.x < list_target.size()) {
      a = list_target.get((int)grazer.ID_target.x) ;
      if(a instanceof Flora) {
        Flora target = (Flora) a ;
        grazer.eat_veg(target) ;
      }
    }
  } else if (!grazer.eating) {
    for(Agent a : list_target) {
      if(a instanceof Flora) {
        Flora target = (Flora) a ;
        grazer.eat_veg(target) ;
        if(grazer.eating) {
          if((int)grazer.ID_target.x < list_target.size()) {
            grazer.ID_target.set(list_target.indexOf(a),target.ID) ;
            break ;
          }
        }
      }
    }
  }
}

/**
eat meat
*/
void eat_meat(Agent_dynamic hunter, ArrayList<Dead> list_dead) {
  // first eat the agent who eat just before without look in the list
  if(hunter.eating) {
    int pointer = (int)hunter.ID_target.x ;
    int ID_target = (int)hunter.ID_target.y ;
    /* here we point directly in a specific point of the list,
    if the pointer is superior of the list,
    because if it's inferior a corpse can be eat by an other Agent */
    if(pointer < list_dead.size() ) {
      Dead target = list_dead.get((int)hunter.ID_target.x) ;
      /* if the entry point of the list return an agent
      with a same ID than a ID_target corpse eat just before,
      the Carnivore can continue the lunch */
      if (target instanceof Agent_static && target.get_ID() == ID_target ) {
        Agent_static agent_meat = (Agent_static) target ;
        hunter.eat_flesh(agent_meat) ;
      }
      else {
        /* If the ID returned is different, a corpse was leave from the list,
        and it's necessary to check in the full ist to find if any corpse have a seme ID */
        for(Dead target_in_list : list_dead) {
          if (target_in_list instanceof Agent_static && target_in_list.get_ID() == ID_target) {
            Agent_static agent_meat = (Agent_static) target_in_list ;
            hunter.eat_flesh(agent_meat) ;
          } else {
            hunter.eating = false ;
          }
        }
      }
    }
  /* If the last research don't find the corpse, may be this one is return to dust ! */
  } else {
    for(Agent a : list_dead) {
      if(a instanceof Agent_static) {
        Agent_static target = (Agent_static) a ;
        hunter.eat_flesh(target) ;
        if(hunter.eating) {
          hunter.ID_target.set(list_dead.indexOf(target),target.get_ID()) ;
          break ;
        }
      }
    }
  }
}

/**


END FOOD


*/












































/**

REPRODUCTION AGENT DYNAMIC

*/
boolean check_male_reproducer(Agent female, ArrayList<Agent> list_target) {
  boolean result = false ;
  if(list_target.size() > 0) {
    for (Agent male : list_target) {
      if(male instanceof Agent_dynamic && female instanceof Agent_dynamic) {
        Agent_dynamic m = (Agent_dynamic) male ;
        Agent_dynamic f = (Agent_dynamic) female ;
        if(dist(f.pos, m.pos) < f.reproduction_area) {
          result = true ;
          // must be create method copy but smell very complexe thing to do
          f.genome_father = m.genome ;
          break ;
        } else result = false ;
      } else result = false ;
    }
  } else result = false ;
  return result ;
}


/**
Male Reproduction
*/
void reproduction_male(ArrayList<Agent> list_f, ArrayList<Agent> list_m) {
  for (Agent f : list_f) {
    if(f instanceof Agent_dynamic) {
      Agent_dynamic f_a_d = (Agent_dynamic) f ;
      if(f_a_d.fertility && check_female_reproducer(f, list_m)) ;
    }
  }
}

boolean check_female_reproducer(Agent female, ArrayList<Agent> list_target_male) {
  boolean result = false ;
  if(list_target_male.size() > 0) {
    for (Agent male : list_target_male) {
      if(male instanceof Agent_dynamic && female instanceof Agent_dynamic) {
        Agent_dynamic m = (Agent_dynamic) male ;
        Agent_dynamic f = (Agent_dynamic) female ;
        if(dist(female.get_pos(), male.get_pos()) < f.sex_appeal) {
          f.pos_target.set(male.get_pos()) ;
          m.tracking_partner = true ;
          // float ratio_acceleration_to_see_female = 1.3 ;
          // m.velocity = m.velocity_ref *ratio_acceleration_to_see_female ;
          m.dir.set(target_direction(f.pos, m.pos)) ;
          result = true ;
        } else {
          result = false ;
          m.tracking_partner = false ;
        }
      } else {
        result = false ;
      }
    }
  } else result = false ;
  return result ;
}




/**
DELIVERY
*/
int num_by_pregnancy = 1 ;

void delivery(Agent_dynamic deliver, Genome mother, Genome father, ArrayList<Agent> list_child, Info_dict carac, Info_Object style) {
  // check for heterozygote
  num_babies(deliver.multiple_pregnancy) ;
  Agent [] babies = new Agent [num_by_pregnancy] ;
  babies = babies(deliver, num_by_pregnancy, mother, father) ;
  for(int i = 0 ; i < num_by_pregnancy ; i++) {
    set_baby(deliver, babies[i], list_child, carac, style) ;
    if(PRINT_BORN_AGENT_DYNAMIC) print_born_agent_dynamic (babies[i]) ;
  }
  deliver.num_pregnancy ++ ;
  num_by_pregnancy = 1 ;
}

// local
void set_baby(Agent_dynamic deliver, Agent baby, ArrayList<Agent> list_child, Info_dict carac, Info_Object style) {
  if(baby instanceof Agent_dynamic) {
    Agent_dynamic n = (Agent_dynamic) baby ;
    // clean the uterus of mother
    deliver.genome_father = null ;
    // set motion of the baby
    n.set_pos(deliver.pos) ;
    n.dir = vec3().rand(1);;
    // here we change velocity to don't have a same from parent, can be change that in the future
    float new_velocity = deliver.velocity +random(-1,1) ;
    if(new_velocity < .1) new_velocity = .1 ;
    n.set_velocity(new_velocity) ;

    // all data from mother
    // Must add this part in the genome for the future,
    if(baby instanceof Carnivore) set_carnivore(n, deliver.pos, carac, style) ;
    if(baby instanceof Herbivore) set_herbivore(n, deliver.pos, carac, style) ;
    if(baby instanceof Omnivore) set_omnivore(n, deliver.pos, carac, style) ;

    n.set_ID( (short) Math.round(random(Short.MAX_VALUE))) ;
    list_child.add(n) ;
  }
}


Agent [] babies(Agent_dynamic deliver, int num, Genome mother, Genome father) {
  Agent [] b = new Agent [num] ;
  // re-init for the pregnancy
  String monster_message = "The mother deliver is a genetic monster, and the 'Nature of Code' kill it because is not a baby from an Authorized Class" ;

  for(int i = 0 ; i < b.length ; i++) {
    // check for homozygous
    if(b.length > 1 && i <  b.length -1 && random(3) < 1) {
      deliver.num_children += 2 ;
      deliver.num_homozygous += 2 ;
      if(deliver instanceof Herbivore ) b[i] = new Herbivore(mother, father, deliver.style) ;
      else if(deliver instanceof Omnivore ) b[i] = new Omnivore(mother, father, deliver.style) ;
      else if(deliver instanceof Carnivore ) b[i] = new Carnivore(mother, father, deliver.style) ;
      else println(monster_message) ;
      i++ ;
      if(deliver instanceof Herbivore ) b[i] = b[i -1] ;
      else if(deliver instanceof Omnivore ) b[i] = b[i -1] ;
      else if(deliver instanceof Carnivore ) b[i] = b[i -1] ;
      else println(monster_message) ;
    } else {
      deliver.num_children++ ;
      if(b.length > 1) deliver.num_heterozygous++ ;
      if(deliver instanceof Herbivore ) b[i] = new Herbivore(mother, father, deliver.style) ;
      else if(deliver instanceof Omnivore ) b[i] = new Omnivore(mother, father, deliver.style) ;
      else if(deliver instanceof Carnivore ) b[i] = new Carnivore(mother, father, deliver.style) ;
      else println(monster_message) ;
    }
  }
  return b ;
}



void num_babies(float ratio_multi) {
  int max = 100 ;
  float draw = random(max) ;
  // security
  int max_babies = 100 ;

  if(draw < ratio_multi && num_by_pregnancy < max_babies) {
    num_by_pregnancy++ ;
    num_babies(ratio_multi) ;
  }
}






/**
FAMILY
*/
void manage_child(ArrayList<Agent> list_f, ArrayList<Agent> list_m, ArrayList<Agent> list_child) {
  if(list_child.size() > 0) {
    for (Agent child : list_child) {
      if(child instanceof Agent_dynamic) {
        Agent_dynamic c = (Agent_dynamic) child ;
        if(c.maturity <= 0 ) {
          if(c.gender == 0 ) {
            // we don't add 'c' because it's an 'Agent_dynamic' we need to a pure 'Agent'
            list_f.add(child) ;
            break ;
          }
          if(c.gender == 1 ) {
            // we don't add 'c' because it's an 'Agent_dynamic' we need to a pure 'Agent'
            list_m.add(child) ;
            break ;
          }
        }
      }
    }

    // remove child when this one to be added to the adult pool
    for (Agent child : list_child) {
      if(child instanceof Agent_dynamic) {
        Agent_dynamic c = (Agent_dynamic) child ;
        if(c.maturity <= 0 ) {
          list_child.remove(child) ;
          break ;
        }
      }
    }
  }
}

/**

END REPRODUCTION
AGENT DYNAMIC

*/







































/**

SHOW / COSTUME

*/
void set_costume_agent(int which_costume, ArrayList<Agent>... all_list) {
  for(ArrayList<Agent> list : all_list) {
    for(Agent a : list) {
      a.set_costume(which_costume) ;
    }
  }
}


/**
Info_Object info
* boolean info = (boolean)info.catch_obj(0) ;
* boolean original = (boolean)info.catch_obj(1) ;
* int costume_ID = (int)info.catch_obj(2) ;
* vec4 fill = (vec4)info.catch_obj(3) ;
* vec4 stroke = (vec4)info.catch_obj(4) ;
* float thickness = (float)info.catch_obj(5) ;
*/
void show_agent_dynamic(Info_Object style, ArrayList<Agent>... all_list) {
  for(ArrayList list : all_list) {
    if(INFO_DISPLAY_AGENT) {
      info_agent(list) ;
      info_agent_track_line(list) ;
    } else {
      update_aspect(style, list) ;
    }
  }
}


/**
Aspect 1.0.3
*/
boolean use_style = true ;
void use_style(boolean style) {
  use_style = style ;
}
/**
update aspect
*/
void update_aspect(Info_Object style, ArrayList list) {
  int costume_ID = 0 ;
  vec4 fill_vec =  vec4(0, 0 , g.colorModeZ, g.colorModeA) ;
  vec4 stroke_vec = vec4(g.colorModeX, g.colorModeY, g.colorModeZ, g.colorModeA) ;
  float thickness = 1 ;
  // float alpha_behavior = (float)style.catch_obj(4) ;
  boolean fill_is = true ;
  boolean stroke_is = true ;

  if(style.catch_obj(0) != null) costume_ID = ((Costume)style.catch_obj(0)).get_type();
  if(style.catch_obj(1) != null) fill_vec = (vec4)style.catch_obj(1);
  if(style.catch_obj(2) != null) stroke_vec = (vec4)style.catch_obj(2);
  if(style.catch_obj(3) != null) thickness = (float)style.catch_obj(3);
  // if(style.catch_obj(4) != null) alpha_behavior = (float)style.catch_obj(4) ;
  if(style.catch_obj(5) != null) fill_is = (boolean)style.catch_obj(5);
  if(style.catch_obj(6) != null) stroke_is = (boolean)style.catch_obj(6);




  for(Object o : list) {
    if(o instanceof Agent) {
      Agent a = (Agent) o ;
      boolean original_aspect = true ;
      vec4 fill_def ;
      vec4 stroke_def ;
      float thickness_def ;

      if(fill_vec != a.get_fill_style() || stroke_vec != a.get_stroke_style() || thickness != a.get_thickness()) {
        original_aspect = false ;
      }

      if(original_aspect) {
        fill_def = a.get_fill_style().copy() ;
        stroke_def = a.get_stroke_style().copy() ;
        thickness_def = a.get_thickness() ;
      } else {
        fill_def = fill_vec.copy() ;
        stroke_def = stroke_vec.copy() ;
        thickness_def = thickness ;
      }


      if(use_style) {
        if(a.get_melanin() != null) {
          vec4 map = map(a.get_melanin(), -1, 1, 0, 2);
          fill_def.mult(map) ;
          stroke_def.mult(map) ;
        }
        if(g.colorMode == 3) {
          if(fill_def.x > g.colorModeX) fill_def.x = fill_def.x - g.colorModeX ;
          if(stroke_def.x > g.colorModeX) stroke_def.x = stroke_def.x - g.colorModeX ;
        }
      }

      if(HORIZON_ALPHA) {
        if(fill_def != null) fill_def.set(fill_def.x, fill_def.y, fill_def.z, alpha(a)) ;
        if(stroke_def != null) stroke_def.set(stroke_def.x, stroke_def.y, stroke_def.z, alpha(a)) ;
      }

      // display

      if(!fill_is) {
        fill_def.alp(0);
      }
      if(!stroke_is) {
        thickness_def = 0 ;
      }
      a.aspect(fill_def, stroke_def, thickness_def) ;
      if(costume_ID != a.get_costume().get_type()) {
        a.set_costume(costume_ID) ;
      } else {
        a.costume() ;
      }
    }
    /*
    if(o instanceof Dead) {
      Dead d = (Dead) o ;
      boolean original_aspect = true ;

      if(costume_ID != d.get_costume() || fill_vec != d.get_fill_style() || stroke_vec != d.get_stroke_style() || thickness != d.get_thickness()) {
        original_aspect = false ;
      }
      if(original_aspect) {
        if(HORIZON_ALPHA) {
          vec4 new_fill = vec4(d.get_fill_style().x, d.get_fill_style().y, d.get_fill_style().z, alpha(d)) ;
          vec4 new_stroke = vec4(d.get_stroke_style().x, d.get_stroke_style().y, d.get_stroke_style().z, alpha(d)) ;
          d.aspect(new_fill, new_stroke, thickness) ;
        } else {
          d.aspect(d.get_fill_style(), d.get_stroke_style(), d.get_thickness()) ;
        }
        d.costume() ;

      } else {
        if(HORIZON_ALPHA) {
          vec4 new_fill = vec4(fill_vec.x, fill_vec.y, fill_vec.z, alpha(d)) ;
          vec4 new_stroke = vec4(stroke_vec.x, stroke_vec.y, stroke_vec.z, alpha(d)) ;
          d.aspect(new_fill, new_stroke, thickness) ;
        } else {
          d.aspect(fill_vec, stroke_vec, thickness) ;
        }

        if(costume_ID != d.get_costume()) {
          d.costume(costume_ID) ;
        } else {
          d.costume() ;
        }
      }
    }
    */
  }
}


float alpha(Agent a) {
  vec3 temp_pos = a.get_pos() ;
  int horizon_back = int(HORIZON * a.get_alpha_back()) ;
  int horizon_front = int(HORIZON * a.get_alpha_front()) ;
  horizon_back += a.get_alpha_cursor() ;
  horizon_front += a.get_alpha_cursor() ;
  float alpha = map(temp_pos.z, -horizon_back, horizon_front, 0 ,1) ;
  if(alpha <= 0 ) alpha = 0 ;
  alpha = alpha * g.colorModeA ;
  return alpha ;
}
/**
END SHOW

*/


























/**
INFO – LOG – PRINT
v 0.2.0
*/
boolean INFO_DISPLAY_AGENT = false ;


int FRAME_RATE_LOG = 300 ;

boolean PRINT_DEATH_AGENT_DYNAMIC = true ;
boolean PRINT_BORN_AGENT_DYNAMIC = true ;
boolean PRINT_POPULATION = true ;


boolean LOG_ECOSYSTEM = false ;
boolean LOG_ALL_AGENTS = false ;

boolean LOG_HERBIVORE = false ;
boolean LOG_OMNIVORE = false ;
boolean LOG_CARNIVORE = false ;
boolean LOG_FLORA = false ;
boolean LOG_BACTERIUM = false ;
boolean LOG_DEAD = false ;


boolean log_is ;
int SEQUENCE_LOG = 0 ;
// int col_num = 10 ;
// log Eco agent
processing.data.Table [] log_eco_agent ;
TableRow [] tableRow_eco_agent ;
// log Eco resume
processing.data.Table log_eco_resume ;
TableRow [] tableRow_eco_resume ;

// log Agent
processing.data.Table log_agents ;
TableRow [] tableRow_agents ;
int col_num_agents = 10 ;


boolean first_save = true  ;
String save_date = "" ;
String save_date() {
  if (first_save) {
    save_date = year()+"_"+month()+"_"+day()+"_"+hour()+"_"+minute() ;
    SEQUENCE_LOG = 0 ;
    first_save = false ;
  }
  return save_date ;
}


/**
LOG 1.0.0

*/
/**
Log ecosystem 0.0.1
*/


/**
set log
*/

void set_frameRate_log(int tempo) {
  FRAME_RATE_LOG = tempo ;
}


void set_log_ecosystem(boolean b) {
  LOG_ECOSYSTEM = b ;
}
void set_log_agents(boolean b) {
  LOG_ALL_AGENTS = b ;
}

void set_log_herbivore(boolean b) {
  LOG_HERBIVORE = b ;
}
void set_log_omnivore(boolean b) {
  LOG_OMNIVORE = b ;
}
void set_log_carnivore(boolean b) {
  LOG_CARNIVORE = b ;
}
void set_log_bacterium(boolean b) {
  LOG_BACTERIUM = b ;
}
void set_log_flora(boolean b) {
  LOG_FLORA = b ;
}
void set_log_dead(boolean b) {
  LOG_DEAD = b ;
}




// log
boolean log_is() {
  return log_is ;
}


void init_log() {
  if(log_agents != null) log_agents.clearRows() ;
  if(log_eco_resume != null) log_eco_resume.clearRows() ;
  if(log_eco_agent != null) {
    for(int i = 0 ; i <log_eco_agent.length ; i++) {
      if(log_eco_agent[i] != null) log_eco_agent[i].clearRows() ;
    }
  }
}



// build
void build_log(int num_table_eco) {
  log_is = true ;
  int rank = 0 ;

  // build log eco agent
  log_eco_agent = new processing.data.Table[num_table_eco] ;
  for(int i = 0 ; i < log_eco_agent.length ; i++) {
    log_eco_agent[i] = new processing.data.Table() ;
  }
  String [] col_name_eco_agent = new String[9] ;
  col_name_eco_agent[rank++] = "Time" ;
  col_name_eco_agent[rank++] = "Agent" ;
  col_name_eco_agent[rank++] = "Life" ;
  col_name_eco_agent[rank++] = "Stamina" ;
  col_name_eco_agent[rank++] = "Size" ;
  col_name_eco_agent[rank++] = "Child" ;
  col_name_eco_agent[rank++] = "Female" ;
  col_name_eco_agent[rank++] = "Male" ;
  col_name_eco_agent[rank++] = "Population" ;
  for(int i = 0 ; i < log_eco_agent.length ; i++) {
    buildTable(log_eco_agent[i], col_name_eco_agent) ;
  }



  // build log Eco resume
  log_eco_resume = new processing.data.Table() ;
  String [] col_name_eco_resume = new String[6] ;
  rank = 0 ;
  col_name_eco_resume[rank++] = "Time" ;
  col_name_eco_resume[rank++] = "Frame rate" ;
  col_name_eco_resume[rank++] = "Name" ;
  col_name_eco_resume[rank++] = "Units" ;
  col_name_eco_resume[rank++] = "Quantity" ;
  col_name_eco_resume[rank++] = "Max" ;
  buildTable(log_eco_resume, col_name_eco_resume) ;


  // build log agent global
  log_agents = new processing.data.Table() ;
  String [] col_name_agents = new String[13] ;
  rank = 0 ;
  col_name_agents[rank++] = "Rank" ;
  col_name_agents[rank++] = "Agent" ;
  col_name_agents[rank++] = "Gen" ;
  col_name_agents[rank++] = "Gender" ;
  col_name_agents[rank++] = "Pregnancy" ;
  col_name_agents[rank++] = "Children" ;
  col_name_agents[rank++] = "Heterozygous" ;
  col_name_agents[rank++] = "Homozygous" ;
  col_name_agents[rank++] = "Size" ;
  col_name_agents[rank++] = "Life" ;
  col_name_agents[rank++] = "Stamina" ;
  col_name_agents[rank++] = "Hunger" ;
  col_name_agents[rank++] = "Starving" ;
  buildTable(log_agents, col_name_agents) ;
}



void log_eco_agent(int which, String name, ArrayList... pop_list) {
  add_log_eco_agent(log_eco_agent[which], name, pop_list) ;
}

void log_eco_resume(float humus, float humus_max, ArrayList... pop_list) {
  add_log_eco_resume(log_eco_resume, humus, humus_max, pop_list) ;
}

void log_agent_global(String name, ArrayList... pop_list) {
  add_log_agent_global(log_agents, name, pop_list) ;
}



void log_save() {
  SEQUENCE_LOG++ ;

  // save
  for(int i = 0 ; i < log_eco_agent.length ; i++) {
    if(log_eco_agent[i].getRowCount() > 0) {
      TableRow row = log_eco_agent[i].getRow(0) ;
      String name_file = row.getString("Agent") ;
      saveTable(log_eco_agent[i], "log/Log_"+save_date()+"/ecosystem/eco_"+name_file+"_"+save_date()+".csv") ;
    }
  }
  saveTable(log_agents, "log/Log_"+save_date()+"/agent/agent_global/agent_global_"+SEQUENCE_LOG+".csv") ;
  log_agents.clearRows() ;

  saveTable(log_eco_resume, "log/Log_"+save_date()+"/ecosystem/resume/resume_"+SEQUENCE_LOG+".csv") ;
  log_eco_resume.clearRows() ;
}







// local
void add_log_eco_resume(processing.data.Table table, float humus, float humus_max, ArrayList... pop_list) {
  int num_group = 0 ;
  // humus
  TableRow new_row = table.addRow() ;
  new_row.setInt("Time", SEQUENCE_LOG) ;
  new_row.setInt("Frame rate", (int)frameRate) ;
  new_row.setString("Name", "Humus") ;
  new_row.setInt("Units", 1)  ;
  new_row.setFloat("Quantity", humus)  ;
  new_row.setFloat("Max", humus_max)  ;

  // agent
  for(ArrayList list : pop_list) {
    int units = 0 ;
    int max = 0 ;
    int quantity = 0 ;
    String name = "nobody" ;
    for(Object obj : list) {
      if(obj instanceof Agent) {
        Agent_model a = (Agent_model) obj ;
        units = list.size() ;
        max += a.stamina_ref ;
        quantity += a.stamina ;
      }
      if(obj instanceof Carnivore) name = "Carnivore" ;
      if(obj instanceof Herbivore) name = "Herbivore" ;
      if(obj instanceof Omnivore) name = "Omnivore" ;
      if(obj instanceof Bacterium) name = "Bacterium" ;
      if(obj instanceof Flora) name = "Flora" ;
      if(obj instanceof Dead) name = "Dead" ;
    }
    if(units > 0) {
      new_row = table.addRow() ;
      new_row.setInt("Time", SEQUENCE_LOG) ;
      new_row.setString("Name", name) ;
      new_row.setInt("Units", units)  ;
      new_row.setInt("Quantity", quantity)  ;
      new_row.setInt("Max", max)  ;
    }
  }
}



// agent global
void add_log_agent_global(processing.data.Table table, String name, ArrayList... pop_list) {
  int pop_total = 0 ;
  int rank = 0 ;
  for(int i = 0 ; i < pop_list.length ; i++) {
    pop_total += pop_list[i].size() ;
  }
  // size
  if(pop_total > 0 ) {
    for(ArrayList list : pop_list) {
      for(Object obj : list) {
        if(obj instanceof Agent_dynamic) {
          Agent_dynamic a = (Agent_dynamic) obj ;
          TableRow new_row = table.addRow() ;
          new_row.setInt("Rank", rank++) ;
          new_row.setString("Agent", a.name) ;
          new_row.setInt("Gen", a.generation) ;
          if(a.gender == 0 ) new_row.setString("Gender", "Female") ; else new_row.setString("Gender", "Male") ;
          new_row.setInt("Pregnancy", a.num_pregnancy) ;
          new_row.setInt("Children", a.num_children) ;
          new_row.setInt("Heterozygous", a.num_heterozygous) ;
          new_row.setInt("Homozygous", a.num_homozygous) ;
          new_row.setInt("Life", a.get_life()) ;
          new_row.setInt("Stamina", a.get_stamina()) ;
          new_row.setInt("Mass", a.get_mass()) ;
          new_row.setInt("Hunger", a.hunger) ;
          new_row.setString("Starving", String.valueOf(a.starving_bool)) ;
        }
      }
    }
  }
}
// log eco agent
void add_log_eco_agent(processing.data.Table table, String name, ArrayList... pop_list) {
  // pop
  int pop_total = 0 ;
  int stamina_total = 0 ;
  int life_total = 0 ;
  int mass_total = 0 ;
  // find data
  for(int i = 0 ; i < pop_list.length ; i++) {
    pop_total += pop_list[i].size() ;
  }
  // size
  if(pop_total > 0 ) {
    for(ArrayList list : pop_list) {
      for(Object obj : list) {
        if(obj instanceof Agent) {
          Agent a = (Agent) obj ;
          stamina_total += a.get_stamina() ;
          life_total += a.get_life() ;
          mass_total += a.get_mass() ;
        }
      }
    }
  }
  // write in table
  if(pop_list.length > 0 && pop_total > 0) {
    TableRow new_row = table.addRow() ;
    new_row.setString("Agent", name) ;
    new_row.setInt("Time", SEQUENCE_LOG) ;
    new_row.setInt("Stamina", stamina_total) ;
    if(life_total >= 0 ) new_row.setInt("Life", life_total) ;
    new_row.setInt("Mass", mass_total) ;
    // witout male or female
    if(pop_list.length == 1) {
      new_row.setInt("Population", pop_total) ;
    }
    // with male, female and child
    if(pop_list.length == 3) {
      new_row.setInt("Child", pop_list[0].size()) ;
      new_row.setInt("Female", pop_list[1].size()) ;
      new_row.setInt("Male", pop_list[2].size()) ;
      new_row.setInt("Population", pop_total) ;
    }
  }
}











/**
print 0.0.2
*/
void print_info_environment(Biomass biomass) {
  println("ENVIRONMENT") ;
  println("Humus", biomass.humus) ;
}


void print_born_agent_dynamic(Agent a) {
  if(a instanceof Agent_dynamic) {
    Agent_dynamic baby = (Agent_dynamic) a ;
    println("BORN") ;
    println("name", baby.name, baby.ID) ;
    /*
    println("generation", baby.generation) ;
    println("life", baby.life) ;
    println("expectancy", baby.life_expectancy) ;
    println("size", baby.size) ;
    println("stamina", baby.stamina) ;
    println("satiate", baby.satiate) ;
    println("hunger", baby.hunger) ;
    */
  }
}


void print_death_agent(Agent_dynamic dead) {
  println("DEATH") ;
  println("name", dead.name, dead.ID) ;
  //println("generation", dead.generation) ;
  //println("life", dead.life) ;
  //println("expectancy", dead.life_expectancy) ;
  println("size", dead.size) ;
  println("stamina", dead.stamina) ;
  println("satiate", dead.satiate) ;
  println("hunger", dead.hunger) ;
  // println("velocity", dead.velocity) ;
}





void print_pop_agent_dynamic(String name, ArrayList... pop_list) {
  int pop_total = 0 ;
  for(int i = 0 ; i < pop_list.length ; i++) {
    pop_total += pop_list[i].size() ;
  }
  if(pop_list.length > 0 && pop_total > 0) {
      if(pop_list.length == 1) println(name, pop_list[0].size(), ">", pop_total) ;
      if(pop_list.length == 2) println(name, pop_list[0].size(), pop_list[1].size(), ">", pop_total) ;
      if(pop_list.length == 3) println(name, pop_list[0].size(), pop_list[1].size(),  pop_list[2].size(), ">", pop_total) ;
  }
}


/**
print by category
*/

void print_info_herbivore(String title, ArrayList<Agent> list) {
 // println(title + " POPULATION ", list.size()) ;
  for(Agent a : list) {
    if(a instanceof Herbivore) {
      Herbivore h = (Herbivore) a ;
      //  println(title + " POPULATION ", list.size()) ;
     // h.info_print() ;
     // h.info_print_motion() ;
     // h.info_print_structure() ;
     // h.info_print_life() ;
     //h.info_print_feeding() ;
     // h.info_print_hunting_picking() ;
     // h.info_print_herbivore() ;

    }

  }
}

void print_info_omnivore(String title, ArrayList<Agent> list) {
  println(title + " POPULATION ", list.size()) ;
  for(Agent a : list) {
    if(a instanceof Omnivore) {
      Omnivore o = (Omnivore) a ;
  //  println(title + " POPULATION ", list.size()) ;
        // o.info_print_agent_() ;
   // o.info_print_motion() ;
  // o.info_print_caracteristic() ;
   // o.info_print_life() ;
   // o.info_print_feeding() ;
   // o.info_print_hunting_picking() ;
   // o.info_print_herbivore() ;
    }
  }
}


void print_info_carnivore(String title, ArrayList<Agent> list) {
  println(title + " population", list.size()) ;
  for(Agent a : list) {
    if(a instanceof Carnivore) {
      Carnivore c = (Carnivore) a ;
    // a_d.info_print() ;
    // a_d.info_print_motion() ;
      c.info_print_caracteristic() ;
      c.info_print_life() ;
      c.info_print_carnivore() ;
    }
  }
}



void print_info_bacterium(String title, ArrayList<Agent> list) {
  println(title + " population ", list.size()) ;
  for(Agent a : list) {
    if(a instanceof Bacterium) {
      Bacterium b = (Bacterium) a ;
      // b.info_print() ;
      // b.info_print_motion() ;
      b.info_print_caracteristic() ;
      b.info_print_life() ;
      b.info_print_feeding() ;
      b.info_print_hunting_picking() ;
      b.info_print_life() ;
      b.info_print_bacterium() ;
    }
  }
}



/**
INFO misc
v 0.1.0
*/
/*
void info_agent(ArrayList<Agent> list) {
  for(Agent a : list) {
    a.info(a.get_fill_style(), SIZE_TEXT_INFO) ;
  }
}
*/

void set_textSize_info(int size) {
  SIZE_TEXT_INFO = size ;
}


void info_agent(ArrayList list) {
  for(Object o : list) {
    if(o instanceof Agent) {
      Agent a = (Agent) o ;
      a.info(a.get_fill_style(), SIZE_TEXT_INFO) ;
    } else if(o instanceof Dead) {
      Dead d = (Dead) o ;
      d.info(d.get_fill_style(), SIZE_TEXT_INFO) ;

    }
  }
}

void info_agent_track_line(ArrayList<Agent> list) {
  for(Agent a : list) {
    if(a instanceof Carnivore) {
      Carnivore c = (Carnivore) a ;
      track_line(c.pos, c.pos_target, c.colour_info(c.get_stroke_style())) ;
      c.pos_target.set(MAX_INT) ;
    } else if (a instanceof Herbivore) {
      Herbivore h = (Herbivore) a ;
      track_line(h.pos, h.pos_target, h.colour_info(h.get_stroke_style())) ;
      h.pos_target.set(MAX_INT) ;
    } else if (a instanceof Omnivore) {
      Omnivore o = (Omnivore) a ;
      track_line(o.pos, o.pos_target, o.colour_info(o.get_stroke_style())) ;
      o.pos_target.set(MAX_INT) ;
    } else if (a instanceof Bacterium) {
      Bacterium b = (Bacterium) a ;
      track_line(b.pos, b.pos_target, b.colour_info(b.get_stroke_style())) ;
      b.pos_target.set(MAX_INT) ;
    }
  }
}

void track_line(vec3 pos, vec3 pos_target, vec4 colour) {
  if(!pos_target.equals(vec3(MAX_INT))) {
    stroke(colour) ;
    strokeWeight(1) ;
    line(pos, pos_target) ;
  }
}
/**
END
INFO – LOG – PRINT
*/



























/**

GROWTH
LIFE
DIE

*/
void update_growth(ArrayList<Agent> list) {
  for (Agent a : list) {
    a.growth() ;
  }
}


void update_die(ArrayList<Dead> list_dead, ArrayList<Agent> list) {
  // dead, possible to add to the dead list
  for(Agent a : list) {
    if(!a.get_alive()) {
      if(a instanceof Agent_dynamic) {
        Agent_dynamic a_d = (Agent_dynamic) a ;
        if(PRINT_DEATH_AGENT_DYNAMIC) {
          print_death_agent(a_d) ;
        }
        Dead dead = new Dead(a_d.pos, a_d.size, a_d.size_ref, a_d.nutrient_quality, a_d.name) ;
        list_dead.add(dead) ;
        list.remove(a) ;
        break ;
      }
    }
  }

  //disapear, retrun to the oblivion no return as possible !
  for(Agent a : list) {
    if(a.get_mass() < 0) {
      if(PRINT_DEATH_AGENT_DYNAMIC) {
        println("GO TO OBLIVION") ;
      }
      list.remove(a) ;
      break ;
    }
  }
}




  /**
Motion
*/
void update_motion(ArrayList<Agent> list) {
  for(Agent a : list) {
    if(a instanceof Agent_dynamic) {
      Agent_dynamic a_d = (Agent_dynamic) a ;
      a_d.rebound(LIMIT, REBOUND) ;
      a_d.motion() ;
    }
  }
}


/**
Statement

*/
void update_statement(ArrayList<Agent> list) {
  for(Agent a : list) {
    if(a instanceof Agent_dynamic) {
      Agent_dynamic a_d = (Agent_dynamic) a ;
      a_d.statement() ;
      a_d.hunger() ;
    }
  }
}


void update_log(ArrayList<Agent> list, int tempo) {
  for(Agent a : list) {
    if(a instanceof Agent_dynamic) {
      Agent_dynamic a_d = (Agent_dynamic) a ;
      if(!a_d.log_is()) a_d.build_log() ;
      a_d.log(tempo) ;
    }
  }
}
