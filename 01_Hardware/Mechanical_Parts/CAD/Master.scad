
/* Tynes Subassemblies parameters*/
l=1000;
tines_num=5;
sq_tb= 3;// inches;
sh_thick=10;

d_b_tines=l/tines_num;


/*Lead Parameters*/
l_lead=300;

/* linear_extrude(height = fanwidth, center = true, convexity = 10) */
module tines(){
color("red")
rotate([0,90,0])linear_extrude(height = sh_thick)import (file = "outsidetine.dxf");
/* cube(size=[10, 10, 10], center=true); */
}



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

rotate([0,90,0])linear_extrude(height = sh_thick)import(file="hinch.dxf");


}

module mount_cylinder(){
		for (i=[0:4]) {
		translate([i*(sh_thick+sh_thick*0.2), 0, 0])rotate([0,90,0])linear_extrude(height = sh_thick)import(file="mount_cylinder.dxf");
	}

}

// Square tube
module sq_tube(){
	difference() {
		cube([l-sh_thick*2,sq_tb*(24.5),sq_tb*(24.5)], center=true);
		cube(size=[l+l*0.2, sq_tb*(24.5)-15, sq_tb*(24.5)-15], center=true);
 	}
}


// Square tube bottom
translate([-sh_thick*2,-20,50]){
translate([sh_thick*2+l/2,0,50])rotate([75,0,0])color("yellow")
// Squre tube top
sq_tube([l-sh_thick*2,sq_tb*(24.5),sq_tb*(24.5)]);

for (i=[0:1]) {
	translate([i*l/2,0,0]){
	color("green"){
	rotate([-15,0,0])translate([l/2/2+l_lead/2,-55,420])hinch();
	rotate([-15,0,0])translate([l/2/2-l_lead/2,-55,420])hinch();
	rotate([-15,0,0])translate([l/2/2-sh_thick*2,-55,420])mount_cylinder();
	}
	}
}



translate([sh_thick*2+l/2,105,450])rotate([75,0,0])color("blue")
sq_tube([l-sh_thick*2,sq_tb*(24.5),sq_tb*(24.5)]);
}





/*tynes
- [] hinches

 sub-asssembly*/
translate([d_b_tines,0,0])for (i=[0:tines_num-2])
   translate([i*d_b_tines,0,0])
     rotate([0,90,0])linear_extrude(height = sh_thick)import(file="insidetine.dxf");

translate([l,0,0])tines();
tines();
