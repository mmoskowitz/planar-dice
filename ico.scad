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

module two_digits(){
	union(){
		translate([-2,0,0]){child(0);}
		translate([2,0,0]){child(1);}
	}
}

module ico_rec(){
	plane(){
		square([diameter * side, diameter * side * phi], center=true);
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
	[0,1],[0,4,],[1,5,],[2,5,],[3,4],[1,4],[1,1],[2,1],[2,2],[1.25,2],[1.25,3],[2,3],[3,2],[3,1],[2,0],[1.55,0],[2,-0.5],[1.5,-1],[1,-0.5],[1.45,0],[1,0]
];
seven = [
	[1,0],[1,1],[2,4],[0,4],[0,5],[3,5],[3,4],[2,2],[2,0]
];
eight = [
	[0,1],[0,2],[.5,2.5],[0,3],[0,4],[1,5],[1.75,5],[1.75,4],[1,4],[1,3],[2,3],[2,5],[3,4],[3,3],[2.5,2.5],[3,2],[3,1],[2,0],[1.25,0],[1.25,1],[2,1],[2,2],[1,2],[1,0]
];
nine = [
	[1,0],[2,2],[2,4],[1,4],[1,3],[1.75,3],[1.75,2],[1,2],[0,3],[0,4],[1,5],[2,5],[3,4],[3,2],[2,0],[1.55,0],[2,-0.5],[1.5,-1],[1,-0.5],[1.45,0]
];
zero = [
	[0,1],[0,4],[1,5],[2,5],[3,4],[3,1],[2,0],[2,4],[1,4],[1,1],[1.75,1],[1.75,0],[1,0]
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

phi = (1 + sqrt(5)) / 2;
side = 1/sqrt(pow(phi,2) + 1);

color("", 0.95){
//  union(){  
  difference(){ 
      union(){
	difference(){
		ico_rec();
		place([180,180,0]){two_digits(){polygon(one);polygon(six);}}
		place([180,0,0]){polygon(eight);}
		place([0,0,0]){two_digits(){polygon(one);polygon(three);}}
		place([0,180,0]){polygon(five);}
	}
	rotate([0,90,90]){
	difference(){
		ico_rec();
		place([180,180,0]){polygon(seven);}
		place([180,0,0]){two_digits(){polygon(one);polygon(seven);}}
		place([0,0,0]){polygon(four);}
		place([0,180,0]){two_digits(){polygon(one);polygon(four);}}
	}
	}
	rotate([90,0,90]){
	difference(){
		ico_rec();
		place([0,0,0]){two_digits(){polygon(one);polygon(nine);}}
		place([0,180,0]){polygon(nine);}
		place([180,180,0]){two_digits(){polygon(one);polygon(two);}}
		place([180,0,0]){polygon(two);}
	}
	}
     }
     corner([atan(sqrt(2)),180,-45]){
         two_digits(){polygon(two);polygon(zero);}
     }
     corner([atan(sqrt(2)),0,-45 + 180]){
         polygon(one);
     }
     corner([atan(sqrt(2)),180,-45 + 180]){
         two_digits(){polygon(one);polygon(five);}
     }
     corner([atan(sqrt(2)),0,-45]){
	 polygon(six);
     }
     corner([atan(sqrt(2)),180,45]){
         two_digits(){polygon(one);polygon(zero);}
     }
     corner([atan(sqrt(2)),0,45 + 180]){
         two_digits(){polygon(one);polygon(one);}
     }
     corner([atan(sqrt(2)),180,45 + 180]){
         two_digits(){polygon(one);polygon(eight);}
     }
     corner([atan(sqrt(2)),0,45]){
         polygon(three);
     }
/*
*/
  }
}
