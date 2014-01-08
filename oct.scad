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



module place(dir, dist=2/7){
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


module corner(angle=[atan(sqrt(2)),0,45], doclip=true){
   f = diameter/27;
   rotate(angle){
     intersection(){
//     union(){
       linear_extrude(height=diameter){
        scale([f,f,f]){
	translate([-1.5,-2.5,0]){
		child(0);
	}
	}
       }
       rotate([-atan(sqrt(2)),0,0]){
       rotate([0,0,-135]){
       translate([center_emboss, center_emboss, center_emboss]){
       cube(size = diameter/2);
       }
       }
       }
     }
   }
}

module center(planedir=0,numdir=0,clipdir=-135,front=true){
	f = diameter/36;
	r = front? 0 : 180;
	rotate([0,r,0]){
	halfplane(){
		scale([f,f,f]){ 
			rotate([0,0,-planedir]){
			intersection(){
			rotate([0,0,clipdir]){
				square([diameter,diameter],center=false);
			}
			scale([1,sqrt(3),1]){
			rotate([0,0,planedir]){
			rotate([0,0,numdir]){
			translate([-1.5,-2.5,0]){
				child(0);
			}
			}
			}
			}
			}
		}
	}
	}
	}
}

module oct_tri(){
	plane(){
		polygon(points=[[0,diameter/sqrt(3)],[diameter/sqrt(3),0],[-0.5 * diameter/sqrt(3), -0.5 * diameter/sqrt(3)]]);
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
target = [
	[1.495, 5],
	[1.25,4],
	[1.75,4],
	[1.505, 5],
	[1.5 + 1.25*sqrt(3),1.255],
	[3,1.75],
	[3,1.5],
	[2.5,1.5],
	[1.5 + 1.25*sqrt(3),1.245],
	[1.5 - 1.25*sqrt(3),1.245],
	[0.5,1.5],
	[0,1.5],
	[0.5,1.75],
	[0,1.65],
	[1.5 - 1.25*sqrt(3),1.255]
];

color("", 0.95){
 difference(){
// union(){
   union(){
	difference(){
	oct_tri();
	place([0,0,-45], 1/4){polygon(two);}
	place([0,180,-45], 1/4){polygon(four);}
	//center(45,135,-135,false){polygon(one);}
	//center(-45,-135,45,true){polygon(eight);}
	}
	rotate(a=[90,180,0]){
		difference(){
			oct_tri();
		place([0,0,-45], 1/4){polygon(seven);}
		place([0,180,-45], 1/4){polygon(six);}
		//center(135,165,-135,true){polygon(one);}
		//center(-135,-165,45,false){polygon(eight);}
		}
	}
	rotate(a=[90,-90,90]){
		difference(){
			oct_tri();
		place([0,0,-45], 1/4){polygon(three);}
		place([0,180,-45], 1/4){polygon(five);}
		//center(-45,-75,45){polygon(one);}
		//center(45,75,-135,false){polygon(eight);}
		}
	}
    }
     corner([atan(sqrt(2)),180,45]){
         polygon(one);
     }
     corner([atan(sqrt(2)),0,45 + 180]){
         polygon(eight);
     }

  }
}