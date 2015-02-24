within PlanarMechanics.Parts;
model Damper "Linear (velocity dependent) damper"
  extends PlanarMechanics.Interfaces.PartialTwoFrames;
  extends
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPort(
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

  parameter SI.Length zPosition = planarWorld.defaultZPosition
    "Position z of cylinder representing the fixed translation" annotation (Dialog(
      tab="Animation", group="if animation = true", enable=animate));
  parameter SI.Length length_a = planarWorld.defaultForceLength
    "Length of cylinder at frame_a side"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animate));
  input SI.Diameter diameter_a = planarWorld.defaultForceWidth
    "Diameter of cylinder at frame_a side"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animate));
  input SI.Diameter diameter_b = 0.6*diameter_a
    "Diameter of cylinder at frame_b side"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animate));
  input Types.Color color_a = {100,100,100} "Color at frame_a"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animate, colorSelector));
  input Types.Color color_b = {155,155,155} "Color at frame_b"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animate, colorSelector));
  input Modelica.Mechanics.MultiBody.Types.SpecularCoefficient specularCoefficient = planarWorld.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animate));

  SI.Distance length
    "Distance between the origin of frame_a and the origin of frame_b";
  parameter Boolean animate = true "Enable animation"
                                                     annotation(Dialog(group="Animation"));
protected
  SI.Position r0_b[3] = {d0[1], d0[2], 0} * noEvent(min(length_a, length));
  MB.Visualizers.Advanced.Shape shape_a(
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

  MB.Visualizers.Advanced.Shape shape_b(
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
        Line(points={{30,0},{100,0}}),
        Line(points={{-101,0},{-60,0}}),
        Rectangle(
          extent={{-60,30},{30,-30}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,80},{150,40}},
          textString="%name",
          lineColor={0,0,255}),
        Text(
          extent={{-108,-24},{-72,-49}},
          lineColor={128,128,128},
          textString="a"),
        Text(
          extent={{72,-24},{108,-49}},
          lineColor={128,128,128},
          textString="b")}),
    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p></html>",  info="<html>
<p>This component is a <b>linear damper</b>, which acts as a line force between frame_a and frame_b. A <b>force f</b> is exerted on the origin of frame_b and with opposite sign on the origin of frame_a along the line from the origin of frame_a to the origin of frame_b according to the equation: </p>
<p><code>f = d*<b>der</b>(s);</code></p>
<p>where &quot;d&quot; is the damping constant, &quot;s&quot; is the distance between the origin of frame_a and origin of frame_b, and &quot;der(s)&quot; is the time derivative of &quot;s&quot;.</p>
<p>In the following figure a typical animation is shown where a mass is hanging on a damper.<img src=\"modelica://PlanarMechanics/Resources/Images/Damper.png\"/></p>
</html>"));
end Damper;

