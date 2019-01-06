columns = 8;        // number of columns
cap = 5;            // height of 'enter' cap
corner_radius = 2;  // radius of corners
height = 1.5;       // height of whole object
cable_width = 1.05; // cable width (add some reserve to pass though cap)
column_width = 5;   // column width in cap
length = 35;        // bigger length, more cables you can put

$fn=50;

hull() {
   translate ([corner_radius, corner_radius, 0]) {
    cylinder (h=height, r=corner_radius);
   }

   total_width = columns * (column_width+cable_width) - 2 * cable_width;   
   translate ([total_width - corner_radius, corner_radius, 0]) {
      cylinder (h=height, r=corner_radius); 
   }
}

for (i = [0:columns-1]) {
    translate([i * (column_width+cable_width), corner_radius, 0]) {
        cube([column_width - cable_width, length, height]);

        translate([0, length, 0]) {
            ci = column_width - (i + 1 == columns ? cable_width : 0);
            
            cube([ci, cap, height]);
            hull() {
                radius=1;
                translate([radius, cap, 0]) {
                    cylinder (h=height, r=radius); 
                }
                translate([ci-radius, cap, 0]) {
                    cylinder (h=height, r=radius); 
                }
            }
        }
    }
}