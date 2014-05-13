within PlanarMechanics.VehicleComponents.Wheels;
model IdealWheelJoint

  Interfaces.Frame_a frame_a annotation (Placement(transformation(extent={{-48,0},
            {-28,20}}), iconTransformation(extent={{-68,-20},{-28,20}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a annotation (
      Placement(transformation(extent={{90,-8},{110,12}}), iconTransformation(
          extent={{90,-10},{110,10}})));
  outer PlanarWorld planarWorld "planar world model";
  parameter StateSelect stateSelect=StateSelect.default
    "Priority to use acceleration as states" annotation(HideResult=true,Dialog(tab="Advanced"));

  parameter SI.Length radius "radius of the wheel";
  parameter SI.Length r[2] "driving direction of the wheel at angle phi = 0";
  final parameter SI.Length l = sqrt(r*r);
  final parameter Real e[2] =  r/l "normalized direction";
  Real e0[2] "normalized direction w.r.t inertial system";
  Real R[2,2] "Rotation Matrix";
  SI.Angle phi_roll(start=0) "roll angle of the wheel"                           annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.AngularVelocity w_roll(final stateSelect=stateSelect, start=0)
    "roll velocity of wheel"                                                                      annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Velocity v[2] "velocity";
  SI.Velocity v_long "driving velocity in (longitudinal) driving direction";
  SI.Acceleration a(stateSelect=stateSelect, start=0)
    "acceleration of driving velocity"                                          annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Force f_long "longitudinal force";
    parameter Boolean animate = true "= true, if animation shall be enabled"
                                           annotation(Dialog(group="Animation"));
  parameter Boolean SimVis = false "perform animation with SimVis" annotation(Dialog(group="Animation"));

  parameter SI.Length zPosition = planarWorld.defaultZPosition
    "z position of the body" annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animate));
  parameter SI.Length diameter = 0.1 "diameter of the rims"
                           annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animate));
  parameter SI.Length width = diameter * 0.6 "width of the wheel"
                         annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animate));
  input Modelica.Mechanics.MultiBody.Types.SpecularCoefficient
    specularCoefficient = planarWorld.defaultSpecularCoefficient
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
    r={frame_a.x,frame_a.y,zPosition},
    R=MB.Frames.nullRotation()) if planarWorld.enableAnimation and animate;
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
    r={frame_a.x,frame_a.y,zPosition},
    R=MB.Frames.planarRotation({-e0[2],e0[1],0},flange_a.phi,0)) if planarWorld.enableAnimation and animate;
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
    r={frame_a.x,frame_a.y,zPosition},
    R=MB.Frames.planarRotation({-e0[2],e0[1],0},flange_a.phi+Modelica.Constants.pi/2,0)) if planarWorld.enableAnimation and animate;
equation
  R = {{cos(frame_a.phi), -sin(frame_a.phi)}, {sin(frame_a.phi),cos(frame_a.phi)}};
  e0 = R*e;
  v = der({frame_a.x,frame_a.y});
  v = v_long*e0;
  phi_roll = flange_a.phi;
  w_roll = der(phi_roll);
  v_long = radius*w_roll;
  a = der(v_long);
  -f_long*radius = flange_a.tau;
  frame_a.t = 0;
  {frame_a.fx, frame_a.fy}*e0 = f_long;
  annotation (Icon(graphics={
        Rectangle(
          extent={{-40,100},{40,-100}},
          lineColor={95,95,95},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={231,231,231}),
        Line(
          points={{-40,30},{40,30}},
          color={95,95,95}),
        Line(
          points={{-40,-30},{40,-30}},
          color={95,95,95}),
        Line(
          points={{-40,60},{40,60}},
          color={95,95,95}),
        Line(
          points={{-40,80},{40,80}},
          color={95,95,95}),
        Line(
          points={{-40,90},{40,90}},
          color={95,95,95}),
        Line(
          points={{-40,100},{40,100}},
          color={95,95,95}),
        Line(
          points={{-40,-80},{40,-80}},
          color={95,95,95}),
        Line(
          points={{-40,-90},{40,-90}},
          color={95,95,95}),
        Line(
          points={{-40,-100},{40,-100}},
          color={95,95,95}),
        Line(
          points={{-40,-60},{40,-60}},
          color={95,95,95}),
        Rectangle(
          extent={{100,10},{40,-10}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={231,231,231}),
        Text(
          extent={{-100,-100},{100,-140}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={85,170,255},
          textString="%name")}),    Documentation(info="<html>
<h4><font color=\"#008000\">Ideal wheel joint</font></h4>
<p>The ideal wheel joint enforces the constraints of ideal rolling on the x,y-plane.</p>
<p>The constraint is that the velocity of the virtual point of contact shall be zero. This constrains is split into two components:</p>
<ul>
<li>no lateral velocity</li>
<li>the longitudinal velocity has to equal the rolling velocity times the radius.</li>
</ul>
<p><br/>The radius of the wheel can be specified by the parameter <b>radius</b>. The driving direction (for phi=0) can be specified by the parameter <b>r</b>.</p>
<p>The wheel contains a 2D frame connector for the steering on the plane. The rolling motion of the wheel can be actuated by the 1D flange connector.</p>
<p>For examples of usage see the local Examples package.</p>
</html>", revisions="<html>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p>
</html>"));
end IdealWheelJoint;
