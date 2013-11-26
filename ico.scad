module plane(){
	linear_extrude(height=diameter/54, center=true){
		child(0);
	}
}

module halfplane(){
        translate([0,0,diameter/216]){
	    linear_extrude(height=diameter/54, center=false){
		child(0);
	    }
	}
}



module place(dir, dist=1/3){
f = diameter/72;
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

module center(planedir=0,numdir=0,clipdir=-135,front=true,doclip=true){
	f = diameter/36;
	r = front? 0 : 180;
	rotate([0,r,0]){
	halfplane(){
		scale([f,f,f]){ 
			rotate([0,0,-planedir]){
			intersection(){
			rotate([0,0,clipdir]){
			translate([.2,.2,0]){
				square([8,8],center=!doclip);
			}
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
diameter = 50*sqrt(3);

color("", 0.95){
	difference(){
		ico_rec();
		place([180,180,0]){two_digits(){polygon(one);polygon(six);}}
		place([180,0,0]){polygon(eight);}
		place([0,0,0]){two_digits(){polygon(one);polygon(three);}}
		place([0,180,0]){polygon(five);}
		center(-135,195,-135,true){ polygon(one);}
		center(135,105,45,true){ polygon(three);}
		center(-135,135,45,true){ polygon(six);}
		center(45,135,-135,false){two_digits(){polygon(one);polygon(zero);}}
		center(135,45,-135,true){two_digits(){polygon(one);polygon(one);}}
		center(135,45,-135,false){two_digits(){polygon(one);polygon(five);}}

		center(45,75,45,false){two_digits(){polygon(one);polygon(eight);}}

		center(-45,105,-135,false){ two_digits(){polygon(two);polygon(zero);}}
	}
	rotate([0,90,90]){
	difference(){
		ico_rec();
		place([180,180,0]){polygon(seven);}
		place([180,0,0]){two_digits(){polygon(one);polygon(seven);}}
		place([0,0,0]){polygon(four);}
		place([0,180,0]){two_digits(){polygon(one);polygon(four);}}
		center(-315,135,-135,true){ polygon(one);}
		center(135,-15,45,false){ polygon(three);}
		center(45,75,45,false){ polygon(six);}
		center(45,-105,-135,false){two_digits(){polygon(one);polygon(zero);}}
		center(-45,285,45,true){two_digits(){polygon(one);polygon(one);}}
		center(-45,-255,-135,true){two_digits(){polygon(one);polygon(five);}}

		center(45,195,45,true){two_digits(){polygon(one);polygon(eight);}}

		center(135,165,-135,false){ two_digits(){polygon(two);polygon(zero);}}
	}
	}
	rotate([90,0,90]){
	difference(){
		ico_rec();
		place([0,0,0]){two_digits(){polygon(one);polygon(nine);}}
		place([0,180,0]){polygon(nine);}
		place([180,180,0]){two_digits(){polygon(one);polygon(two);}}
		place([180,0,0]){polygon(two);}
		center(-135,75,-135,true){ polygon(one);}
		center(135,45,-135,true){ polygon(three);}
		center(45,-165,45,false){ polygon(six);}
		center(45,15,-135,true){two_digits(){polygon(one);polygon(zero);}}
		center(-45,-195,45,false){two_digits(){polygon(one);polygon(one);}}
		center(-45,-15,-135,true){two_digits(){polygon(one);polygon(five);}}

		center(45,135,-135,false){two_digits(){polygon(one);polygon(eight);}}

		center(135,-135,45,false){ two_digits(){polygon(two);polygon(zero);}}
	}
	}
}
