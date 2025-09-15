within PlanarMechanics.Sensors;
model RelativePosition "Measure relative position and orientation between the origins of two frame connectors"
  extends Internal.PartialRelativeSensor;

  Modelica.Blocks.Interfaces.RealOutput r_phi_rel[3](
    final quantity = {"Position", "Position", "Angle"},
    final unit = {"m", "m", "rad"})
    "Vector of relative measurements from frame_a to frame_b on position level, resolved in frame defined by resolveInFrame"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-110})));
  Modelica.Blocks.Interfaces.RealOutput r_rel[2](
    each final quantity = "Position",
    each final unit = "m") "Vector of relative position, resolved in frame defined by resolveInFrame" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-60,-110})));
  Modelica.Blocks.Interfaces.RealOutput phi_rel(
    final quantity="Angle",
    final unit="rad") "Relative angle" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={60,-110})));
  Interfaces.Frame_resolve frame_resolve if resolveInFrame ==
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve
    "Coordinate system in which r_rel is optionally resolved"
    annotation (Placement(transformation(extent={{84,64},{116,96}}),
        iconTransformation(extent={{84,65},{116,97}})));

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB resolveInFrame=
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a
    "Frame in which output vector r_rel shall be resolved (1: world, 2: frame_a, 3: frame_b, 4: frame_resolve)";

protected
  Internal.BasicRelativePosition relativePosition(resolveInFrame=resolveInFrame)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Interfaces.ZeroPosition zeroPosition
    if not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve)
    annotation (Placement(transformation(extent={{52,20},{72,40}})));

equation
  connect(relativePosition.frame_a, frame_a) annotation (Line(
      points={{-10,0},{-32.5,0},{-32.5,0},{-55,
          0},{-55,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(relativePosition.frame_b, frame_b) annotation (Line(
      points={{10,0},{32.5,0},{32.5,0},{55,
          0},{55,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(relativePosition.frame_resolve, frame_resolve) annotation (Line(
      points={{10,8.1},{26,8.1},{26,8},{36,8},{36,80},{100,80}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(zeroPosition.frame_resolve, relativePosition.frame_resolve) annotation (Line(
      points={{52,30},{36,30},{36,8.1},{10,8.1}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(relativePosition.r_rel, r_phi_rel) annotation (Line(
      points={{0,-11},{0,-35.75},{0,-35.75},{
          0,-60.5},{0,-60.5},{0,-110}},
      color={0,0,127}));
  connect(relativePosition.r_rel[1:2], r_rel) annotation (Line(points={{0,-11},{0,-80},{-60,-80},{-60,-110}},               color={0,0,127}));
  connect(relativePosition.r_rel[3], phi_rel) annotation (Line(points={{0,-10.6667},{0,-80},{60,-80},{60,-110}},        color={0,0,127}));
 annotation (
    Icon(
      coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
      graphics={
        Line(
          points={{0,-70},{0,-100}},
          color={0,0,127}),
        Line(
          points={{-50,-50},{-60,-60},{-60,-100}},
          color={0,0,127}),
        Line(
          points={{50,-50},{60,-60},{60,-100}},
          color={0,0,127}),
        Text(
          extent={{-100,-70},{-60,-100}},
          textColor={64,64,64},
          textString="m"),
        Text(
          extent={{0,-70},{60,-100}},
          textColor={64,64,64},
          textString="rad"),
        Text(
          extent={{-150,140},{150,100}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-70,-10},{70,-40}},
          textString="{m, m, rad}",
          textColor={0,0,0})}),
    Documentation(revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>",  info="<html>
<p>
The relative position vector [<var>x</var>&nbsp;<var>y</var>]
and the angle&nbsp;<var>&phi;</var>
of the origin of <code>frame_b</code> to origin of <code>frame_a</code>
are determined and provided at the output signal
connectors <code>r_rel</code> and <code>phi_rel</code>, respectively.
Optionally, the two outputs can be concatenated to just one output <code>r_phi_rel</code>
instead, when setting the parameter <code>concatenateOutput&nbsp;=&nbsp;true</code>.
</p>
<p>
Via parameter <code>resolveInFrame</code> it is defined, in which frame
the position vector is resolved.
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
the conditional connector <code>frame_resolve</code> is enabled
and <code>r_rel</code> is resolved in the frame, to which
<code>frame_resolve</code> is connected.
Note, if this connector is enabled, it must be connected.
</p>
<p>
Example: If <code>resolveInFrame = Types.ResolveInFrameAB.frame_resolve</code>,
the output vector is computed as:
</p>
<div>
<img src=\"modelica://PlanarMechanics/Resources/Images/equations/equation-LrRs4SXG.png\" alt=\"r_rel = transpose([cos(frame_resolve.phi), -sin(frame_resolve.phi), 0; sin(frame_resolve.phi),cos(frame_resolve.phi), 0;0,0,1]) * [frame_b.x - frame_a.x;frame_b.y - frame_a.y;frame_b.phi - frame_a.phi]\"/>
</div>
<p>
With <var>r<sub>rel</sub></var>&nbsp;= {<code>r_rel</code>, <code>phi_rel</code>}&nbsp;= <code>r_phi_rel</code>..
</p>
</html>"));
end RelativePosition;
