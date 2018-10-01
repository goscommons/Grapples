

l=2000;
tines_num=15;

d_b_tines=l/tines_num;

/* linear_extrude(height = fanwidth, center = true, convexity = 10) */
module tines(){
color("red")
rotate([0,90,0])linear_extrude(height = 10)import (file = "outsidetine.dxf");
/* cube(size=[10, 10, 10], center=true); */
}

translate([l,0,0])tines();
tines();
/* rotate([0,90,0])linear_extrude(height = 10)import(file="insidetine.dxf"); */

translate([d_b_tines,0,0])for (i=[0:tines_num-2])
   translate([i*d_b_tines,0,0])
     rotate([0,90,0])linear_extrude(height = 10)import(file="insidetine.dxf");
