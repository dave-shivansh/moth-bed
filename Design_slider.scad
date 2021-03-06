// User Var in mm. ALL VARIABLES MUST BE POSITIVE!
l_u = 100; //Length of the main bed
w_u = 30; //Width of the main bed
H_u = 20; //Height of the main structure
wr_l_u = 50; //Length of the wing-rest
wr_w_u = 50; //Width of the wing-rest
pr_h_u = 10; //height of the proboscis rest
pr_w_u = 5;
t_u = 1; //Overall thickness. VERY IMPORTANT!
w_disp_u = 5; //displacement of the wingrests from the front of the main body
c_h_u = 5; //Overall height of the cap 
g_w_u = 0.4; //Grooves
g_h_u = 0.15; //Grooves

//Program Variables
l = l_u + t_u; //Length of the main bed
w = w_u + (2*t_u); //Width of the main bed
H = H_u + t_u; //Height of the main structure
wr_l = wr_l_u; //Length of the wing-rest
wr_w = wr_w_u; //Width of the wing-rest
pr_h = pr_h_u; //height of the proboscis rest
pr_w = pr_w_u;
t = t_u; //Overall thickness. VERY IMPORTANT!
w_disp = w_disp_u; //displacement of the wingrests from the front of the main body
c_h = c_h_u; //Overall height of the cap 
g_w = g_w_u;
g_h = g_h_u;
pos = 0 || 1; // Specifies whether the structure goes left or right. 0 is left; 1 is right. Or vice-versa.


module bed(length,width){
    cube([length, width, t], true);
    }

module side(pos){
    rotate([90,0,0]){
        if(pos== 1){
            translate([0,((H/2)-t/2),(w/-2)+t/2]){
                bed(l,H);
                }
                }else if(pos ==0){
                    translate([0,((H/2)-t/2),((w/2)-t/2)]){
                        bed(l,H);
   }
  }
 }
}

module wing(pos){
    if(wr_l < (l-w_disp)){
        if(pos == 1){
        translate([((l-wr_l)/2)-w_disp,-((wr_w+w-t)/2),H-t]){
            bed(wr_l,wr_w);
            }
            }else if(pos == 0){
                translate([((l-wr_l)/2)-w_disp,((w+wr_w-t)/2),H-t]){
                    bed(wr_l,wr_w);
   }
  }
 }
}
module cap_wing(pos){
    if(wr_l < l-w_disp){
        if(pos == 1){
        translate([((l-wr_l)/2)-w_disp,((wr_w+w)/2),0]){
            bed(wr_l,wr_w);
            }
            }else if(pos == 0){
                translate([((l-wr_l)/2)-w_disp,-((wr_w+w)/2),0]){
            bed(wr_l,wr_w);
            }
  }
 }
}
module proboscis_rest(){
    translate([(l+pr_h)/2,0,0]){
        rotate([0,180,0]) {
            bed(pr_h,pr_w);
}
 }
}
module endcap(){
    translate([(l/-2)+t/2,0,(H/2)-t/2]){
        rotate([0,90,0]){
            bed(H,w);
        }
    }
}
module useful_module(){
    bed(l,w);
    cap_wing(1); cap_wing(0);
    rotate([90,0,0]){
        union(){
            translate([-(wr_l+w_disp)/2,(-c_h/2)+t/2,(w+t)/2]){
            bed(l-(w_disp+wr_l),c_h);//back left lateral
            }
            translate([-(wr_l+w_disp)/2,-c_h/2+t/2,-(w-t)/2]){
                bed(l-(w_disp+wr_l),c_h);//back right lateral
            }
            rotate([0,90,0]) translate([0,-(c_h-t)/2,(-l/2)+t/2]){
                bed(w,c_h);//back horizontal
            }
//            rotate([0,-90,0])translate([0,-(c_h-t)/2,(-l/2)+t/2]){
//                bed(w,c_h);//front horizontal
//            }
            translate([(l/2-w_disp+(w_disp/2)),-(c_h-t)/2,(w-t)/2]){
                bed(w_disp,c_h);//front left lateral
            }  
            translate([l/2-w_disp+(w_disp/2),-(c_h-t)/2,-(w-t)/2]){
                bed(w_disp,c_h);//front right lateral
            }
            rotate([0,90,0]) translate([(w+wr_w-t)/2,-(c_h-t)/2,(l/2-wr_l-w_disp)+t/2]){
                bed(wr_w+t,c_h);//back right wingrest
            }
            rotate([0,90,0]) translate([(w+wr_w-t)/2,-(c_h-t)/2,(l/2-w_disp)-(t/2)]){
                bed(wr_w+t,c_h);//front right wingrest
            }
            rotate([0,90,0]) translate([-(w+wr_w+(t/8))/2,-(c_h-t)/2,(l/2-wr_l-w_disp)+t/2]){
                bed(wr_w,c_h); //back left wingrest
            }
            rotate([0,90,0])translate([-(w+wr_w-t)/2,-(c_h-t)/2,(l/2-w_disp)-t/2]){
                bed(wr_w+t,c_h);//front left wingrest
            }
            translate([(l+t)/2-2*w_disp,-(c_h-t)/2,(w/2)+wr_w-t/2]) {
                bed(wr_l,c_h);//left wingspanner
            }
            translate([(l+t)/2-2*w_disp,-(c_h-t)/2,-((w/2)+wr_w-t/2)]){
                bed(wr_l,c_h);//right wingspanner
            }
        }
    }
}
module groove(pos){
        if(pos==1){
            translate([(-w_disp-wr_l)/2,-w/2+g_h,7/8*H]){
                rotate([ 90.00, 0.00, 0.00 ]){
                    union(){
                        resize([(l-w_disp-wr_l),g_w,g_h]){
                        rotate([0,0,45]){
                                cylinder(r1=1,r2 = 1/1.3,h=1,false,$fn = 4);
                            //change the denominator of r2 to get different angles on the groove
                        }
                    }
                    translate([-w/2,0,0]){
                        resize([(l-w_disp-wr_l),g_w,g_h]){
                        rotate([0,0,45]){
                                cylinder(r1=1,r2 = 1/1.3,h=1,false,$fn = 4);
                            //change the denominator of r2 to get different angles on the groove
                        }
                    }
                }
                }
            }
        }
    }else{
            translate([(-w_disp-wr_l)/2,w/2,7/8*H]){
                rotate([ 90.00, 0.00, 0.00 ]){
                    union(){
                        resize([(l-w_disp-wr_l),g_w,g_h]){
                        rotate([0,0,45]){
                                cylinder(r1=1,r2 = 1/1.3,h=1,false,$fn = 4);
                            //change the denominator of r2 to get different angles on the groove
                        }
                    }
                    translate([-w/2,0,0]){
                        resize([(l-w_disp-wr_l),g_w,g_h]){
                        rotate([0,0,45]){
                                cylinder(r1=1,r2 = 1/1.3,h=1,false,$fn = 4);
                            //change the denominator of r2 to get different angles on the groove
                            }
                        }
                    }
                }
            }
        }
    }
}
 module holder_downer(){
     difference(){
     useful_module(); 
     translate([wr_l,0,0])cylinder(h = (t*1.008), r = t, center = true);
 }
}
module moth_sacrificer(){
    rotate([180,0,180]){
        rotate([270,90,0]){
            difference(){
                union(){
                    bed(l,w);
                    endcap();
                    side(1);      side(0);
                    wing(1);      wing(0);
                    proboscis_rest();
                }
                groove(1);
                groove(0);
            }
        }
    }
}
//groove(1);
moth_sacrificer();
//translate([ 0.00, H+c_h, 0.00 ])rotate([ 90.00, 270.00, 180.00 ]}holder_downer();

// FIXME : Calculate program variables using user variables !