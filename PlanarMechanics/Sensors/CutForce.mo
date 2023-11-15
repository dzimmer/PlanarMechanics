within PlanarMechanics.Sensors;
model CutForce "Measure cut force vector"

  Modelica.Blocks.Interfaces.RealOutput force[2](
    each final quantity = "Force",
    each final unit = "N")
    "Cut force resolved in frame defined by resolveInFrame"
    annotation (Placement(transformation(
        origin={-80,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));

  parameter Boolean animation = true
    "= true, if animation shall be enabled (show arrow)";
  parameter Boolean positiveSign = true
    "= true, if force with positive sign is returned (= frame_a.f), otherwise with negative sign (= frame_b.f)";

  input Real N_to_m(unit="N/m") = planarWorld.defaultN_to_m
    "Force arrow scaling (length = force/N_to_m)"
    annotation (Dialog(group="if animation = true", enable=animation));
  input MB.Types.Color forceColor = Modelica.Mechanics.MultiBody.Types.Defaults.ForceColor
    "Color of force arrow"
    annotation (HideResult=true, Dialog(colorSelector=true, group="if animation = true", enable=animation));
  input MB.Types.SpecularCoefficient specularCoefficient = planarWorld.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (HideResult=true, Dialog(group="if animation = true", enable=animation));

  extends Internal.PartialCutForceSensor;

protected
  SI.Position f_in_m[3] = {frame_a.fx, frame_a.fy, 0}*(if positiveSign then +1 else -1)/N_to_m
    "Force mapped from N to m for animation";
  MB.Visualizers.Advanced.Vector arrowForce(
    coordinates=f_in_m,
    color=forceColor,
    specularCoefficient=specularCoefficient,
    r=MB.Frames.resolve1(planarWorld.R, {frame_b.x,frame_b.y,0}) + planarWorld.r_0,
    quantity=MB.Types.VectorQuantity.Force,
    headAtOrigin=true,
    R=planarWorld.R) if planarWorld.enableAnimation and animation;
  Internal.BasicCutForce cutForce(
    resolveInFrame=resolveInFrame,
    positiveSign=positiveSign)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Interfaces.ZeroPosition zeroPosition
    if not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve)
    annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
equation
  connect(cutForce.frame_a, frame_a) annotation (Line(
      points={{-10,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(cutForce.frame_b, frame_b) annotation (Line(
      points={{10,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(cutForce.frame_resolve, frame_resolve) annotation (Line(
      points={{8,-10},{8,-60},{80,-60},{80,-100}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(cutForce.force, force) annotation (Line(
      points={{-8,-11},{-8,-60},{-80,-60},{-80,-110}},
      color={0,0,127}));
  connect(zeroPosition.frame_resolve, cutForce.frame_resolve) annotation (
      Line(
      points={{40,-30},{8,-30},{8,-10}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  annotation (
    Icon(
      coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
      graphics={
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
The cut-force acting between the two frames to which this model
is connected, is determined and provided at the output signal
connector <code>force</code> (=&nbsp;<code>frame_a.f</code>).
If parameter <code>positiveSign&nbsp;= false</code>, the negative
cut-force is provided (=&nbsp;<code>frame_b.f</code>).
</p>
<p>
Via parameter <code>resolveInFrame</code> it is defined, in which frame
the force vector is resolved.
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\">Options of parameter <strong>resolveInFrame</strong></caption>
  <tr>
    <th>resolveInFrame = &hellip;</th>
    <th>Output vector resolved in</th>
  </tr>
  <tr>
    <td valign=\"top\">Types.ResolveInFrameAB.world</td>
    <td valign=\"top\">world frame</td>
  </tr>
  <tr>
    <td valign=\"top\">Types.ResolveInFrameAB.frame_a</td>
    <td valign=\"top\">frame_a</td>
  </tr>
  <tr>
    <td valign=\"top\">Types.ResolveInFrameAB.frame_b</td>
    <td valign=\"top\">frame_b</td>
  </tr>
  <tr>
    <td valign=\"top\">Types.ResolveInFrameAB.frame_resolve</td>
    <td valign=\"top\">frame_resolve (must be connected)</td>
  </tr>
</table>

<p>
If <code>resolveInFrame&nbsp;= Types.ResolveInFrameAB.frame_resolve</code>,
the conditional connector <code>frame_resolve</code> is enabled and
output <code>force</code> is resolved in the frame, to which
<code>frame_resolve</code> is connected.
Note, if this connector is enabled, it must be connected.
</p>
<p>
In the following figure the modeling and animation of this
sensor is shown.
</p>
<div>
<img src=\"modelica://PlanarMechanics/Resources/Images/Sensors/CutForce2.png\" alt=\"Modelica diagram\">
<br>
<img src=\"modelica://PlanarMechanics/Resources/Images/Sensors/CutForce.png\" alt=\"CutForce animation\">
</div>
</html>"));
end CutForce;
