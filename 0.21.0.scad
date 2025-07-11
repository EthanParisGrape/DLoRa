// flue pipe

include <OpenSCAD_support/common.scad>
include <OpenSCAD_support/traverse_flue.scad>
include <OpenSCAD_support/traverse_labium.scad>
include <OpenSCAD_support/pipe_version.scad>

// variables
outerDiameter = 32;
innerDiameter = 28;
labiumWidth = 23.4158;
outCut = 7.0248;
totalLength = 279.6128;
outerTube = 12;         // air supply tube
innerTube = 8;
minWallThickness = 1.2;
floorThickness = 2;
flueWidth = 0.6;
connector = 0;          // 1 for on/existing

// proportions, are most likely good like that
lengthFlue = totalLength / 8;
tubeInsert = outerTube + 2.5;       // length
pipeInsert = innerDiameter * 0.1 + 5; // length
height = floorThickness
    + lengthFlue
    + labiumWidth / 2
    + tubeInsert; 
soundingLength = height - pipeInsert - floorThickness;

// announcing sounding length
echo(str("the sounding length inside the model in mm: ", soundingLength));

// announcing tube length
echo(str("tube needed (in mm): ", totalLength - soundingLength));
    
// calculations, don't touch in production use
ground = (lengthFlue + floorThickness)*-1;
airSupplyX = -innerDiameter/2 - outCut;
labium_polygon_points = 
    [[0,-outerDiameter/2],
    [innerDiameter/2, -outerDiameter],
    [-outCut, -outerDiameter],
    [-outCut, 0],
    [innerDiameter/2,0]];

// logic
difference(){
    union(){
        basicShapeRound(height); 
        outer_traverse_flue();
        high_cut_up_connector();
    };
    union(){
        inner_traverse_flue(); 
        airSupplySpacerTraverse(x=airSupplyX);
        labium_cut();
        airdome();
    };
};

// version number
vertical_version_number ("0.21");

echo(version = version());
