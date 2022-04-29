within PlanarMechanics.Parts;
model Body "Body component with mass and inertia"

  Interfaces.Frame_a frame_a
    annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));
  outer PlanarWorld planarWorld "planar world model";
  parameter Boolean animate = true "= true, if animation shall be enabled" annotation (
    Evaluate=true,
    HideResult=true,
    choices(checkBox=true));
  parameter StateSelect stateSelect=StateSelect.default
    "Priority to use phi, w and a as states" annotation(HideResult=true,Dialog(tab="Advanced"));
  parameter SI.Mass m "Mass of the body";
  parameter SI.Inertia I
    "Inertia of the body with respect to the origin of frame_a along the z-axis of frame_a";
  parameter SI.Length zPosition = planarWorld.defaultZPosition
    "Position z of the body" annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animate));
  parameter SI.Diameter sphereDiameter=planarWorld.defaultBodyDiameter
    "Diameter of sphere" annotation (HideResult = true,Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animate));
  parameter Boolean enableGravity = true
    "= true, if gravity effects should be taken into account" annotation (
      Evaluate=true,
      HideResult=true,
      choices(checkBox=true));
  input Types.Color sphereColor=Types.Defaults.BodyColor "Color of sphere"
    annotation (HideResult = true, Dialog(
      colorSelector=true,
      tab="Animation",
      group="if animation = true",
      enable=animate));
  input Types.SpecularCoefficient specularCoefficient = planarWorld.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (HideResult = true, Dialog(tab="Animation", group="if animation = true", enable=animate));
  SI.Force f[2] "Force";
  SI.Position r[2](each final stateSelect=stateSelect, start={0,0}) "Translational position"
    annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Velocity v[2](each final stateSelect=stateSelect, start={0,0}) "Velocity" annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Acceleration a[2](start={0,0}) "Acceleration" annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Angle phi(final stateSelect=stateSelect, start=0) "Angle" annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.AngularVelocity w(final stateSelect=stateSelect, start = 0) "Angular velocity"
    annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.AngularAcceleration z(start = 0) "Angular acceleration"
    annotation(Dialog(group="Initialization", showStartAttribute=true));
  //Visualization
  MB.Visualizers.Advanced.Shape sphere(
    shapeType="sphere",
    color=sphereColor,
    specularCoefficient=specularCoefficient,
    length=sphereDiameter,
    width=sphereDiameter,
    height=sphereDiameter,
    lengthDirection={0,0,1},
    widthDirection={1,0,0},
    r_shape={0,0,0} -{0,0,1}*sphereDiameter/2,
    r=MB.Frames.resolve1(planarWorld.R,{frame_a.x,frame_a.y,zPosition})+planarWorld.r_0,
    R=MB.Frames.absoluteRotation(planarWorld.R,MB.Frames.axisRotation(3,frame_a.phi,w)))
    if planarWorld.enableAnimation and animate;
equation
  //The velocity is a time-derivative of the position
  r = {frame_a.x, frame_a.y};
  v = der(r);
  phi = frame_a.phi;
  w = der(phi);
  //The acceleration is a time-derivative of the velocity
  a = der(v);
  z = der(w);
  //Newton's law
  f = {frame_a.fx, frame_a.fy};
  if enableGravity then
    f + m*planarWorld.g = m*a;
  else
    f = m*a;
  end if;
  frame_a.t = I*z;
  annotation (
    Icon(graphics={
        Rectangle(
          extent={{-100,40},{-20,-40}},
          fillColor={85,170,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{-60,60},{60,-60}},
          fillPattern=FillPattern.Sphere,
          fillColor={85,170,255}),
        Text(
          extent={{150,-96},{-150,-66}},
          textString="m=%m"),
        Text(
          extent={{150,-130},{-150,-100}},
          textString="I=%I",
          textColor={0,0,0}),
        Text(
          extent={{-150,100},{150,60}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(
      revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>",
      info="<html>
<p>Model <strong>Body</strong> is an ideal unlimited small point with mass and inertia.</p>
</html>"));
end Body;
