within PlanarMechanics.Parts;
model Spring "Linear 2D translational spring"
  extends PlanarMechanics.Interfaces.PartialTwoFlanges;

  outer PlanarWorld planarWorld "planar world model";
  parameter StateSelect stateSelect=StateSelect.default
    "Priority to use phi and w as states" annotation(HideResult=true,Dialog(tab="Advanced"));
  parameter Modelica.SIunits.TranslationalSpringConstant c_x(final min=0, start=1)
    "spring constant in x dir";
  parameter Modelica.SIunits.TranslationalSpringConstant c_y(final min=0, start=1)
    "spring constant in y dir";
  parameter Modelica.SIunits.RotationalSpringConstant c_phi(final min=0, start=1.0e5)
    "Spring constant";
  parameter Modelica.SIunits.Position s_relx0=0 "unstretched spring length";
  parameter Modelica.SIunits.Position s_rely0=0 "unstretched spring length";
  parameter Modelica.SIunits.Angle phi_rel0=0 "Unstretched spring angle";

  Modelica.SIunits.Position s_relx(final stateSelect=stateSelect, start = 0)
    "spring length" annotation(Dialog(group="Initialization", showStartAttribute=true));
  Modelica.SIunits.Position s_rely(final stateSelect=stateSelect, start = 0)
    "spring length" annotation(Dialog(group="Initialization", showStartAttribute=true));

  Modelica.SIunits.Angle phi_rel(final stateSelect=stateSelect, start = 0)
    "spring angle" annotation(Dialog(group="Initialization", showStartAttribute=true));
  Modelica.SIunits.Force f_x "Force in x direction";
  Modelica.SIunits.Force f_y "Force in y direction";

  parameter SI.Position s_small = 1.E-10
    "Prevent zero-division if distance between frame_a and frame_b is zero" annotation (Dialog(
      tab="Advanced"));

  parameter Boolean enableAssert = true
    "Cause an assert when the distance between frame_a and frame_b < s_small" annotation (Dialog(
      tab="Advanced"));

  parameter SI.Length zPosition = planarWorld.defaultZPosition
    "z position of cylinder representing the fixed translation" annotation (Dialog(
      tab="Animation", group="if animation = true", enable=animate));
  parameter Integer numberOfWindings = 5 "Number of spring windings"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animate));
  input SI.Position width = planarWorld.defaultForceWidth "Width of spring"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animate));
  input SI.Position coilWidth = width/10 "Width of spring coil"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animate));
  input Modelica.Mechanics.MultiBody.Types.SpecularCoefficient
    specularCoefficient = planarWorld.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animate));
  input Types.Color color = Types.Defaults.SpringColor "Color of spring"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animate));

  SI.Length length
    "Distance between the origin of frame_a and the origin of frame_b";
  SI.Position r_rel_0[3]
    "Position vector from frame_a to frame_b resolved in world frame";
  Real e_rel_0[3](each final unit="1")
    "Unit vector in direction from frame_a to frame_b, resolved in world frame";

  //Visualization
  import MB = Modelica.Mechanics.MultiBody;
  parameter Boolean animate = true "enable Animation"
                                                     annotation(Dialog(group="Animation"));
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
equation

  if enableAssert then

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

  end if;
  r_rel_0 = {s_relx, s_rely, 0};
  length = Modelica.Math.Vectors.length(r_rel_0);
  e_rel_0 = r_rel_0/Modelica.Mechanics.MultiBody.Frames.Internal.maxWithoutEvent(length, s_small);

  phi_rel = frame_b.phi - frame_a.phi;
  frame_a.t = 0;
  frame_b.t = 0;
  s_relx = frame_b.x-frame_a.x;
  s_rely = frame_b.y-frame_a.y;
  f_x = c_x*(s_relx - s_relx0);
  f_y = c_y*(s_rely - s_rely0);
  frame_a.fx = -f_x;
  frame_b.fx = f_x;
  frame_a.fy = -f_y;
  frame_b.fy = f_y;
  annotation (
    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p></html>",  info="<html>
<p>A <i>linear translational spring</i>. x- and y direction stiffness can be parameterized.</p>
</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Text(
          extent={{140,-100},{-142,-142}},
          textString="%name"),
        Line(
          points={{-100,0},{-58,0},{-43,-30},{-13,30},{17,-30},{47,30},{62,0},{100,
              0}},
          thickness=0.5),
        Line(points={{-68,0},{-68,65}},  color={128,128,128}),
        Line(points={{72,0},{72,65}},  color={128,128,128}),
        Line(points={{-68,60},{72,60}}, color={128,128,128}),
        Polygon(
          points={{62,63},{72,60},{62,57},{62,63}},
          lineColor={128,128,128},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-20,40},{20,65}},
          lineColor={0,0,255},
          textString="phi_rel")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(
          points={{-100,0},{-58,0},{-43,-30},{-13,30},{17,-30},{47,30},{62,0},{100,
              0}},
          thickness=0.5),
        Line(points={{-68,0},{-68,65}},  color={128,128,128}),
        Line(points={{72,0},{72,65}},  color={128,128,128}),
        Line(points={{-68,60},{72,60}}, color={128,128,128}),
        Polygon(
          points={{62,63},{72,60},{62,57},{62,63}},
          lineColor={128,128,128},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-20,40},{20,65}},
          lineColor={0,0,255},
          textString="phi_rel")}));
end Spring;
