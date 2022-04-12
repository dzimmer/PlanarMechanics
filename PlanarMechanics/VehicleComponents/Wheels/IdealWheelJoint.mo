within PlanarMechanics.VehicleComponents.Wheels;
model IdealWheelJoint "Ideal wheel joint"
  extends PlanarMechanics.VehicleComponents.Wheels.BaseClasses.WheelBase(
    final useHeatPort=false);
  outer PlanarWorld planarWorld "planar world model";
  parameter StateSelect stateSelect=StateSelect.default
    "Priority to use acceleration as states" annotation(HideResult=true,Dialog(tab="Advanced"));

  parameter SI.Length r[2] "Driving direction of the wheel at angle phi = 0";
  final parameter SI.Length l = Modelica.Math.Vectors.length(r) "Length of r";
  final parameter Real e[2](each final unit="1") = Modelica.Math.Vectors.normalizeWithAssert(r)
    "Unit vector in direction of r";
  Real e0[2] "Unit vector in direction of r resolved w.r.t. inertial frame";
  PlanarMechanics.Transformations.Internal.TransformationMatrix R=
    PlanarMechanics.Transformations.RbyAngle(frame_a.phi) "Rotation matrix";
  SI.Angle phi_roll(start=0) "Roll angle of the wheel" annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.AngularVelocity w_roll(final stateSelect=stateSelect, start=0)
    "Roll velocity of wheel"  annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Velocity v[2] "Velocity";
  SI.Velocity v_long "Driving velocity in (longitudinal) driving direction";
  SI.Acceleration a(stateSelect=stateSelect, start=0)
    "Acceleration of driving velocity" annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Force f_long "Longitudinal force";
    parameter Boolean animate = true "= true, if animation shall be enabled"
    annotation(Dialog(group="Animation"));

  parameter SI.Length zPosition = planarWorld.defaultZPosition
    "Position z of the body" annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animate));
  parameter SI.Length diameter = 0.1 "Deprecated: Diameter of the rims"
    annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animate));
  parameter SI.Length width = 0.6*radius "Wheel width"
    annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animate));
  parameter SI.Length rRim = 0.9*radius "Rim radius"
    annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animate));
  input MB.Types.Color color = PlanarMechanics.Types.Defaults.WheelColor "Color of shape"
    annotation(Dialog(tab="Animation", group="if animation = true", enable=animate, colorSelector=true));
  input MB.Types.SpecularCoefficient specularCoefficient = planarWorld.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animate));

protected
  Modelica.Mechanics.MultiBody.Frames.Orientation Rrel "Orientation object in 3d";

  Visualizers.Advanced.Wheel wheel(
    R=MB.Frames.absoluteRotation(planarWorld.R, Rrel),
    r=planarWorld.r_0 + MB.Frames.resolve1(planarWorld.R, {frame_a.x,frame_a.y,zPosition}),
    psi=flange_a.phi,
    radius=radius,
    rRim=rRim,
    width=width,
    color=color,
    specularCoefficient=specularCoefficient) if planarWorld.enableAnimation and animate;
equation
  Rrel = Modelica.Mechanics.MultiBody.Frames.planarRotation({0,0,1}, frame_a.phi, 0);
  e0 = PlanarMechanics.Transformations.resolve2in1(frame_a.phi, e);
  v = der({frame_a.x,frame_a.y});
  v = v_long*e0;
  phi_roll = flange_a.phi;
  w_roll = der(phi_roll);
  v_long = radius*w_roll;
  a = der(v_long);
  -f_long*radius = flange_a.tau;
  frame_a.t = 0;
  {frame_a.fx, frame_a.fy}*e0 = f_long;
  lossPower = 0;

  annotation (
    Documentation(
      info="<html>
<p>
The ideal wheel joint enforces the constraints of ideal rolling on the x,y-plane.
</p>
<p>
The constraint is that the velocity of the virtual point of contact shall be zero.
This constrains is split into two components:
</p>
<ul>
  <li>no lateral velocity</li>
  <li>the longitudinal velocity has to equal the rolling velocity times the radius.</li>
</ul>
<p>
The radius of the wheel can be specified by the parameter <strong>radius</strong>.
The driving direction (for phi&nbsp;=&nbsp;0) can be specified by the
parameter&nbsp;<strong>r</strong>.
</p>
<p>
The wheel contains a&nbsp;2D frame connector for the steering on the plane.
The rolling motion of the wheel can be actuated by the 1D flange connector.
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
</html>"), Icon(graphics={
        Text(
          extent={{-150,-30},{150,-60}},
          textColor={0,0,0},
          textString="radius=%radius")}));
end IdealWheelJoint;
