
	width = 60;
	height = 40;
	depth = 40; 

fudge = 0.1;

module poly_Line(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[209.687349,-171.365009],[204.171069,-170.542527],[198.249849,-168.740009],[191.961390,-166.266402],[185.558692,-163.344918],[173.585140,-157.117116],[164.678317,-151.974197],[161.187349,-149.833759],[161.093649,-149.771259],[160.968649,-149.677509],[-272.156351,164.103741],[-273.272421,165.244251],[-273.854524,166.741030],[-273.856179,168.347015],[-273.230902,169.815141],[-272.030469,170.866493],[-270.503814,171.365009],[-268.900190,171.277928],[-267.468851,170.572491],[165.437399,-143.052509],[165.468599,-143.052509],[177.688585,-150.189395],[189.171771,-156.181021],[195.163682,-158.936283],[200.906099,-161.208759],[206.039459,-162.743724],[209.999849,-163.365009],[212.093599,-163.146259],[212.249849,-163.083759],[212.261309,-161.671775],[211.940485,-159.906470],[211.124849,-157.396259],[207.635076,-150.313099],[201.468599,-140.583759],[197.797162,-134.635263],[194.951017,-128.720629],[192.888549,-122.860210],[191.568144,-117.074362],[190.948186,-111.383438],[190.987061,-105.807793],[191.643154,-100.367782],[192.874849,-95.083759],[194.620702,-89.972959],[196.814527,-85.040687],[199.407595,-80.289401],[202.351179,-75.721557],[205.596549,-71.339613],[209.094978,-67.146027],[216.656099,-59.333759],[224.893058,-52.195077],[233.648366,-45.595119],[242.167068,-39.808813],[249.694209,-35.111089],[246.019243,-32.180051],[243.056469,-29.885479],[253.321700,-26.808177],[263.303236,-24.329186],[273.856179,-22.073719],[269.533278,-30.398105],[264.596499,-38.852586],[258.224479,-48.434369],[256.579234,-45.032085],[255.283085,-42.631558],[254.002789,-40.797609],[246.733531,-45.435388],[238.616710,-51.273563],[230.231256,-57.960922],[222.156099,-65.146259],[215.118143,-72.432465],[208.959160,-80.276277],[206.309614,-84.381174],[204.000209,-88.594142],[202.071076,-92.904735],[200.562349,-97.302509],[199.497898,-101.781597],[198.907208,-106.348541],[198.838835,-111.011507],[199.341331,-115.778662],[200.463252,-120.658172],[202.253151,-125.658205],[204.759582,-130.786929],[208.031099,-136.052509],[214.583625,-146.340416],[216.888703,-150.653132],[218.593599,-154.490009],[219.768047,-157.964944],[220.366129,-161.171821],[220.249821,-164.139353],[219.281099,-166.896259],[218.432941,-168.134354],[217.375235,-169.177161],[214.906099,-170.615009],[212.320296,-171.259984],[209.687349,-171.365009]]);
  }
}


module bkThesisShoulder() {
	
	module core() { 
		union() {
			cube([width, depth, height], center = true);
			translate([0,3,height - 31]) {
				rotate(a=[45,0,0]) cube([width / 2, depth, height + 10], center = true);
			}
		}
	}

	module hole() { 
		module armSide() {
			union() {
				translate([0,-32,0]) {
					resize(newsize=[width + 10,35,height + 30]) cylinder(height + 2,20,20, center = true);
					resize(newsize=[width - 10,40,height + 30]) cylinder(height + 2,20,20, center = true);

					translate([0,-1,0]) {
						rotate(a=[-3,0,0]) {
							resize(newsize=[width + 30,30,height + 50]) cylinder(height + 2,20,20, center = true);
							translate([0,-9,0]) {
								rotate(a=[-11,0,0]) {
									resize(newsize=[width - 5,38,height + 50]) cylinder(height + 2,20,20, center = true);
								}
							}	
						}
					}

				}	
			}
		}

		module corners() {
			union() {
				translate([-(width / 2) - 1,-(depth / 2) - 1,0]) {
					rotate(a=[0,0,45]) cube([6, 6, height + 2], center = true);
				}
				translate([(width / 2) + 1,(depth / 2) - 5,0]) {
					rotate(a=[0,0,45]) cube([6, 6, height + 2], center = true);
				}
				translate([-(width / 2) - 1,(depth / 2) - 5,0]) {
					rotate(a=[0,0,45]) cube([6, 6, height + 2], center = true);
				}
				translate([(width / 2) + 1,-(depth / 2) - 1,0]) {
					rotate(a=[0,0,45]) cube([6, 6, height + 2], center = true);
				}
				translate([-(width / 2) - 1,0, height - 20]) {
					rotate(a=[90,45,0]) cube([6, 6, height + 2], center = true);
				}
				translate([(width / 2) + 1,0,height - 20]) {
					rotate(a=[90,45,0]) cube([6, 6, height + 2], center = true);
				}
				translate([-(width / 2) - 1,0, height - 60]) {
					rotate(a=[90,45,0]) cube([6, 6, height + 2], center = true);
				}
				translate([(width / 2) + 1,0, height - 60]) {
					rotate(a=[90,45,0]) cube([6, 6, height + 2], center = true);
				}
				translate([0,0,-height]) {
					cube([width, depth, height], center = true);
				}
				translate([0,0,height + 5]) {
					cube([width, depth, height], center = true);
				}
			}
		}

		module frontPlate() {
			union() {
				translate([0,depth + 4,0]) {
					cube([width, depth, height], center = true);
				}
				translate([(width / 2) + 10,(depth / 2) + 22,0]) {
					rotate(a=[0,0,160]) cube([width, width, height * 4], center = true);
				}
				translate([-(width / 2) - 10,(depth / 2) + 22,0]) {
					rotate(a=[0,0,200]) cube([width, width, height * 4], center = true);
				}
				translate([0,2,0]) {
					cube([width - 10, depth - 17, height * 2], center = true);
				}
			}
		}
		
		module grips() {
			union() {
				translate([-(width / 2) + 12,-(depth / 2) - 1,-1]) {
					rotate(a=[0,0,55]) cube([3,depth, height * 0.3], center = true);
				}
				translate([(width / 2) + 1,-(depth / 2) + 8,-1]) {
					rotate(a=[0,0,305]) cube([3, depth, height * 0.3], center = true);
				}
				translate([-(width / 2) + 12,-(depth / 2) - 1,5]) {
					rotate(a=[0,45,55]) cube([2.1,depth, 2.1], center = true);
				}
				translate([(width / 2) + 1,-(depth / 2) + 8,5]) {
					rotate(a=[0,45,305]) cube([2.1, depth, 2.1], center = true);
				}
			}
		}

		module thruHoles() {
			//cylinder(height,20,20, center = true);
			translate([-(width / 3),depth/3+1,10]) {
				rotate(a=[-90,60,20]) cylinder(10,2,2, center = true);
			}
			translate([(width / 3),depth/3+1,10]) {
				rotate(a=[-90,60,-20]) cylinder(10,2,2, center = true);
			}
			translate([0,depth/3+1,(height / 2 - 5)]) {
				rotate(a=[-45,0,0]) cylinder(20,2,2, center = true);
			}
			translate([0,depth/4+2,(height / 3 - 1)]) {
				rotate(a=[-45,0,0]) cylinder(20,5,5, center = true);
			}
		}

		union() {
			armSide();
			corners();
			frontPlate();
			grips();
			pattern();
			thruHoles();
		}
	}

	difference() {
		core();
		hole();
	}
}

module bkThesisShoulderBottom() {

	module core() { 
		union() {
			cube([width, depth, height], center = true);
		}
	}

	module hole() { 
		module armSide() {
			union() {
				translate([0,-32,0]) {
					resize(newsize=[width + 10,35,height + 30]) cylinder(height + 2,20,20, center = true);
					resize(newsize=[width - 10,40,height + 30]) cylinder(height + 2,20,20, center = true);
					
				}
			}
		}

		module corners() {
			union() {
				translate([-(width / 2) - 1,-(depth / 2) - 1,0]) {
					rotate(a=[0,0,45]) cube([6, 6, height + 2], center = true);
				}
				translate([(width / 2) + 1,(depth / 2) - 5,0]) {
					rotate(a=[0,0,45]) cube([6, 6, height + 2], center = true);
				}
				translate([-(width / 2) - 1,(depth / 2) - 5,0]) {
					rotate(a=[0,0,45]) cube([6, 6, height + 2], center = true);
				}
				translate([(width / 2) + 1,-(depth / 2) - 1,0]) {
					rotate(a=[0,0,45]) cube([6, 6, height + 2], center = true);
				}
				translate([-(width - 10.5),0, height - 20]) {
					rotate(a=[90,-6,0]) cube([45, 100, height + 2], center = true);
				}
				translate([(width -10.5),0,height - 20]) {
					rotate(a=[90,6,0]) cube([45, 100, height + 2], center = true);
				}
				translate([-(width / 2) - 1,depth-20, height - 60]) {
					rotate(a=[90,-5,-65]) cube([20, 100, height + 2], center = true);
				}
				translate([(width / 2) + 1,depth - 20, height - 60]) {
					rotate(a=[90,5,65]) cube([20, 100, height + 2], center = true);
				}
				translate([0,0,-height]) {
					cube([width, depth, height], center = true);
				}
				translate([0,0,height + 5]) {
					cube([width, depth, height], center = true);
				}
			}
		}

		module frontPlate() {
			union() {
				translate([0,depth + 4,0]) {
					cube([width, depth, height], center = true);
				}
				translate([(width / 2) + 10,(depth / 2) + 22,0]) {
					rotate(a=[0,0,160]) cube([width, width, height * 4], center = true);
				}
				translate([-(width / 2) - 10,(depth / 2) + 22,0]) {
					rotate(a=[0,0,200]) cube([width, width, height * 4], center = true);
				}
				translate([0,0.5,22]) {
					cube([width - 17, depth - 20, height * 2], center = true);
				}
				translate([0,depth - 10,0]) {
					rotate(a=[-10,0,0]) cube([width, depth - 20, height * 2], center = true);
				}
				translate([0,depth - 10,-12]) {
					rotate(a=[-30,0,0]) cube([width, depth - 20, height * 2], center = true);
				}
			}
		}
	
		union(){
			armSide();
			corners();
			frontPlate();
		}
	}

	translate([0,0,-height]) {
		difference() {
			core();
			hole();
		}
	}
}

module wholeShoulder() {
		
		module core() {
			bkThesisShoulder();
			bkThesisShoulderBottom();
		}

		module hole() {
		module adjust() {
		translate([0,0,-6]) {
			scale([0.9,0.9,0.9]) {
				translate([-width - 22,depth - 18.5,-18]) {
					rotate(a=[-90,0,0]) poly_Line(5);
				}
				translate([width / 2 + 2,depth - 18.5,height * 2 - 23]) {
					rotate(a=[-90,110,0]) poly_Line(10);
				}
				translate([-width / 2 + 28 ,depth - 18.5,-height * 2 - 20]) {
					rotate(a=[-90,270,0]) poly_Line(5);
				}
			}
		}
		}
		module adjustby() {
				translate([0,depth-8,10.7]) {
					cube([width, depth, height], center = true);
				}
				
				translate([-35.6,depth-8,-20.7]) {
					rotate(a=[0,-101,0]) cube([width, depth, height], center = true);
				}
				
				translate([35.6,depth-8,-20.7]) {
					rotate(a=[0,101,0]) cube([width, depth, height], center = true);
				}
		}
		difference() {
			adjust();
			adjustby();
		}
		}

		difference() {
			core();
			hole();
		}

}

scale([1.2,1,1.2]) {
	wholeShoulder();
}
