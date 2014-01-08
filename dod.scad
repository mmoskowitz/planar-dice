diameter = 25*sqrt(3);
plane_thickness = diameter/27;
halfplane_emboss = plane_thickness / 5;
center_emboss = plane_thickness * 4/7;

module plane(){
	minkowski(){
 		linear_extrude(height=plane_thickness /300, center=true){
			child(0);
		}
		sphere(plane_thickness, $fn = 5);
	}
}

module halfplane(){
        translate([0,0,halfplane_emboss]){
	    linear_extrude(height=plane_thickness, center=false){
		child(0);
	    }
	}
}




module place(dir, dist=9/28){
f = diameter/36;
echo(dir);
	rotate(dir){
	translate([0,diameter*dist,0]){
	halfplane(){
	scale([f,f,f]){
		translate([-1.5,0,0]){
			child(0);
		}
	}
	}
	}
	}
}

module tet_tri() {
	plane(){
		polygon(points=[
			[diameter * .5 * sqrt(2)/sqrt(3), diameter * .5 / sqrt(3)],
			[diameter * -.5 * sqrt(2)/sqrt(3), diameter * .5 / sqrt(3)],
			[0, diameter * -.5 / sqrt(3)]
		]);
	}
}

module hex_squ(){
	plane(){
		square([diameter / sqrt(3) ,diameter / sqrt(3)], center=true);
	}

}

module dod_rec(){
	plane(){
		square([diameter * side, diameter * side * phi * phi], center=true);
	}
}

one = [
	[0,0],[0,1],[1,1],[1,4],[0,4],[1,5],[2,5],[2,1],[3,1],[3,0]
];
two = [
	[0,0],[0,1],[2,3],[2,4],[1,4],[1,3],[0,3],[0,4],[1,5],[2,5],[3,4],[3,3],[1,1],[3,1],[3,0]
];
three = [
	[0,1],[2,1],[2,2],[0,2],[2,4],[0,4],[0,5],[3,5],[3,4],[2,3],[3,2],[3,1],[2,0],[1,0]
];
four = [
	[3,0],[2,0],[2,2],[0,2],[0,4],[1,5],[1,3],[2,3],[2,5],[3,5]
];
five = [
	[0,1],[2,1],[2,2],[0,2],[0,4],[0,5],[3,5],[3,4],[1,4],[1,3],[2,3],[3,2],[3,1],[2,0],[1,0]
];
six = [
	[0,1],[0,4,],[1,5,],[2,5,],[3,4],[1,4],[1,1],[2,1],[2,2],[1.25,2],[1.25,3],[2,3],[3,2],[3,1],[2,0],[1,0]
];
seven = [
	[1,0],[1,1],[2,4],[0,4],[0,5],[3,5],[3,4],[2,2],[2,0]
];
eight = [
	[0,1],[0,2],[.5,2.5],[0,3],[0,4],[1,5],[1.75,5],[1.75,4],[1,4],[1,3],[2,3],[2,5],[3,4],[3,3],[2.5,2.5],[3,2],[3,1],[2,0],[1.25,0],[1.25,1],[2,1],[2,2],[1,2],[1,0]
];
nine = [
	[1,0],[2,2],[2,4],[1,4],[1,3],[1.75,3],[1.75,2],[1,2],[0,3],[0,4],[1,5],[2,5],[3,4],[3,2],[2,0]
];

zero = [
	[0,1],[0,4],[1,5],[2,5],[3,4],[3,1],[2,0],[2,4],[1,4],[1,1],[1.75,1],[1.75,0],[1,0]
];


phi = (1 + sqrt(5)) / 2;
side = 1/sqrt(pow(phi,4) + 1);

color("", 0.95){
	rotate([90,0,45]){
		tet_tri();
	    rotate([0,90,180]) {
			tet_tri();
		}
		translate([0,diameter/(2*sqrt(3)),0]){
			rotate([90,45,0]){
		   		hex_squ();
			}
		}
		translate([0,-diameter/(2*sqrt(3)),0]){
			rotate([90,45,0]){
		   		hex_squ();
			}
		}
	}
	difference(){
		dod_rec();
		place([0,0,0]){ polygon(five);} 
		place([0,180,0]){ polygon(two);} 
		place([180,0,0]){ polygon(eight);} 
		place([180,180,0]){ 
			union() {
				translate([-2,0,0]){polygon(one);}
				translate([2,0,0]){polygon(one);}
			}
		} 
	}
	rotate([0,90,90]){ 
	difference(){
		dod_rec();
		place([180,0,0]){ polygon(three);} 
		place([180,180,0]){ polygon(nine);} 
		place([0,180,0]){ polygon(four);} 
		place([0,0,0]){ 
			union() {
				translate([-2,0,0]){polygon(one);}
				translate([2,0,0]){polygon(zero);}
			}
		} 
	}
	}
	rotate([90,0,90]){ 
	difference(){
		dod_rec();
		place([0,0,0]){ polygon(one);} 
		place([0,180,0]){ polygon(seven);} 
		place([180,0,0]){ 
			union() {
				translate([-2,0,0]){polygon(one);}
				translate([2,0,0]){polygon(two);}
			}
		} 
		place([180,180,0]){ polygon(six);} 
	}
	}
}
