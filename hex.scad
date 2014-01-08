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



module place(dir, dist=2/9){
f = diameter/36;
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

color("", 0.95){
   intersection(){
    union(){
	difference(){
		tet_tri();
		place([0,0,52.5]){polygon(points=four);}
		place([0,0,-52.5]){polygon(points=two);}
		place([0,180,52.5]){polygon(points=five);}
		place([0,180,-52.5]){polygon(points=three);}
		
	}
    rotate([0,90,180]) {
		difference(){
			tet_tri();
		place([0,0,52.5]){polygon(points=four);}
		place([0,0,-52.5]){polygon(points=five);}
		place([0,180,52.5]){polygon(points=two);}
		place([0,180,-52.5]){polygon(points=three);}
		}
	}
}
rotate(0, 0, 0){
cube([diameter, diameter/sqrt(3), diameter], center=true);
}
}
	translate([0,diameter/(2*sqrt(3)),0]){
		rotate([90,45,0]){
			difference(){
	   			hex_squ();
				place([0,180,45], 1/4){polygon(points=one);}
				place([0,180,135], 1/4){polygon(points=one);}
				place([0,180,-135], 1/4){polygon(points=one);}
				place([0,180,-45], 1/4){polygon(points=one);}
			}
		}
	}
	translate([0,-diameter/(2*sqrt(3)),0]){
		rotate([90,45,0]){
			difference(){
	   			hex_squ();
				place([0,0,45], 1/4){polygon(points=six);}
				place([0,0,135], 1/4){polygon(points=six);}
				place([0,0,-135], 1/4){polygon(points=six);}
				place([0,0,-45], 1/4){polygon(points=six);}
			}
		}
	}
}