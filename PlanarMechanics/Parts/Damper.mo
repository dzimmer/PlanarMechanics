within PlanarMechanics.Parts;
model Damper "Linear (velocity dependent) damper"
  extends BaseClasses.TwoConnectorShapes;
  extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPort(
    final T=293.15);
  parameter StateSelect stateSelect=StateSelect.default
    "Priority to use phi and w as states" annotation(HideResult=true,Dialog(tab="Advanced"));
  parameter SI.TranslationalDampingConstant d=1 "Damping constant";
  SI.Length[2] r0(each final stateSelect=stateSelect,start={0,0});
  Real[2] d0;
  SI.Velocity vx(start = 0);
  SI.Velocity vy(start = 0);
  SI.Velocity v;
  SI.Force f;
  parameter SI.Position s_small = 1.E-10
    "Prevent zero-division by regularization if distance between frame_a and frame_b is zero"
    annotation (Dialog(tab="Advanced"));

  parameter Boolean enableAssert = false
    "Cause an assert when the distance between frame_a and frame_b < s_small" annotation (Dialog(
      tab="Advanced"));

  //Visualization
  parameter SI.Length length_a = planarWorld.defaultForceLength
    "Length of cylinder at frame_a side"
    annotation (Dialog(tab="Animation", group="Damper cylinders (if animation = true)", enable=animate));
  input SI.Diameter diameter_a = planarWorld.defaultForceWidth
    "Diameter of cylinder at frame_a side"
    annotation (Dialog(tab="Animation", group="Damper cylinders (if animation = true)", enable=animate));
  input SI.Diameter diameter_b = 0.6*diameter_a
    "Diameter of cylinder at frame_b side"
    annotation (Dialog(tab="Animation", group="Damper cylinders (if animation = true)", enable=animate));
  input Types.Color color_a = {0,127,255} "Color of cylinder at frame_a side"
    annotation (HideResult=true, Dialog(tab="Animation", group="Damper cylinders (if animation = true)", enable=animate, colorSelector=true));
  input Types.Color color_b = {0,64,200} "Color of cylinder at frame_b side"
    annotation (HideResult=true, Dialog(tab="Animation", group="Damper cylinders (if animation = true)", enable=animate, colorSelector=true));

  SI.Distance length
    "Distance between the origin of frame_a and the origin of frame_b";
protected
  SI.Position r0_b[3] = {d0[1], d0[2], 0} * noEvent(min(length_a, length));
  MB.Visualizers.Advanced.Shape cylinder_a(
    shapeType="cylinder",
    color=color_a,
    specularCoefficient=specularCoefficient,
    length=noEvent(min(length_a, length)),
    width=diameter_a,
    height=diameter_a,
    lengthDirection={d0[1], d0[2], 0},
    widthDirection={0,0,1},
    r=MB.Frames.resolve1(planarWorld.R,{frame_a.x,frame_a.y,zPosition})+planarWorld.r_0,
    R=planarWorld.R) if planarWorld.enableAnimation and animate;
  MB.Visualizers.Advanced.Shape cylinder_b(
    shapeType="cylinder",
    color=color_b,
    specularCoefficient=specularCoefficient,
    length=noEvent(max(length - length_a, 0)),
    width=diameter_b,
    height=diameter_b,
    lengthDirection={r0[1], r0[2], 0},
    widthDirection={0,0,1},
    r_shape=r0_b,
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
 ");
  end if;

  length = Modelica.Math.Vectors.length(r0);
  frame_a.x + r0[1] = frame_b.x;
  frame_a.y + r0[2] = frame_b.y;
  d0= Modelica.Math.Vectors.normalize({r0[1],r0[2]},s_small);
  der(frame_a.x) + vx = der(frame_b.x);
  der(frame_a.y) + vy = der(frame_b.y);
  v = {vx,vy}*d0;
  f = -d*v;
  frame_a.fx = d0[1] * f;
  frame_a.fy = d0[2] * f;
  frame_a.t = 0;
  frame_a.fx + frame_b.fx = 0;
  frame_a.fy + frame_b.fy = 0;
  frame_a.t + frame_b.t = 0;

  lossPower = -f*v;

  annotation (
    Icon(graphics={
        Line(points={{-60,30},{60,30}}),
        Line(points={{-60,-30},{60,-30}}),
        Line(points={{-100,0},{100,0}}),
        Rectangle(
          extent={{-60,30},{30,-30}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,80},{150,40}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-100,-50},{100,-80}},
          textColor={0,0,0},
          textString="d=%d"),
        Line(
          visible=useHeatPort,
          points={{-100,-100},{-100,-80},{-18,0}},
          color={191,0,0},
          pattern=LinePattern.Dot),
        Ellipse(
          extent={{-90,10},{-70,-10}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{70,10},{90,-10}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
    Documentation(revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<b>Developed 2010-2020 at the DLR Institute of System Dynamics and Control</b>
</p>
</html>",  info="<html>
<p>This component is a <b>linear damper</b>, which acts as a line force between frame_a and frame_b. A <b>force f</b> is exerted on the origin of frame_b and with opposite sign on the origin of frame_a along the line from the origin of frame_a to the origin of frame_b according to the equation: </p>
<p><code>f = d*<b>der</b>(s);</code></p>
<p>where &quot;d&quot; is the damping constant, &quot;s&quot; is the distance between the origin of frame_a and origin of frame_b, and &quot;der(s)&quot; is the time derivative of &quot;s&quot;.</p>
<p>In the following figure a typical animation is shown where a mass is hanging on a damper.</p>

<blockquote>
<img src=\"modelica://PlanarMechanics/Resources/Images/Parts/Damper.png\" alt=\"Damper animation\">
</blockquote>
</html>"));
end Damper;
