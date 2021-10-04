within PlanarMechanics.Sensors;
model Distance
  "Measure the distance between the origins of two frame connectors"
  extends PlanarMechanics.Interfaces.PartialTwoFrames;
  extends Modelica.Icons.RectangularSensor;

  import Modelica.Mechanics.MultiBody.Frames;
  import Modelica.Mechanics.MultiBody.Types;

  Modelica.Blocks.Interfaces.RealOutput distance(
    final quantity = "Position",
    final unit = "m",
    min = 0)
    "Distance between the origin of frame_a and the origin of frame_b"
    annotation (Placement(transformation(
       origin={0,-110},
       extent={{10,-10},{-10,10}},
       rotation=90)));
  parameter Boolean animation = true
    "= true, if animation shall be enabled (show arrow)";
  input SI.Diameter arrowDiameter = planarWorld.defaultArrowDiameter
    "Diameter of relative arrow from frame_a to frame_b"
    annotation (Dialog(group="if animation = true", enable=animation));
  input Types.Color arrowColor = Modelica.Mechanics.MultiBody.Types.Defaults.SensorColor
    "Color of relative arrow from frame_a to frame_b"
    annotation (HideResult=true, Dialog(colorSelector=true, group="if animation = true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = planarWorld.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (HideResult=true, Dialog(group="if animation = true", enable=animation));
  input SI.Position s_small(min=sqrt(Modelica.Constants.small)) = 1.E-10
    "Prevent zero-division if distance between frame_a and frame_b is zero"
    annotation (Dialog(tab="Advanced"));
protected
  inner Modelica.Mechanics.MultiBody.World world;
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Arrow arrow(
    r={frame_a.x,frame_a.y,0},
    r_head={frame_b.x,frame_b.y,0} - {frame_a.x,frame_a.y,0},
    color=arrowColor,
    specularCoefficient=specularCoefficient) if planarWorld.enableAnimation and animation;

protected
  SI.Position r_rel_0[3] = {frame_b.x, frame_b.y, 0} - {frame_a.x, frame_a.y, 0}
    "Position vector from frame_a to frame_b resolved in world frame";
  SI.Area L2 = r_rel_0*r_rel_0;
  SI.Area s_small2 = s_small^2;
equation
  {frame_a.fx, frame_a.fy} = zeros(2);
  {frame_b.fx, frame_b.fy} = zeros(2);
  frame_a.t = 0;
  frame_b.t = 0;

  distance = smooth(1,if noEvent(L2 > s_small2) then sqrt(L2) else L2/(2*s_small)*(3-L2/s_small2));
  annotation (
   Icon(
     coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
     graphics={
        Line(points={{0,-60},{0,-100}}, color={0,0,127}),
        Line(points={{-70,0},{-101,0}}),
        Line(points={{70,0},{100,0}}),
        Text(
          extent={{-150,80},{150,40}},
          textString="%name",
          textColor={0,0,255})}),
   Diagram(
     coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
     graphics={
       Text(
         extent={{-22,70},{20,46}},
         textString="s",
         textColor={0,0,255}),
       Line(points={{-98,40},{88,40}}, color={0,0,255}),
       Polygon(
         points={{102,40},{87,46},{87,34},{102,40}},
         lineColor={0,0,255},
         fillColor={0,0,255},
         fillPattern=FillPattern.Solid)}),
   Documentation(revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010-2020 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>",  info="<html>
<p>
The <strong>distance</strong> between the origins of <code>frame_a</code>
and of <code>frame_b</code> are determined and provided at the
output signal connector <code>distance</code>. This
distance is always positive. <strong>Derivatives</strong> of this
signal can be easily obtained by connecting the
block
<a href=\"modelica://Modelica.Blocks.Continuous.Der\">Modelica.Blocks.Continuous.Der</a>
to <code>distance</code> (this block performs analytic differentiation
of the input signal using the <code><strong>der</strong>(&hellip;)</code> operator).
</p>
<p>
In the following figure the animation of the
sensor is shown. The light blue coordinate system is
<code>frame_a</code>, the dark blue coordinate system is <code>frame_b</code>,
and the yellow arrow is the animated sensor.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Sensors/Distance.png\" alt=\"Distance animation\">
</div>

<p>
If the distance is smaller then the parameter <code>s_small</code>
(in the \"Advanced\" menu), it is approximated such that its derivative is
finite for zero distance. Without such an approximation, the derivative would
be infinite and a&nbsp;division by zero would occur. The approximation is performed
in the following way: If distance&nbsp;&gt;&nbsp;<var>s</var><sub>small</sub>, it is
computed as sqrt(<var>r</var>*<var>r</var>) where&nbsp;<var>r</var> is the
position vector from the origin of <code>frame_a</code> to the origin of <code>frame_b</code>.
If the distance becomes smaller then <var>s</var><sub>small</sub>, the &quot;sqrt()&quot;
function is approximated by a&nbsp;second order polynomial, such that the function
value and its first derivative are identical for sqrt() and the polynomial at
<var>s</var><sub>small</sub>.
Furthermore, the polynomial passes through zero. The effect is, that the distance
function is continuous and differentiable everywhere. The derivative at zero distance
is 3/(2*<var>s</var><sub>small</sub>).
</p>
</html>"));
end Distance;
