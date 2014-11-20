within PlanarMechanics.Parts;
model Body "Body component with mass and inertia"

  Interfaces.Frame_a frame_a
    annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));
  outer PlanarWorld planarWorld "planar world model";
  parameter Boolean animate = true "= true, if animation shall be enabled";
  parameter StateSelect stateSelect=StateSelect.default
    "Priority to use phi, w and a as states" annotation(HideResult=true,Dialog(tab="Advanced"));
  parameter SI.Mass m "Mass of the body";
  parameter SI.Inertia I "Inertia of the Body";
  parameter SI.Acceleration g[2] = planarWorld.g
    "Local gravity acting on the mass";
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
  input Modelica.Mechanics.MultiBody.Types.SpecularCoefficient
    specularCoefficient = planarWorld.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (HideResult = true, Dialog(tab="Animation", group="if animation = true", enable=animate));
  SI.Force f[2] "Force";
  SI.Position r[2](each final stateSelect=stateSelect, start={0,0})
    "Translational position"                                                            annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Velocity v[2](each final stateSelect=stateSelect, start={0,0}) "Velocity" annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Acceleration a[2](start={0,0}) "Acceleration" annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Angle phi(final stateSelect=stateSelect, start=0) "Angle" annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.AngularVelocity w(final stateSelect=stateSelect, start = 0)
    "Angular velocity"                                                              annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.AngularAcceleration z(start = 0) "Angular acceleration"
                           annotation(Dialog(group="Initialization", showStartAttribute=true));
  //Visualization
  MB.Visualizers.Advanced.Shape sphere(
    shapeType="sphere",
    color={63,63,255},
    specularCoefficient=specularCoefficient,
    length=sphereDiameter,
    width=sphereDiameter,
    height=sphereDiameter,
    lengthDirection={0,0,1},
    widthDirection={1,0,0},
    r_shape={0,0,0} -{0,0,1}*sphereDiameter/2,
    r={frame_a.x,frame_a.y,zPosition},
    R=MB.Frames.axisRotation(3,frame_a.phi,w)) if  planarWorld.enableAnimation and animate;
equation
  //The velocity is a time-derivative of the position
  r = {frame_a.x, frame_a.y};
  v = der(r);
  phi = frame_a.phi;
  w = der(frame_a.phi);
  //The acceleration is a time-derivative of the velocity
  a = der(v);
  z = der(w);
  //Newton's law
  f = {frame_a.fx, frame_a.fy};
  f + m*g = m*a;
  frame_a.t = I*z;
  annotation (Icon(graphics={
        Rectangle(
          extent={{-100,40},{-20,-40}},
          fillColor={85,170,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{-60,60},{60,-60}},
          fillPattern=FillPattern.Sphere,
          fillColor={85,170,255}),
        Text(
          extent={{-150,100},{150,60}},
          textString="%name",
          lineColor={0,0,255})}),   Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p></html>",  info="<html>
<p>Model <b>Body</b> is an ideal unlimited small point with mass and inertia.</p>
</html>"));
end Body;
