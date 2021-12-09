within PlanarMechanics.GearComponents;
model RigidNoLossInternal "Internal rigid gear connection model"
  extends PlanarMechanics.Utilities.Icons.PlanarGearContactInternalL1;
  extends PlanarMechanics.Interfaces.PartialTwoFramesAndHeat;

  import Modelica.Math.Vectors.length;

  parameter SI.Distance r_a=1 "Radius of gear A";
  parameter SI.Distance r_b=1 "Radius of gear B";

  parameter Boolean animate = true "= true, if animation shall be enabled" annotation(Evaluate=true, HideResult=true);
  parameter Integer Tooth_a(min=1) = 20 "Number of Tooth" annotation (
      HideResult=true,
      Dialog(tab="Animation", group="If animation = true", enable=animate));
  final parameter Integer Tooth_b(min=1) = integer(
    PlanarMechanics.Utilities.Functions.round(Tooth_a/r_a*r_b)) "Number of Tooth"
    annotation (HideResult=true,
      Dialog(tab="Animation", group="If animation = true", enable=animate));

  parameter Real RGB_a[3]={195,0,0} "Color A (RGB values)" annotation ( HideResult=true,Dialog(
      colorSelector=true,
      tab="Animation",
      group="If animation = true",
      enable=animate));

  parameter Real RGB_b[3]={0,0,195} "Color B (RGB values)" annotation (HideResult=true,Dialog(
      colorSelector=true,
      tab="Animation",
      group="If animation = true",
      enable=animate));

  parameter SI.Distance z_offset=0 "Offset of z-distance for simulation" annotation ( HideResult=true,Dialog(
     tab="Animation",
      group="If animation = true",
      enable=animate));


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
  SI.Velocity v_relx "Relative velocity in x between frame_b to frame_a";
  SI.Velocity v_rely "Relative velocity in y between frame_b to frame_a";
  SI.Position s_relx "Relative position in x from frame_b to frame_a";
  SI.Position s_rely "Relative position in y from frame_b to frame_a";
  Real res "Residual (shall be =0)";

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
    R=planarWorld.R) if planarWorld.enableAnimation and animate;

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
    R=planarWorld.R)  if planarWorld.enableAnimation and animate;

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
    extra=-Tooth_a*sign(r_a-r_b),
    R=MB.Frames.absoluteRotation(planarWorld.R,MB.Frames.planarRotation(
        {0,0,1},
        frame_a.phi,
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
    extra=Tooth_b*sign(r_a-r_b),
    R=MB.Frames.absoluteRotation(planarWorld.R,MB.Frames.planarRotation(
        {0,0,1},
        frame_b.phi,
        0))) if planarWorld.enableAnimation and animate;

  constant SI.Acceleration unitAcceleration=1;
  constant SI.Force unitForce=1;

initial equation
  phi_gear = atan2(frame_a.y - frame_b.y, frame_a.x - frame_b.x);
equation
  lossPower = 0;

  w_gear = der(phi_gear);
  s_relx = frame_a.x-frame_b.x;
  s_rely = frame_a.y-frame_b.y;
  v_relx = der(s_relx);
  v_rely = der(s_rely);

  // For the circular movement in 3D, there is the following relation
  // between angular velocity, radius and velocity:
  //   v3_rel = w3_vec X r3_rel,
  // with all vectors being of dimension 3.
  // => this cross product yields e.g. y-component of the relative velocity
  //    v3_rel_y = w3_vec_z*r3_relx - w3_vec_x*r3_relz
  //
  // Back to 2D we set:
  //   r3_rel = {s_relx, s_rely, 0}
  //   v3_rel = {v_relx, v_rely, 0}
  //   w3_vec = {0, 0, w_gear}
  // and hence:
  v_rely = w_gear*s_relx;

  // Residual given by orthogonality condition, i.e. scalar product of v_rel and r_rel
  res = if noEvent(length({v_relx, v_rely}) > Modelica.Constants.eps) then
    {s_relx, s_rely, 0}*{v_relx, v_rely, 0} / length({s_relx, s_rely}) / length({v_relx, v_rely}) else
    length({s_relx, s_rely}) - (r_a + r_b);

// Derivatives
  w_a = der(frame_a.phi);
  w_b = der(frame_b.phi);
  a_mesh = der(v_mesh);

//  ********** Mesh position & speed ***************
  xmesh_a = frame_a.phi*r_a - phi_gear*r_a;
  xmesh_b = frame_b.phi*r_b - phi_gear*r_b;
  xmesh_a - xmesh_b = 0;
  v_mesh = der(xmesh_a);

// ***********  EOM *******************

// Torques on the axis
  frame_a.t = F_n*r_a;
  frame_b.t = -F_n*r_b;
// Forces on the axis
  frame_a.fx = -sin(phi_gear)*F_n;
  frame_a.fy = cos(phi_gear)*F_n;
// Force balace
  frame_a.fx + frame_b.fx = 0;
  frame_a.fy + frame_b.fy = 0;

  annotation (defaultComponentName="gear",Diagram(graphics={
        Line(
          points={{38,0},{98,0}},
          thickness=1),
        Polygon(
          points={{8.6901,40.9645},{9.3284,42.8041},{11.9096,46.8087},{14.5357,
              46.0609},{14.6201,41.2972},{14.1935,39.3973},{17.0172,38.2626},{
              18.024,39.9292},{21.3814,43.3096},{23.7946,42.0322},{22.8868,
              37.3551},{22.0745,35.5854},{24.6006,33.8884},{25.9319,35.3093},{
              29.9188,37.9178},{32.0136,36.1665},{30.1532,31.7803},{28.9908,
              30.2182},{31.1088,28.0331},{32.7064,29.1461},{37.1485,30.8687},{
              38.8335,28.7202},{36.1018,24.8167},{34.64,23.5304},{36.2574,
              20.9526},{38.0515,21.7092},{42.7547,22.4705},{43.9562,20.0187},{
              40.4725,16.7684},{38.7753,15.8141},{39.8213,12.9564},{41.7336,
              13.3234},{46.4923,13.0903},{47.1577,10.4422},{43.0745,7.9872},{
              41.2159,7.4067},{41.6449,4.394},{43.5917,4.3554},{48.198,3.1379},
              {48.2983,0.4094},{43.7938,-1.143},{41.8552,-1.3244},{41.6485,
              -4.3605},{43.5446,-4.803},{47.7971,-6.9516},{47.3279,-9.6414},{
              42.5992,-10.2233},{40.6652,-9.9976},{39.8317,-12.9244},{41.5945,
              -13.7515},{45.3073,-16.7372},{44.2892,-19.2707},{39.5428,-18.8567},
              {37.6979,-18.2339},{36.2742,-20.9235},{37.8265,-22.099},{40.8374,
              -25.7914},{39.3147,-28.0578},{34.7581,-26.6661},{33.0831,-25.6733},
              {31.1313,-28.0081},{32.4052,-29.4806},{34.5827,-33.7184},{32.6221,
              -35.6187},{28.4544,-33.31},{27.0223,-31.9906},{24.6278,-33.8686},
              {25.5677,-35.5738},{26.8165,-40.1717},{24.5037,-41.6228},{20.9071,
              -38.4981},{19.7806,-36.9098},{17.0479,-38.2489},{17.6128,-40.1123},
              {17.8783,-44.8693},{15.3143,-45.8079},{12.446,-42.0036},{11.6744,
              -40.2159},{8.723,-40.9575},{8.8881,-42.8976},{8.1588,-47.6059},{
              5.4557,-47.9909},{3.441,-43.6734},{3.0579,-41.7643},{0.0168,
              -41.8761},{-0.225,-43.8082},{-1.9173,-48.2619},{-4.6414,-48.0765},
              {-5.7144,-43.4344},{-5.6922,-41.4874},{-8.6901,-40.9645},{-9.3284,
              -42.8041},{-11.9096,-46.8087},{-14.5357,-46.0609},{-14.6201,
              -41.2972},{-14.1935,-39.3973},{-17.0172,-38.2626},{-18.024,
              -39.9292},{-21.3814,-43.3096},{-23.7946,-42.0322},{-22.8868,
              -37.3551},{-22.0745,-35.5854},{-24.6006,-33.8884},{-25.9319,
              -35.3093},{-29.9188,-37.9178},{-32.0136,-36.1665},{-30.1532,
              -31.7803},{-28.9908,-30.2182},{-31.1088,-28.0331},{-32.7064,
              -29.1461},{-37.1485,-30.8687},{-38.8335,-28.7202},{-36.1018,
              -24.8167},{-34.64,-23.5304},{-36.2574,-20.9526},{-38.0515,
              -21.7092},{-42.7547,-22.4705},{-43.9562,-20.0187},{-40.4725,
              -16.7684},{-38.7753,-15.8141},{-39.8213,-12.9564},{-41.7336,
              -13.3234},{-46.4923,-13.0903},{-47.1577,-10.4422},{-43.0745,
              -7.9872},{-41.2159,-7.4067},{-41.6449,-4.394},{-43.5917,-4.3554},
              {-48.198,-3.1379},{-48.2983,-0.4094},{-43.7938,1.143},{-41.8552,
              1.3244},{-41.6485,4.3605},{-43.5446,4.803},{-47.7971,6.9516},{
              -47.3279,9.6414},{-42.5992,10.2233},{-40.6652,9.9976},{-39.8317,
              12.9244},{-41.5945,13.7515},{-45.3073,16.7372},{-44.2892,19.2707},
              {-39.5428,18.8567},{-37.6979,18.2339},{-36.2742,20.9235},{
              -37.8265,22.099},{-40.8374,25.7914},{-39.3147,28.0578},{-34.7581,
              26.6661},{-33.0831,25.6733},{-31.1313,28.0081},{-32.4052,29.4806},
              {-34.5827,33.7184},{-32.6221,35.6187},{-28.4544,33.31},{-27.0223,
              31.9906},{-24.6278,33.8686},{-25.5677,35.5738},{-26.8165,40.1717},
              {-24.5037,41.6228},{-20.9071,38.4981},{-19.7806,36.9098},{
              -17.0479,38.2489},{-17.6128,40.1123},{-17.8783,44.8693},{-15.3143,
              45.8079},{-12.446,42.0036},{-11.6744,40.2159},{-8.723,40.9575},{
              -8.8881,42.8976},{-8.1588,47.6059},{-5.4557,47.9909},{-3.441,
              43.6734},{-3.0579,41.7643},{-0.0168,41.8761},{0.2251,43.8082},{
              1.9173,48.2619},{4.6414,48.0765},{5.7144,43.4344},{5.6922,41.4874}},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{-9.977,22.4878},{-8.8831,24.6535},{-6.9407,26.8978},{-5.8083,
              27.739},{-3.7455,26.7376},{-3.706,25.3275},{-4.2679,22.413},{
              -5.2931,20.2139},{-2.7696,18.3875},{-1.001,20.0486},{1.5919,
              21.4932},{2.9438,21.8963},{4.5396,20.2498},{4.0945,18.9112},{
              2.5696,16.3647},{0.8542,14.6489},{2.6008,12.0695},{4.8309,13.0255},
              {7.7614,13.4962},{9.1697,13.4126},{10.1062,11.3196},{9.23,10.214},
              {6.9262,8.3426},{4.7273,7.3169},{5.4865,4.2957},{7.909,4.4313},{
              10.8238,3.8713},{12.1185,3.3112},{12.2827,1.0241},{11.0812,0.2848},
              {8.2763,-0.6858},{5.8592,-0.8975},{5.5393,-3.9962},{7.8621,
              -4.6973},{10.4096,-6.2205},{11.4347,-7.1897},{10.8067,-9.395},{
              9.4248,-9.6788},{6.4571,-9.6315},{4.1134,-9.0037},{2.7529,
              -11.8061},{4.6959,-13.2594},{6.5687,-15.562},{7.2005,-16.8233},{
              5.8561,-18.6809},{4.4606,-18.4749},{1.688,-17.4154},{-0.2997,
              -16.024},{-2.5365,-18.192},{-1.2078,-20.2222},{-0.2355,-23.0265},
              {-0.0732,-24.4278},{-1.9718,-25.7135},{-3.2128,-25.0427},{-5.4558,
              -23.0988},{-6.8477,-21.1115},{-9.6911,-22.3837},{-9.1369,-24.7459},
              {-9.1823,-27.7137},{-9.5091,-29.086},{-11.733,-29.6448},{-12.6697,
              -28.59},{-14.1125,-25.9962},{-14.7408,-23.6526},{-17.8479,
              -23.8756},{-18.135,-26.2849},{-19.1927,-29.0581},{-19.9692,
              -30.2359},{-22.25,-30.0005},{-22.7695,-28.6889},{-23.2382,-25.758},
              {-23.027,-23.3409},{-26.023,-22.4878},{-27.1169,-24.6535},{
              -29.0593,-26.8978},{-30.1917,-27.739},{-32.2545,-26.7376},{
              -32.294,-25.3275},{-31.7321,-22.413},{-30.7069,-20.2139},{
              -33.2304,-18.3875},{-34.999,-20.0486},{-37.5919,-21.4932},{
              -38.9438,-21.8963},{-40.5396,-20.2498},{-40.0945,-18.9112},{
              -38.5696,-16.3647},{-36.8542,-14.6489},{-38.6008,-12.0695},{
              -40.8309,-13.0255},{-43.7614,-13.4962},{-45.1697,-13.4126},{
              -46.1062,-11.3196},{-45.23,-10.214},{-42.9262,-8.3426},{-40.7273,
              -7.3169},{-41.4865,-4.2957},{-43.909,-4.4313},{-46.8238,-3.8713},
              {-48.1185,-3.3112},{-48.2827,-1.0241},{-47.0812,-0.2848},{
              -44.2763,0.6858},{-41.8592,0.8975},{-41.5393,3.9962},{-43.8621,
              4.6973},{-46.4096,6.2205},{-47.4347,7.1897},{-46.8067,9.395},{
              -45.4248,9.6788},{-42.4571,9.6315},{-40.1134,9.0037},{-38.7529,
              11.8061},{-40.6959,13.2594},{-42.5687,15.562},{-43.2005,16.8233},
              {-41.8561,18.6809},{-40.4606,18.4749},{-37.688,17.4154},{-35.7003,
              16.024},{-33.4635,18.192},{-34.7922,20.2222},{-35.7645,23.0265},{
              -35.9268,24.4278},{-34.0282,25.7135},{-32.7872,25.0427},{-30.5442,
              23.0988},{-29.1523,21.1115},{-26.3089,22.3837},{-26.8631,24.7459},
              {-26.8177,27.7137},{-26.4909,29.086},{-24.267,29.6448},{-23.3303,
              28.59},{-21.8875,25.9962},{-21.2592,23.6526},{-18.1521,23.8756},{
              -17.865,26.2849},{-16.8073,29.0581},{-16.0308,30.2359},{-13.75,
              30.0005},{-13.2305,28.6889},{-12.7618,25.758},{-12.973,23.3409}},
          fillColor={255,160,160},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5,
          pattern=LinePattern.None),
        Line(
          points={{-100,0},{-20,0}},
          thickness=1)}),
    Icon(graphics={
        Line(
          visible=useHeatPort,
          points={{-100,-100},{-100,-40},{-60,-40},{-42,-4}},
          color={191,0,0},
          pattern=LinePattern.Dot)}),
    Documentation(
      revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>",
      info="<html>
<p>
In this model an ideal gear connection is modelled.
It is based on the paper [<a href=\"modelica://PlanarMechanics.UsersGuide.References\">Linden2012</a>]
However, no gear elasticity is modelled.
</p>
<p>
The planar model of an <em>internal gear wheel</em> is aimed to build
complex gear models. There is a&nbsp;corresponding example of
<a href=\"modelica://PlanarMechanics.GearComponents.Examples.SpurGear\">SpurGear</a>.
</p>
<p>
Using different parts from the planar library, it is possible to
build complex gear systems. However, especially since no elasticity
is included, kinematic loops can lead to complications and should
be handled with care.
</p>
<p>
This model is suitable for:
</p>
<ul>
  <li>Kinematic analysis of gear systems and gear-like systems.</li>
  <li>Modelling of multiple gear stage models with clutches.</li>
</ul>
</html>"));
end RigidNoLossInternal;
