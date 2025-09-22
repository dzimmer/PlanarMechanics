within PlanarMechanics.Sensors;
model AbsolutePosition "Measure absolute position and orientation of the origin of frame connector"
  extends Internal.PartialAbsoluteSensor;

  Modelica.Blocks.Interfaces.RealOutput r_phi[3](
    final quantity = {"Position", "Position", "Angle"},
    final unit = {"m", "m", "rad"})
    "Vector of absolute measurements of frame_a on position level, resolved in frame defined by resolveInFrame"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={110,0})));
  Modelica.Blocks.Interfaces.RealOutput r[2](
    each final quantity = "Position",
    each final unit = "m") "Vector of absolute position, resolved in frame defined by resolveInFrame" annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput phi(
    final quantity="Angle",
    final unit="rad") "Absolute angle" annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Interfaces.Frame_resolve frame_resolve if resolveInFrame ==
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve
    "Coordinate system in which output vector r is optionally resolved"
    annotation (Placement(transformation(extent={{-16,-16},{16,16}},
         rotation=-90,
         origin={0,-100})));

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameA resolveInFrame=
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a
    "Frame in which output vector r shall be resolved (1: world, 2: frame_a, 3:frame_resolve)";

protected
  Internal.BasicAbsolutePosition position(resolveInFrame=resolveInFrame)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Interfaces.ZeroPosition zeroPosition
    if not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve)
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));

equation
  connect(position.frame_resolve, frame_resolve) annotation (Line(
      points={{0,-10},{0,-32.5},{0,-32.5},{0,-55},{0,-100},{0,-100}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(zeroPosition.frame_resolve, position.frame_resolve)
    annotation (Line(
      points={{20,-30},{0,-30},{0,-10}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(position.r, r_phi) annotation (Line(
      points={{11,0},{35.75,0},{35.75,0},{60.5,
          0},{60.5,0},{110,0}},
      color={0,0,127}));
  connect(position.r[1:2], r) annotation (Line(points={{11,0},{80,0},{80,60},{110,60}},                     color={0,0,127}));
  connect(position.r[3], phi) annotation (Line(points={{11,0.333333},{80,0.333333},{80,-60},{110,-60}}, color={0,0,127}));
  connect(position.frame_a, frame_a) annotation (Line(
      points={{-10,0},{-32.5,0},{-32.5,0},{-55,
          0},{-55,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  annotation (
    Icon(
      coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
      graphics={
        Line(
          points={{70,0},{100,0}},
          color={0,0,127}),
        Text(
          extent={{-70,-10},{70,-40}},
          textString="{m, m, rad}",
          textColor={0,0,0}),
        Line(
          points={{0,-100},{0,-70}},
          pattern=LinePattern.Dot),
        Line(
          points={{50,50},{60,60},{100,60}},
          color={0,0,127}),
        Line(
          points={{50,-50},{60,-60},{100,-60}},
          color={0,0,127}),
        Text(
          extent={{70,50},{120,20}},
          textColor={64,64,64},
          textString="m"),
        Text(
          extent={{50,-70},{120,-100}},
          textColor={64,64,64},
          textString="rad"),
        Text(
          extent={{-150,120},{150,80}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>",  info="<html>
<p>
The absolute position vector [<var>x</var>&nbsp;<var>y</var>] and angle&nbsp;<var>&phi;</var>
of the origin of <code>frame_a</code> is determined and provided at the output signal
connectors&nbsp;<code>r</code> and&nbsp;<code>phi</code>, respectively.
Optionally, the two outputs can be concatenated to just one output&nbsp;<code>r_phi</code>
instead, when setting the parameter <code>concatenateOutput&nbsp;=&nbsp;true</code>.
</p>
<p>
Via parameter <code>resolveInFrame</code>, it is defined in which frame
the position vector is resolved.
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\">Options of parameter <strong>resolveInFrame</strong></caption>
  <tr>
    <th>resolveInFrame = &hellip;</th>
    <th>Output vector resolved in</th>
  </tr>
  <tr>
    <td valign=\"top\">Types.ResolveInFrameA.world</td>
    <td valign=\"top\">world frame</td>
  </tr>
  <tr>
    <td valign=\"top\">Types.ResolveInFrameA.frame_a</td>
    <td valign=\"top\">frame_a</td>
  </tr>
  <tr>
    <td valign=\"top\">Types.ResolveInFrameA.frame_resolve</td>
    <td valign=\"top\">frame_resolve (must be connected)</td>
  </tr>
</table>

<p>
If <code>resolveInFrame&nbsp;= Types.ResolveInFrameA.frame_resolve</code>,
the conditional connector <code>frame_resolve</code> is enabled
and&nbsp;<code>r</code> is resolved in the frame, to which
<code>frame_resolve</code> is connected.
Note, if this connector is enabled, it must be connected.
</p>
<p>
Example: If <code>resolveInFrame = Types.ResolveInFrameA.frame_resolve</code>,
the output vector is computed as:
</p>
<div>
<img src=\"modelica://PlanarMechanics/Resources/Images/equations/equation-dcUlfcwL.png\" alt=\"r =transpose([cos(frame_resolve.phi), -sin(frame_resolve.phi), 0; sin(frame_resolve.phi),cos(frame_resolve.phi), 0;0, 0, 1]) * [frame_a.x;frame_a.y;frame_a.phi] - [0;0;frame_resolve.phi]\"/>
</div>
<p>
With <var>r</var>&nbsp;= {<code>r</code>, <code>phi</code>}&nbsp;= <code>r_phi</code>.
</p>
</html>"));
end AbsolutePosition;
