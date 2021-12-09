within PlanarMechanics.Sensors.Internal;
model BasicCutForce
  "Measure cut force vector (frame_resolve must be connected)"

  import Modelica.Mechanics.MultiBody.Types.ResolveInFrameA;
  import Modelica.Mechanics.MultiBody.Frames;

  extends Internal.PartialCutForceBaseSensor;

  Modelica.Blocks.Interfaces.RealOutput force[2](
    each final quantity = "Force",
    each final unit = "N")
    "Cut force resolved in frame defined by resolveInFrame"
    annotation (Placement(transformation(
        origin={-80,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  parameter Boolean positiveSign=true
    "= true, if force with positive sign is returned (= frame_a.f), otherwise with negative sign (= frame_b.f)";
protected
  parameter Integer csign=if positiveSign then +1 else -1;
equation
   if resolveInFrame == ResolveInFrameA.world then
      //force = Frames.resolve1(frame_a.R, frame_a.f)*csign;
      force = {frame_a.fx, frame_a.fy} * csign;
   elseif resolveInFrame == ResolveInFrameA.frame_a then
      force = {{cos(frame_a.phi), sin(frame_a.phi)},{-sin(frame_a.phi), cos(frame_a.phi)}}*{frame_a.fx, frame_a.fy}*csign;
   elseif resolveInFrame == ResolveInFrameA.frame_resolve then
      //force = Frames.resolveRelative(frame_a.f, frame_a.R, frame_resolve.R)*csign;
      force = {{cos(frame_resolve.phi), sin(frame_resolve.phi)},{-sin(frame_resolve.phi), cos(frame_resolve.phi)}}*{frame_a.fx, frame_a.fy} * csign;
   else
      assert(false,"Wrong value for parameter resolveInFrame");
      force = zeros(2);
   end if;
  annotation (
     Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={
        Text(
          extent={{-190,-70},{-74,-96}},
          textString="force"),
        Line(points={{-80,-100},{-80,0}}, color={0,0,127})}),
    Documentation(
      revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>",
      info="<html>
<p>
This sensor outputs cut-force between the two connecting frames,
whereby the output signal <code>force&nbsp;= {frame_a.fx, frame_a.fy}</code>.
If parameter <strong>positiveSign</strong>&nbsp;= <strong>false</strong>, the negative
cut-force is provided.
The cut-force is resolved in frame specified by the parameter
<code>resolveInFrame</code>
</p>
<p>
The connector <code>frame_resolve</code> is always present and must,
therefore, be always connected from outside.
</p>
</html>"));
end BasicCutForce;
