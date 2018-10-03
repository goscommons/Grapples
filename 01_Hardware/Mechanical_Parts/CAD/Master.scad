
/* Tynes Subassemblies parameters*/
l=1600;
tynes_num=10;
sq_tb= 3;// inches;
sh_thick=10;

d_b_tynes=l/tynes_num;


/*Lead Parameters*/
l_lid=450;
l_ratio=(l_lid-l_lid*0.1)/450;

/* Tynes Assembly
- [x] In Out Gussets for out tynes
- [x] In gussets for inside tynes

*/
module tynes(){
color("red"){
translate([-sh_thick,0,0])rotate([0,90,0])linear_extrude(center=true,  height = sh_thick)import (file = "ingussets.dxf");

}

translate([-410,100,25])
rotate([0,90,-30])linear_extrude(center=true,  height = sh_thick)import (file = "gussets.dxf");

rotate([0,90,0])linear_extrude(center=true,  height = sh_thick)import (file = "outsidetine.dxf");

}

/* tynes(); */
/*Support Assembly
- [] mount cylinder base 01
- [] ssqa_module
- [] hinch 01
- [] Bussings for Cylinder 01
- [] Bushings for Cylinder 02
- [] pin 1
- [] pin 2
- [] Support plate on to of square tubing
*/

module hinch(){
rotate([0,90,0])linear_extrude(center=true,  height = sh_thick)import(file="hinch.dxf");

}

module mount_cylinder(){
		for (i=[0:4]) {
		translate([i*(sh_thick+sh_thick*0.1)-sh_thick*2, 0, 0])rotate([0,90,0])linear_extrude(center=true,  height = sh_thick)import(file="mount_cylinder.dxf");
	}

}

// Square tube
module sq_tube(length,size){
	/* difference() {
		cube([l,sq_tb*(24.5),sq_tb*(24.5)], center=true);
		cube(size=[l+l*0.2, sq_tb*(24.5)-15, sq_tb*(24.5)-15], center=true);
 	} */

	difference(length,size) {
		cube([length,size*24.5,size*24.5], center=true);
		cube([length+length*0.2, size*(24.5)-15, size*(24.5)-15], center=true);
	}
}


module in_tynes(){
	rotate([0,90,0])
	linear_extrude(center=true,  height = sh_thick)
	import(file="insidetine.dxf");
	color("red"){
	translate([-sh_thick,0,0])rotate([0,90,0])linear_extrude(center=true,  height = sh_thick)import (file = "ingussets.dxf");
	translate([sh_thick,0,0])rotate([0,90,0])linear_extrude(center=true,  height = sh_thick)import (file = "ingussets.dxf");

	translate([415,115,30])
	rotate([0,90,30])linear_extrude(center=true,  height = sh_thick)import (file = "gussets.dxf");
	mirror([1,0,0]){
	translate([405,115,30])
	rotate([0,90,30])linear_extrude(center=true,  height = sh_thick)import (file = "gussets.dxf");
	}
	}
}

/* in_tynes(); */

translate([l/2,710,44])
color("white")
rotate([0,90,0])
difference(){
	cylinder(r=17, h=l, center=true);
	cylinder(r=15, h=l+l*0.2, center=true);
}

module integration(){
// Square tube bottom
translate([-sh_thick*2,-20,40]){
translate([sh_thick*2+l/2,0,50])rotate([75,0,0])color("yellow")
// Squre tube top
sq_tube(l,3);

for (i=[0:1]) {
	translate([i*l/2,0,0]){
	color("green"){
	rotate([-15,0,0])translate([l/2/2+l_lid/2,-55,420])hinch();
	rotate([-15,0,0])translate([l/2/2-l_lid/2,-55,420])hinch();
	rotate([-15,0,0])translate([l/2/2,-55,420])mount_cylinder();
	}
	}
}


translate([sh_thick*2+l/2,105,450])rotate([75,0,0])color("blue")
sq_tube(l,3);
}

translate([d_b_tynes,0,0])for (i=[0:tynes_num-2])
   translate([i*d_b_tynes,0,0])
	 // Replace this by a module
     /* rotate([0,90,0])linear_extrude(center=true,  height = sh_thick)import(file="insidetine.dxf"); */
		 in_tynes();

translate([l,0,0])tynes();
mirror([1, 0, 0]) {
	translate([0,0,0])
	tynes();
	}
}

/* integration(); */


/*Lids subassembly*/
module lids(){
/* - [] thickness space, coupling connection
*/
module lid_plate(){
translate([0,0,700])rotate([0,90,0])linear_extrude(center=true,  height = sh_thick)import (file = "lid_plate.dxf");
}
translate([l_lid/2-sh_thick*1.3,0,0])
lid_plate();
mirror(){
	translate([l_lid/2-sh_thick*1.3,0,0])
	lid_plate();
	}
}

module up_plate(){
	linear_extrude(height = sh_thick)import (file = "brace_plate_lid_upper.dxf");
}

module front_plate(){
	linear_extrude(height = 10)
	import (file = "brace_plate_lid_front.dxf");
}

color("yellow"){
translate([l/4.25,181,-155])
lids();

translate([l/4.25,200,530])
rotate([-6, 0, 0])
rotate([0,0,90])
scale([1,l_ratio,1])
up_plate();

translate([l/4.25,865,210])
rotate([-77,0,0])
rotate([0,0,270])
scale([1,l_ratio,1])
front_plate();


translate([l/4-l/4*0.05,780,450])
rotate([62,0,0])
sq_tube(l_lid-l_lid*0.05,2.2);

}
