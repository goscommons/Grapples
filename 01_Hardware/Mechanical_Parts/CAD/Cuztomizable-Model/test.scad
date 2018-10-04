
l=600;
l_ratio=l/450;

/* cube([20,450,10], center=true); */
module plato(args) {
	linear_extrude(height = 10)
	import (file = "cylinder_rod_mount_in.dxf");
}

scale([1,1,1])plato();
