within PlanarMechanics.VehicleComponents.Wheels;
model DryFrictionWheelJoint "Dry-Friction based wheel joint"
  extends PlanarMechanics.VehicleComponents.Wheels.BaseClasses.WheelBase
    annotation (IconMap(extent={{-100,-100}, {100,100}},primitivesVisible=false));

  outer PlanarWorld planarWorld "planar world model";
  parameter StateSelect stateSelect=StateSelect.default
    "Priority to use acceleration as states" annotation(HideResult=true,Dialog(tab="Advanced"));

  parameter SI.Length r[2] "Driving direction of the wheel at angle phi = 0";
  parameter SI.Force N "Normal force";
  parameter SI.Velocity vAdhesion "Adhesion velocity";
  parameter SI.Velocity vSlide "Sliding velocity";
  parameter Real mu_A "Friction coefficient at adhesion";
  parameter Real mu_S "Friction coefficient at sliding";
  final parameter SI.Length l = Modelica.Math.Vectors.length(r) "Length of r";
  final parameter Real e[2](each final unit="1") = Modelica.Math.Vectors.normalizeWithAssert(r)
    "Unit vector in direction of r";
  Real e0[2] "Unit vector in direction of r resolved w.r.t. inertial frame";
  Real R[2,2] "Rotation matrix";
  SI.Angle phi_roll(stateSelect=stateSelect, start=0) "Roll angle of the wheel"
    annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.AngularVelocity w_roll(final stateSelect=stateSelect, start=0)
    "Roll velocity of wheel" annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Velocity v[2] "Velocity";
  SI.Velocity v_lat(start=0) "Driving in lateral direction"
    annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Velocity v_long(start=0) "Velocity in longitudinal direction"
    annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Velocity v_slip_long(start=0) "Slip velocity in longitudinal direction"
    annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Velocity v_slip_lat( start=0) "Slip velocity in lateral direction"
    annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Velocity v_slip "Slip velocity";
  SI.Force f "Longitudinal force";
  SI.Force f_lat "Longitudinal force";
  SI.Force f_long "Longitudinal force";
  parameter Boolean animate = true "= true, if animation shall be enabled"
     annotation(Dialog(group="Animation"));
  parameter SI.Length zPosition = planarWorld.defaultZPosition
    "Position z of the body" annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animate));
  parameter SI.Length diameter = 0.1 "Diameter of the rims"
    annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animate));
  parameter SI.Length width = diameter * 0.6 "Width of the wheel"
    annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animate));
  input MB.Types.SpecularCoefficient specularCoefficient = planarWorld.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animate));
  MB.Visualizers.Advanced.Shape cylinder(
    shapeType="cylinder",
    color={63,63,63},
    specularCoefficient=specularCoefficient,
    length=width,
    width=radius*2,
    height=radius*2,
    lengthDirection={-e0[2],e0[1],0},
    widthDirection={0,0,1},
    r_shape=-0.03*{-e0[2],e0[1],0},
    r=MB.Frames.resolve1(planarWorld.R,{frame_a.x,frame_a.y,zPosition})+planarWorld.r_0,
    R=planarWorld.R) if planarWorld.enableAnimation and animate;
  MB.Visualizers.Advanced.Shape rim1(
    shapeType="cylinder",
    color={195,195,195},
    specularCoefficient=specularCoefficient,
    length=radius*2,
    width=diameter,
    height=diameter,
    lengthDirection={0,0,1},
    widthDirection={1,0,0},
    r_shape={0,0,-radius},
    r=MB.Frames.resolve1(planarWorld.R,{frame_a.x,frame_a.y,zPosition})+planarWorld.r_0,
    R=MB.Frames.absoluteRotation(planarWorld.R,MB.Frames.planarRotation({-e0[2],e0[1],0},flange_a.phi,0)))
    if planarWorld.enableAnimation and animate;
  MB.Visualizers.Advanced.Shape rim2(
    shapeType="cylinder",
    color={195,195,195},
    specularCoefficient=specularCoefficient,
    length=radius*2,
    width=diameter,
    height=diameter,
    lengthDirection={0,0,1},
    widthDirection={1,0,0},
    r_shape={0,0,-radius},
    r=MB.Frames.resolve1(planarWorld.R,{frame_a.x,frame_a.y,zPosition})+planarWorld.r_0,
    R=MB.Frames.absoluteRotation(planarWorld.R,MB.Frames.planarRotation({-e0[2],e0[1],0},flange_a.phi+Modelica.Constants.pi/2,0)))
    if planarWorld.enableAnimation and animate;
equation
  R = {{cos(frame_a.phi), -sin(frame_a.phi)}, {sin(frame_a.phi),cos(frame_a.phi)}};
  e0 = R*e;
  v = der({frame_a.x,frame_a.y});
  phi_roll = flange_a.phi;
  w_roll = der(phi_roll);
  v_long = v*e0;
  v_lat = -v[1]*e0[2] + v[2]*e0[1];
  v_slip_lat = v_lat - 0;
  v_slip_long = v_long - radius*w_roll;
  v_slip = sqrt(v_slip_long^2 + v_slip_lat^2)+0.0001;
  -f_long*radius = flange_a.tau;
  frame_a.t = 0;
  f =N*noEvent(Utilities.Functions.limitByStriple(
    vAdhesion,
    vSlide,
    mu_A,
    mu_S,
    v_slip));
  f_long =f*v_slip_long/v_slip;
  f_lat  =f*v_slip_lat/v_slip;
  f_long = {frame_a.fx, frame_a.fy}*e0;
  f_lat = {frame_a.fy, -frame_a.fx}*e0;
  lossPower = f*v_slip;

  annotation (
    Documentation(
      info="<html>
<p>
The ideal wheel joint models the behavior of a&nbsp;wheel rolling on a&nbsp;x,y-plane
whose contact patch has dry-friction characteristics. This is an approximation for
stiff wheels without a&nbsp;tire.
</p>
<p>
The force depends with dry-friction characteristics on the slip velocity. The slip
velocity is split into two components:
</p>
<ul>
  <li>the lateral velocity</li>
  <li>the longitudinal velocity minus the rolling velocity times the radius.</li>
</ul>
<p>
The radius of the wheel can be specified by the parameter <strong>radius</strong>.
The driving direction (for phi&nbsp;=&nbsp;0) can be specified by the
parameter&nbsp;<strong>r</strong>. The normal load is set by&nbsp;<strong>N</strong>.
</p>
<p>
The wheel contains a&nbsp;2D connector <strong>frame_a</strong> for the steering on
the plane. The rolling motion of the wheel can be actuated by the 1D  connector
<strong>flange_a</strong>.
</p>
<p>
For examples of usage see the local
<a href=\"modelica://PlanarMechanics.VehicleComponents.Examples\">Examples package</a>.
</p>
</html>",
      revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>"),
    Icon(graphics={
        Rectangle(
          extent={{100,10},{30,-10}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={231,231,231}),
        Rectangle(
          extent={{-40,90},{40,-90}},
          lineColor={95,95,95},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={231,231,231}),
        Line(
          points={{-40,80},{40,80}},
          color={95,95,95}),
        Line(
          points={{-40,70},{40,70}},
          color={95,95,95}),
        Line(
          points={{-40,50},{40,50}},
          color={95,95,95}),
        Line(
          points={{-40,20},{40,20}},
          color={95,95,95}),
        Line(
          points={{-40,-20},{40,-20}},
          color={95,95,95}),
        Line(
          points={{-40,-50},{40,-50}},
          color={95,95,95}),
        Line(
          points={{-40,-70},{40,-70}},
          color={95,95,95}),
        Line(
          points={{-40,-80},{40,-80}},
          color={95,95,95}),
        Rectangle(
          extent={{-30,100},{30,-100}},
          lineColor={32,32,32},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={175,175,175}),
        Text(
          extent={{-150,-30},{150,-60}},
          textColor={0,0,0},
          textString="radius=%radius"),
        Text(
          extent={{-150,140},{150,100}},
          textString="%name",
          textColor={0,0,255})}));
end DryFrictionWheelJoint;
