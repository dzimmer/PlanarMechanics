within PlanarMechanics.Parts;
model Spring "Linear 2D translational spring"
  extends BaseClasses.TwoConnectorShapes;

  parameter StateSelect stateSelect=StateSelect.default
    "Priority to use phi and w as states" annotation(HideResult=true,Dialog(tab="Advanced"));
  parameter SI.TranslationalSpringConstant c_x(final min=0, start=1)
    "Spring constant in x dir";
  parameter SI.TranslationalSpringConstant c_y(final min=0, start=1)
    "Spring constant in y dir";
  parameter SI.RotationalSpringConstant c_phi(final min=0, start=1.0e5)
    "Spring constant";
  parameter SI.Position s_relx0=0 "Unstretched spring length";
  parameter SI.Position s_rely0=0 "Unstretched spring length";
  parameter SI.Angle phi_rel0=0 "Unstretched spring angle";

  SI.Position s_relx(final stateSelect=stateSelect, start = 0) "Spring length"
    annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Position s_rely(final stateSelect=stateSelect, start = 0) "Spring length"
    annotation(Dialog(group="Initialization", showStartAttribute=true));

  SI.Angle phi_rel(final stateSelect=stateSelect, start = 0) "Spring angle"
                   annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Force f_x "Force in x direction";
  SI.Force f_y "Force in y direction";

  parameter SI.Position s_small = 1.E-10
    "Prevent zero-division if distance between frame_a and frame_b is zero" annotation (Dialog(
      tab="Advanced"));

  parameter Boolean enableAssert = true
    "Cause an assert when the distance between frame_a and frame_b < s_small" annotation (Dialog(
      tab="Advanced"));

  //Visualization
  parameter Integer numberOfWindings = 5 "Number of spring windings"
    annotation (Dialog(tab="Animation", group="Spring coil (if animation = true)", enable=animate));
  input SI.Length width = planarWorld.defaultJointWidth "Width of spring"
    annotation (Dialog(tab="Animation", group="Spring coil (if animation = true)", enable=animate));
  input SI.Length coilWidth = width/10 "Width of spring coil"
    annotation (Dialog(tab="Animation", group="Spring coil (if animation = true)", enable=animate));
  input Types.Color color = Types.Defaults.SpringColor "Color of spring"
    annotation (HideResult=true, Dialog(tab="Animation", group="Spring coil (if animation = true)", enable=animate, colorSelector=true));

  SI.Length length
    "Distance between the origin of frame_a and the origin of frame_b";
  SI.Position r_rel_0[3]
    "Position vector (3D) from frame_a to frame_b resolved in multibody world frame";
  Real e_rel_0[3](each final unit="1")
    "Unit vector (3D) in direction from frame_a to frame_b, resolved in multibody world frame";

protected
  MB.Visualizers.Advanced.Shape shapeCoil(
    shapeType="spring",
    color=color,
    specularCoefficient=specularCoefficient,
    length=length,
    width=width,
    height=coilWidth*2,
    lengthDirection=e_rel_0,
    widthDirection= {0,1,0},
    extra=numberOfWindings,
    r=MB.Frames.resolve1(planarWorld.R,{frame_a.x,frame_a.y,zPosition})+planarWorld.r_0,
    R=planarWorld.R) if planarWorld.enableAnimation and animate;
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
",    level = AssertionLevel.warning);
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
    Documentation(revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<b>Developed 2010-2019 at the DLR Institute of System Dynamics and Control</b>
</p>
</html>",  info="<html>
<p>A <i>linear translational spring</i>. x- and y direction stiffness can be parameterized.</p>
</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(
          points={{-100,0},{-58,0},{-43,-30},{-13,30},{17,-30},{47,30},{62,0},{100,
              0}},
          thickness=0.5),
        Line(points={{-70,-76},{-70,0}}, color={128,128,128}),
        Line(points={{70,-78},{70,0}}, color={128,128,128}),
        Line(points={{-70,-70},{70,-70}},
                                        color={128,128,128}),
        Polygon(
          points={{60,-67},{70,-70},{60,-73},{60,-67}},
          lineColor={128,128,128},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-40,-66},{40,-42}},
          lineColor={128,128,128},
          textString="phi_rel"),
        Text(
          extent={{-150,80},{150,40}},
          textString="%name",
          lineColor={0,0,255})}),
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
