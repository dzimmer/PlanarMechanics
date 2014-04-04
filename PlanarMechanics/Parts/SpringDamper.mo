within PlanarMechanics.Parts;
model SpringDamper "Linear 2D translational spring damper model"
  extends PlanarMechanics.Interfaces.PartialTwoFlanges;
  outer PlanarWorld planarWorld "planar world model";
  parameter StateSelect stateSelect=StateSelect.default
    "Priority to use phi, w and a as states" annotation(HideResult=true,Dialog(tab="Advanced"));
  parameter Modelica.SIunits.TranslationalSpringConstant c_x(final min=0, start=1)
    "spring constant in x dir";
  parameter Modelica.SIunits.TranslationalSpringConstant c_y(final min=0, start=1)
    "spring constant in y dir";
  parameter Modelica.SIunits.RotationalSpringConstant c_phi(final min=0, start=1.0e5)
    "Spring constant";
  parameter Modelica.SIunits.TranslationalDampingConstant d_x(final min=0, start=1)
    "spring constant in x dir";
  parameter Modelica.SIunits.TranslationalDampingConstant d_y(final min=0, start=1)
    "spring constant in y dir";
  parameter Modelica.SIunits.RotationalDampingConstant d_phi(final min=0, start=1)
    "spring constant in x dir";
  parameter Modelica.SIunits.Position s_relx0=0 "unstretched spring length";
  parameter Modelica.SIunits.Position s_rely0=0 "unstretched spring length";
  parameter Modelica.SIunits.Angle phi_rel0=0 "Unstretched spring angle";

  Real[2] d0;
  Modelica.SIunits.Velocity v_relx "spring velocity";
  Modelica.SIunits.Velocity v_rely "spring velocity";
  Modelica.SIunits.AngularVelocity w_rel(start=0) "spring anglular velocity"                          annotation(Dialog(group="Initialization", showStartAttribute=true));
  Modelica.SIunits.Position s_relx(final stateSelect=stateSelect)
    "spring length";
  Modelica.SIunits.Position s_rely(final stateSelect=stateSelect)
    "spring length";
  Modelica.SIunits.Angle phi_rel(start=0, final stateSelect=stateSelect)
    "spring angle"                                                                annotation(Dialog(group="Initialization", showStartAttribute=true));
  Modelica.SIunits.Force f_x "Force in x direction";
  Modelica.SIunits.Force f_y "Force in y direction";
  Modelica.SIunits.Torque tau "Torque between frames (= frame_b.f)";

  parameter SI.Position s_small = 1.E-10
    "Prevent zero-division if distance between frame_a and frame_b is zero" annotation (Dialog(
      tab="Advanced"));

  parameter Boolean enableAssert = true
    "Cause an assert when the distance between frame_a and frame_b < s_small" annotation (Dialog(
      tab="Advanced"));

  parameter SI.Length zPosition = planarWorld.defaultZPosition
    "z position of cylinder representing the fixed translation" annotation (Dialog(
      tab="Animation", group="if animation = true", enable=animate));
  parameter Integer numberOfWindings = 5 " Number of spring windings"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animate));
  input SI.Distance width = planarWorld.defaultForceWidth " Width of spring"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animate));
  input SI.Distance coilWidth = width/10 " Width of spring coil"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animate));
  input Modelica.Mechanics.MultiBody.Types.SpecularCoefficient
    specularCoefficient = planarWorld.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animate));
  input Types.Color color = Types.Defaults.SpringColor " Color of spring"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animate));
  parameter SI.Distance length_a = planarWorld.defaultForceLength
    " Length of cylinder at frame_a side"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animate));
  input SI.Diameter diameter_a = planarWorld.defaultForceWidth
    " Diameter of cylinder at frame_a side"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animate));
  input SI.Diameter diameter_b = 0.6*diameter_a
    " Diameter of cylinder at frame_b side"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animate));
  input Types.Color color_a = {100,100,100} " Color at frame_a"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animate, colorSelector));
  input Types.Color color_b = {155,155,155} " Color at frame_b"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animate, colorSelector));

  SI.Distance length
    "Distance between the origin of frame_a and the origin of frame_b";
  SI.Position r_rel_0[3]
    "Position vector from frame_a to frame_b resolved in world frame";
  Real e_rel_0[3](each final unit="1")
    "Unit vector in direction from frame_a to frame_b, resolved in world frame";

  //Visualization
  import MB = Modelica.Mechanics.MultiBody;
  parameter Boolean animate = true "enable Animation"
                                                     annotation(Dialog(group="Animation"));
protected
  MB.Visualizers.Advanced.Shape contactA(
    shapeType="cylinder",
    color={0,0,0},
    specularCoefficient=specularCoefficient,
    length=0.1,
    width=0.1,
    height=0.1,
    lengthDirection={0,0,1},
    widthDirection={1,0,0},
    r_shape={0,0,-0.06},
    r={frame_a.x,frame_a.y,zPosition},
    R=MB.Frames.nullRotation()) if planarWorld.enableAnimation and animate;
  MB.Visualizers.Advanced.Shape contactB(
    shapeType="cylinder",
    color={0,0,0},
    specularCoefficient=specularCoefficient,
    length=0.1,
    width=0.1,
    height=0.1,
    lengthDirection={0,0,1},
    widthDirection={1,0,0},
    r_shape={0,0,-0.06},
    r={frame_b.x,frame_b.y,zPosition},
    R=MB.Frames.nullRotation()) if planarWorld.enableAnimation and animate;
  MB.Visualizers.Advanced.Shape lineShape(
    shapeType="spring",
    color=color,
    specularCoefficient=specularCoefficient,
    length=length,
    width=width,
    height=coilWidth*2,
    lengthDirection=e_rel_0,
    widthDirection= {0,1,0},
    extra=numberOfWindings,
    r={frame_a.x,frame_a.y,zPosition}) if planarWorld.enableAnimation and animate;
    SI.Position r0_b[3] = {d0[1], d0[2], 0} * noEvent(min(length_a, length));
  MB.Visualizers.Advanced.Shape shape_a(
    shapeType="cylinder",
    color=color_a,
    specularCoefficient=specularCoefficient,
    length=noEvent(min(length_a, length)),
    width=diameter_a,
    height=diameter_a,
    lengthDirection={d0[1], d0[2], 0},
    widthDirection={0,1,0},
    r={frame_a.x,frame_a.y,zPosition}) if planarWorld.enableAnimation and animate;
  MB.Visualizers.Advanced.Shape shape_b(
    shapeType="cylinder",
    color=color_b,
    specularCoefficient=specularCoefficient,
    length=noEvent(max(length - length_a, 0)),
    width=diameter_b,
    height=diameter_b,
    lengthDirection={s_relx, s_rely, 0},
    widthDirection={0,1,0},
    r_shape=r0_b,
    r={frame_a.x,frame_a.y,zPosition}) if planarWorld.enableAnimation and animate;

//   MB.Visualizers.Advanced.Shape contactA(
//     shapeType="cylinder",
//     color={0,0,0},
//     specularCoefficient=0.5,
//     length=0.1,
//     width=.1,
//     height=.1,
//     lengthDirection={0,0,1},
//     widthDirection={1,0,0},
//     r_shape={0,0,-0.06},
//     r={frame_a.x,frame_a.y,0},
//     R=MB.Frames.nullRotation()) if  animate;
//   MB.Visualizers.Advanced.Shape contactB(
//     shapeType="cylinder",
//     color={0,0,0},
//     specularCoefficient=0.5,
//     length=0.1,
//     width=.1,
//     height=.1,
//     lengthDirection={0,0,1},
//     widthDirection={1,0,0},
//     r_shape={0,0,-0.06},
//     r={frame_b.x,frame_b.y,0},
//     R=MB.Frames.nullRotation()) if  animate;
equation
     assert(noEvent(length > s_small), "
 The distance between the origin of frame_a and the origin of frame_b
 of a Spring component became smaller as parameter s_small
 (= a small number, defined in the \"Advanced\" menu). The distance is
 set to s_small, although it is smaller, to avoid a division by zero
 when computing the direction of the line force. Possible reasons
 for this situation:
 - At initial time the distance may already be zero: Change the initial
   positions of the bodies connected by this element.
 - Hardware stops are not modeled or are modeled not stiff enough.
   Include stops, e.g., stiff springs, or increase the stiffness
   if already present.
 - Another error in your model may lead to unrealistically large forces
   and torques that would in reality destroy the stops.
 - The flange_b connector might be defined by a pre-defined motion,
   e.g., with Modelica.Mechanics.Translational.Position and the
   predefined flange_b.s is zero or negative.
 ");
  r_rel_0 = {s_relx, s_rely, 0};
  length = Modelica.Math.Vectors.length(r_rel_0);
  e_rel_0 = r_rel_0/Modelica.Mechanics.MultiBody.Frames.Internal.maxWithoutEvent(length, s_small);
  d0= Modelica.Math.Vectors.normalize({s_relx,s_rely});

  v_relx = der(s_relx);
  v_rely = der(s_rely);
  w_rel = der(phi_rel);
  phi_rel = frame_b.phi - frame_a.phi;
  tau = c_phi*(phi_rel - phi_rel0) + d_phi*w_rel;
  frame_a.t = -tau;
  frame_b.t = tau;
  s_relx = frame_b.x-frame_a.x;
  s_rely = frame_b.y-frame_a.y;
  f_x = c_x*(s_relx - s_relx0) + d_x*v_relx;
  f_y = c_y*(s_rely - s_rely0) + d_y*v_rely;
  frame_a.fx = -f_x;
  frame_b.fx = f_x;
  frame_a.fy = -f_y;
  frame_b.fy = f_y;
  annotation (
    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p></html>",  info="<html>
<p>A <i>linear translational spring-damper</i>. x- and y direction stiffness and damping can be parameterized.</p>
</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(
          points={{-80,32},{-58,32},{-43,2},{-13,62},{17,2},{47,62},{62,32},
              {80,32}},
          color={0,0,0},
          thickness=0.5),
        Line(points={{-68,32},{-68,97}}, color={128,128,128}),
        Line(points={{72,32},{72,97}}, color={128,128,128}),
        Line(points={{-68,92},{72,92}}, color={128,128,128}),
        Polygon(
          points={{62,95},{72,92},{62,89},{62,95}},
          lineColor={128,128,128},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-20,72},{20,97}},
          lineColor={0,0,255},
          textString="phi_rel"),
        Rectangle(
          extent={{-50,-20},{40,-80}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-50,-80},{68,-80}}, color={0,0,0}),
        Line(points={{-50,-20},{68,-20}}, color={0,0,0}),
        Line(points={{40,-50},{80,-50}}, color={0,0,0}),
        Line(points={{-80,-50},{-50,-50}}, color={0,0,0}),
        Line(points={{-80,32},{-80,-50}}, color={0,0,0}),
        Line(points={{80,32},{80,-50}}, color={0,0,0}),
        Line(points={{-96,0},{-80,0}}, color={0,0,0}),
        Line(points={{96,0},{80,0}}, color={0,0,0}),
        Text(
          extent={{140,-100},{-142,-142}},
          textString="%name",
          lineColor={0,0,0})}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(
          points={{-80,32},{-58,32},{-43,2},{-13,62},{17,2},{47,62},{62,32},
              {80,32}},
          color={0,0,0},
          thickness=0.5),
        Line(points={{-68,32},{-68,97}}, color={128,128,128}),
        Line(points={{72,32},{72,97}}, color={128,128,128}),
        Line(points={{-68,92},{72,92}}, color={128,128,128}),
        Polygon(
          points={{62,95},{72,92},{62,89},{62,95}},
          lineColor={128,128,128},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-20,72},{20,97}},
          lineColor={0,0,255},
          textString="phi_rel"),
        Rectangle(
          extent={{-50,-20},{40,-80}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-50,-80},{68,-80}}, color={0,0,0}),
        Line(points={{-50,-20},{68,-20}}, color={0,0,0}),
        Line(points={{40,-50},{80,-50}}, color={0,0,0}),
        Line(points={{-80,-50},{-50,-50}}, color={0,0,0}),
        Line(points={{-80,32},{-80,-50}}, color={0,0,0}),
        Line(points={{80,32},{80,-50}}, color={0,0,0}),
        Line(points={{-96,0},{-80,0}}, color={0,0,0}),
        Line(points={{96,0},{80,0}}, color={0,0,0})}));
end SpringDamper;
