within PlanarMechanics.GearComponents;
model RigidNoLossExternal "External rigid gear gonnection model"
  extends PlanarMechanics.Utilities.Icons.PlanarGearContactExternalL1;
  extends PlanarMechanics.Interfaces.PartialTwoFramesAndHeat;

  parameter SI.Distance r_a=1 "Radius of gear A";
  parameter SI.Distance r_b=1 "Radius of gear B";

  parameter Boolean animate = true "= true, if animation shall be enabled" annotation(Evaluate=true, HideResult=true);
  parameter SI.Angle StartAngle_a = 0 "Start Angle of gear A" annotation (HideResult=true,
      Dialog(tab="Animation", group="If animation = true", enable=animate));
  parameter SI.Angle StartAngle_b = 0 "Start Angle of gear B" annotation (HideResult=true,
      Dialog(tab="Animation", group="If animation = true", enable=animate));
  parameter Integer Tooth_a(min=1) = 20 "Number of Tooth" annotation (HideResult=true,
      Dialog(tab="Animation", group="If animation = true", enable=animate));
  final parameter Integer Tooth_b(min=1) = integer(
    PlanarMechanics.Utilities.Functions.round(Tooth_a/r_a*r_b)) "Number of Tooth"
      annotation (HideResult=true,
        Dialog(tab="Animation", group="If animation = true", enable=animate));

  parameter Real RGB_a[3]={195,0,0} "Color (RGB values)" annotation (HideResult=true,
      Dialog(colorSelector=true, tab="Animation", group="If animation = true", enable=animate));

  parameter Real RGB_b[3]={0,0,195} "Color (RGB values)" annotation ( HideResult=true,
    Dialog(colorSelector=true, tab="Animation", group="If animation = true", enable=animate));

  parameter SI.Distance z_offset=0 "Offset of z-distance for simulation" annotation (HideResult=true,
      Dialog(tab="Animation", group="If animation = true", enable=animate));

  SI.AngularVelocity w_a "Angular speed of gear A";
  SI.AngularVelocity w_b "Angular speed of gear B";
  SI.AngularVelocity w_gear "Angular speed of gear the overall gear contact";

  SI.Force F_n "Mesh normal force";

  SI.Velocity v_mesh "Mesh speed";
  SI.Acceleration a_mesh "Mesh acceleration";
  SI.Length xmesh_a "Mesh position of gear A";
  SI.Length xmesh_b "Mesh position of gear B";
  SI.Angle phi_gear "Gear angle";

protected
  SI.Angle phi_gear2=atan2(frame_b.y - frame_a.y, frame_b.x - frame_a.x)
    "Temporary Gear angle";
  Modelica.SIunits.AngularVelocity dphi_gear2 "Temporary Gear angle";
 //Visualization

  MB.Visualizers.Advanced.Shape pointA(
    shapeType="cylinder",
    specularCoefficient=0.5,
    length=0.15,
    width=r_a/10,
    height=r_a/10,
    lengthDirection={0,0,1},
    widthDirection={1,0,0},
    r_shape={0,0,-0.03},
    r=MB.Frames.resolve1(planarWorld.R,{frame_a.x,frame_a.y,z_offset})+planarWorld.r_0,
    R=planarWorld.R) if planarWorld.enableAnimation and   animate;

  MB.Visualizers.Advanced.Shape pointB(
    shapeType="cylinder",
    specularCoefficient=0.5,
    length=0.15,
    width=r_a/10,
    height=r_a/10,
    lengthDirection={0,0,1},
    widthDirection={1,0,0},
    r_shape={0,0,-0.03},
    r=MB.Frames.resolve1(planarWorld.R,{frame_b.x,frame_b.y,z_offset})+planarWorld.r_0,
    R=planarWorld.R) if planarWorld.enableAnimation and   animate;

  MB.Visualizers.Advanced.Shape Gearwheel_a(
    shapeType="gearwheel",
    color=RGB_a,
    specularCoefficient=0,
    length=0.1,
    width=r_a*2,
    height=r_a*2,
    lengthDirection={0,0,1},
    widthDirection={0,0,1},
    r_shape={0,0,0},
    r=MB.Frames.resolve1(planarWorld.R,{frame_a.x,frame_a.y,z_offset})+planarWorld.r_0,
    extra=Tooth_a,
    R=MB.Frames.absoluteRotation(planarWorld.R,MB.Frames.planarRotation(
        {0,0,1},
        frame_a.phi + (StartAngle_a - (mod(Tooth_a, 2))*2*Modelica.Constants.pi/Tooth_a/4),
        0))) if planarWorld.enableAnimation and animate;

  MB.Visualizers.Advanced.Shape Gearwheel_b(
    shapeType="gearwheel",
    color=RGB_b,
    specularCoefficient=0,
    length=0.1,
    width=r_b*2,
    height=r_b*2,
    lengthDirection={0,0,1},
    widthDirection={0,0,1},
    r_shape={0,0,0},
    r=MB.Frames.resolve1(planarWorld.R,{frame_b.x,frame_b.y,z_offset})+planarWorld.r_0,
    extra=Tooth_b,
    R=MB.Frames.absoluteRotation(planarWorld.R,MB.Frames.planarRotation(
        {0,0,1},
        frame_b.phi + (StartAngle_b + (1 - mod(Tooth_b, 2))*2*Modelica.Constants.pi/Tooth_b/4),
        0))) if planarWorld.enableAnimation and animate;

  constant SI.Acceleration unitAcceleration=1;
  constant SI.Force unitForce=1;
initial equation
  phi_gear = atan2(frame_b.y - frame_a.y, frame_b.x - frame_a.x);
equation

  w_gear = der(phi_gear);
  dphi_gear2 = der(phi_gear2);
  der(phi_gear) = dphi_gear2;

  lossPower = 0;

// Derivatives
  w_a = der(frame_a.phi);
  w_b = der(frame_b.phi);
  a_mesh = der(v_mesh);

//  ********** Mesh position & speed ***************
  xmesh_a = frame_a.phi*r_a - phi_gear*r_a;
  xmesh_b = -frame_b.phi*r_b + phi_gear*r_b;
  xmesh_a - xmesh_b = 0;
  v_mesh = der(xmesh_a);

// ***********  EOM *******************

// Torques on the axis
  frame_a.t = F_n*r_a;
  frame_b.t = F_n*r_b;
// Forces on the axis
  frame_a.fx = -sin(phi_gear)*F_n;
  frame_a.fy =  cos(phi_gear)*F_n;
// Force balace
  frame_a.fx + frame_b.fx = 0;
  frame_a.fy + frame_b.fy = 0;

  annotation (defaultComponentName="gear",Diagram(graphics={
        Polygon(
          points={{38.6901,40.9645},{39.3284,42.8041},{41.9096,46.8087},{
              44.5357,46.0609},{44.6201,41.2972},{44.1935,39.3973},{47.0172,
              38.2626},{48.024,39.9292},{51.3814,43.3096},{53.7946,42.0322},{
              52.8868,37.3551},{52.0745,35.5854},{54.6006,33.8884},{55.9319,
              35.3093},{59.9188,37.9178},{62.0136,36.1665},{60.1532,31.7803},{
              58.9908,30.2182},{61.1088,28.0331},{62.7064,29.1461},{67.1485,
              30.8687},{68.8335,28.7202},{66.1018,24.8167},{64.64,23.5304},{
              66.2574,20.9526},{68.0515,21.7092},{72.7547,22.4705},{73.9562,
              20.0187},{70.4725,16.7684},{68.7753,15.8141},{69.8213,12.9564},{
              71.7336,13.3234},{76.4923,13.0903},{77.1577,10.4422},{73.0745,
              7.9872},{71.2159,7.4067},{71.6449,4.394},{73.5917,4.3554},{78.198,
              3.1379},{78.2983,0.4094},{73.7938,-1.143},{71.8552,-1.3244},{
              71.6485,-4.3605},{73.5446,-4.803},{77.7971,-6.9516},{77.3279,
              -9.6414},{72.5992,-10.2233},{70.6652,-9.9976},{69.8317,-12.9244},
              {71.5945,-13.7515},{75.3073,-16.7372},{74.2892,-19.2707},{69.5428,
              -18.8567},{67.6979,-18.2339},{66.2742,-20.9235},{67.8265,-22.099},
              {70.8374,-25.7914},{69.3147,-28.0578},{64.7581,-26.6661},{63.0831,
              -25.6733},{61.1313,-28.0081},{62.4052,-29.4806},{64.5827,-33.7184},
              {62.6221,-35.6187},{58.4544,-33.31},{57.0223,-31.9906},{54.6278,
              -33.8686},{55.5677,-35.5738},{56.8165,-40.1717},{54.5037,-41.6228},
              {50.9071,-38.4981},{49.7806,-36.9098},{47.0479,-38.2489},{47.6128,
              -40.1123},{47.8783,-44.8693},{45.3143,-45.8079},{42.446,-42.0036},
              {41.6744,-40.2159},{38.723,-40.9575},{38.8881,-42.8976},{38.1588,
              -47.6059},{35.4557,-47.9909},{33.441,-43.6734},{33.0579,-41.7643},
              {30.0168,-41.8761},{29.775,-43.8082},{28.0827,-48.2619},{25.3586,
              -48.0765},{24.2856,-43.4344},{24.3078,-41.4874},{21.3099,-40.9645},
              {20.6716,-42.8041},{18.0904,-46.8087},{15.4643,-46.0609},{15.3799,
              -41.2972},{15.8065,-39.3973},{12.9828,-38.2626},{11.976,-39.9292},
              {8.6186,-43.3096},{6.2054,-42.0322},{7.1132,-37.3551},{7.9255,
              -35.5854},{5.3994,-33.8884},{4.0681,-35.3093},{0.0812,-37.9178},{
              -2.0136,-36.1665},{-0.1532,-31.7803},{1.0092,-30.2182},{-1.1088,
              -28.0331},{-2.7064,-29.1461},{-7.1485,-30.8687},{-8.8335,-28.7202},
              {-6.1018,-24.8167},{-4.64,-23.5304},{-6.2574,-20.9526},{-8.0515,
              -21.7092},{-12.7547,-22.4705},{-13.9562,-20.0187},{-10.4725,
              -16.7684},{-8.7753,-15.8141},{-9.8213,-12.9564},{-11.7336,
              -13.3234},{-16.4923,-13.0903},{-17.1577,-10.4422},{-13.0745,
              -7.9872},{-11.2159,-7.4067},{-11.6449,-4.394},{-13.5917,-4.3554},
              {-18.198,-3.1379},{-18.2983,-0.40937},{-13.7938,1.143},{-11.8552,
              1.3244},{-11.6485,4.3605},{-13.5446,4.803},{-17.7971,6.9516},{
              -17.3279,9.6414},{-12.5992,10.2233},{-10.6652,9.9976},{-9.8317,
              12.9244},{-11.5945,13.7515},{-15.3073,16.7372},{-14.2892,19.2707},
              {-9.5428,18.8567},{-7.6979,18.2339},{-6.2742,20.9235},{-7.8265,
              22.099},{-10.8374,25.7914},{-9.3147,28.0578},{-4.7581,26.6661},{
              -3.0831,25.6733},{-1.1313,28.0081},{-2.4052,29.4806},{-4.5827,
              33.7184},{-2.6221,35.6187},{1.5456,33.31},{2.9777,31.9906},{
              5.3722,33.8686},{4.4323,35.5738},{3.1835,40.1717},{5.4963,41.6228},
              {9.0929,38.4981},{10.2194,36.9098},{12.9521,38.2489},{12.3872,
              40.1123},{12.1217,44.8693},{14.6857,45.8079},{17.554,42.0036},{
              18.3256,40.2159},{21.277,40.9575},{21.1119,42.8976},{21.8412,
              47.6059},{24.5443,47.9909},{26.559,43.6734},{26.9421,41.7643},{
              29.9832,41.8761},{30.2251,43.8082},{31.9173,48.2619},{34.6414,
              48.0765},{35.7144,43.4344},{35.6922,41.4874}},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{-35.977,22.4878},{-34.8831,24.6535},{-32.9407,26.8978},{
              -31.8083,27.739},{-29.7455,26.7376},{-29.706,25.3275},{-30.2679,
              22.413},{-31.2931,20.2139},{-28.7696,18.3875},{-27.001,20.0486},{
              -24.4081,21.4932},{-23.0562,21.8963},{-21.4604,20.2498},{-21.9055,
              18.9112},{-23.4304,16.3647},{-25.1458,14.6489},{-23.3992,12.0695},
              {-21.1691,13.0255},{-18.2386,13.4962},{-16.8303,13.4126},{
              -15.8938,11.3196},{-16.77,10.214},{-19.0738,8.3426},{-21.2727,
              7.3169},{-20.5135,4.2957},{-18.091,4.4313},{-15.1762,3.8713},{
              -13.8815,3.3112},{-13.7173,1.0241},{-14.9188,0.2848},{-17.7237,
              -0.68579},{-20.1408,-0.89754},{-20.4607,-3.9962},{-18.1379,
              -4.6973},{-15.5904,-6.2205},{-14.5653,-7.1897},{-15.1933,-9.395},
              {-16.5752,-9.6788},{-19.5429,-9.6315},{-21.8866,-9.0037},{
              -23.2471,-11.8061},{-21.3041,-13.2594},{-19.4313,-15.562},{
              -18.7995,-16.8233},{-20.1439,-18.6809},{-21.5394,-18.4749},{
              -24.312,-17.4154},{-26.2997,-16.024},{-28.5365,-18.192},{-27.2078,
              -20.2222},{-26.2355,-23.0265},{-26.0732,-24.4278},{-27.9718,
              -25.7135},{-29.2128,-25.0427},{-31.4558,-23.0988},{-32.8477,
              -21.1115},{-35.6911,-22.3837},{-35.1369,-24.7459},{-35.1823,
              -27.7137},{-35.5091,-29.086},{-37.733,-29.6448},{-38.6697,-28.59},
              {-40.1125,-25.9962},{-40.7408,-23.6526},{-43.8479,-23.8756},{
              -44.135,-26.2849},{-45.1927,-29.0581},{-45.9692,-30.2359},{-48.25,
              -30.0005},{-48.7695,-28.6889},{-49.2382,-25.758},{-49.027,
              -23.3409},{-52.023,-22.4878},{-53.1169,-24.6535},{-55.0593,
              -26.8978},{-56.1917,-27.739},{-58.2545,-26.7376},{-58.294,
              -25.3275},{-57.7321,-22.413},{-56.7069,-20.2139},{-59.2304,
              -18.3875},{-60.999,-20.0486},{-63.5919,-21.4932},{-64.9438,
              -21.8963},{-66.5396,-20.2498},{-66.0945,-18.9112},{-64.5696,
              -16.3647},{-62.8542,-14.6489},{-64.6008,-12.0695},{-66.8309,
              -13.0255},{-69.7614,-13.4962},{-71.1697,-13.4126},{-72.1062,
              -11.3196},{-71.23,-10.214},{-68.9262,-8.3426},{-66.7273,-7.3169},
              {-67.4865,-4.2957},{-69.909,-4.4313},{-72.8238,-3.8713},{-74.1185,
              -3.3112},{-74.2827,-1.0241},{-73.0812,-0.28477},{-70.2763,0.6858},
              {-67.8592,0.8975},{-67.5393,3.9962},{-69.8621,4.6973},{-72.4096,
              6.2205},{-73.4347,7.1897},{-72.8067,9.395},{-71.4248,9.6788},{
              -68.4571,9.6315},{-66.1134,9.0037},{-64.7529,11.8061},{-66.6959,
              13.2594},{-68.5687,15.562},{-69.2005,16.8233},{-67.8561,18.6809},
              {-66.4606,18.4749},{-63.688,17.4154},{-61.7003,16.024},{-59.4635,
              18.192},{-60.7922,20.2222},{-61.7645,23.0265},{-61.9268,24.4278},
              {-60.0282,25.7135},{-58.7872,25.0427},{-56.5442,23.0988},{
              -55.1523,21.1115},{-52.3089,22.3837},{-52.8631,24.7459},{-52.8177,
              27.7137},{-52.4909,29.086},{-50.267,29.6448},{-49.3303,28.59},{
              -47.8875,25.9962},{-47.2592,23.6526},{-44.1521,23.8756},{-43.865,
              26.2849},{-42.8073,29.0581},{-42.0308,30.2359},{-39.75,30.0005},{
              -39.2305,28.6889},{-38.7618,25.758},{-38.973,23.3409}},
          fillColor={255,160,160},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5,
          pattern=LinePattern.None),
        Line(
          points={{-100,0},{-44,0}},
          thickness=1),
        Line(
          points={{30,0},{100,0}},
          thickness=1)}),
    Icon(
        graphics={
        Line(
          visible=useHeatPort,
          points={{-100,-100},{-100,-40},{-16,-40},{-16,0}},
          color={191,0,0},
          pattern=LinePattern.Dot)}),
    Documentation(
      revisions=
"<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p></html>",
      info="<html>
<p>In this model an ideal gear connection is modelled. It is based on the paper from van der Linden: <a href=\"http://dx.doi.org/10.3384/ecp12076303\">Modelling of Elastic Gearboxes Using a Generalized Gear Contact Model</a>. However, no gear elasticity is modelled.</p>
<p>The planar model of an external gear wheel is used to build complex gear models. A <a href=\"http://dx.doi.org/10.3384/ecp12076681\">planar library</a> is used to create the constraints of the gearwheels. An example can be found in <a href=\"modelica://PlanarMechanics.GearComponents.Examples.SpurGear\">SpurGear</a>.</p>
<p>Using different parts from the planar library, it is possible to build complex gear systems. However, especially since no elasticity is included, kinematic loops can lead to complications and should be handled with care.</p>
<p>This model is suitable for: </p>
<ul>
<li>Kinematic analysis of gear systems and gear-like systems.</li>
<li>Modelling of multiple gear stage models with clutches.</li>
</ul>

<h4>Literature</h4>
<ol>
<li>van der Linden, F., Modelling of Elastic Gearboxes Using a Generalized Gear Contact Model, <i>Proceedings of the 9th International MODELICA Conference, Linkoping University Electronic Press, </i><b>2012</b>, 303-310 </li>
</ol>
</html>"));
end RigidNoLossExternal;
