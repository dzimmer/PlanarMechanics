within PlanarMechanics.Sensors;
model AbsoluteAcceleration
  "Measure absolute acceleration of origin of frame connector"
  extends Internal.PartialAbsoluteSensor;

  Modelica.Blocks.Interfaces.RealOutput a[3](
    final quantity = {"Acceleration", "Acceleration", "AngularAcceleration"},
    final unit = {"m/s2", "m/s2", "rad/s2"})
    "Vector of absolute measurements of frame_a on acceleration level, resolved in frame defined by resolveInFrame"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={110,0})));
  Interfaces.Frame_resolve frame_resolve if
    resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve
    "Coordinate system in which output vector v is optionally resolved"
    annotation (Placement(transformation(extent={{-16,-16},{16,16}},
        rotation=-90,
        origin={0,-100})));

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameA resolveInFrame=
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a
    "Frame in which output vector v shall be resolved (1: world, 2: frame_a, 3: frame_resolve)";

protected
  Internal.BasicAbsolutePosition position(
    resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Continuous.Der der1[3] annotation (Placement(transformation(
        extent={{-30,-10},{-10,10}})));
  TransformAbsoluteVector transformAbsoluteVector(
    frame_r_in=position.resolveInFrame,
    frame_r_out=resolveInFrame) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={50,0})));
  Interfaces.ZeroPosition zeroPosition
    annotation (Placement(transformation(extent={{-60,-60},{-80,-40}})));
  Interfaces.ZeroPosition zeroPosition1 if not (
    resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve)
    annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
  Modelica.Blocks.Continuous.Der der2[3] annotation (Placement(transformation(
        extent={{10,-10},{30,10}})));
equation
  connect(position.r, der1.u) annotation (Line(
      points={{-39,0},{-32,0}},
      color={0,0,127}));
  connect(position.frame_a, frame_a) annotation (Line(
      points={{-60,0},{-70,0},{-70,0},{-80,
          0},{-80,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(zeroPosition.frame_resolve, position.frame_resolve) annotation (Line(
      points={{-60,-50},{-50,-50},{-50,-10}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(transformAbsoluteVector.frame_a, frame_a) annotation (Line(
      points={{50,10},{50,20},{-70,20},{-70,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(transformAbsoluteVector.frame_resolve, zeroPosition1.frame_resolve)
    annotation (Line(
      points={{49.9,-10},{50,-10},{50,-50},{60,-50}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(transformAbsoluteVector.frame_resolve, frame_resolve) annotation (Line(
      points={{49.9,-10},{50,-10},{50,-50},{0,-50},{0,-100}},
      color={95,95,95},
      pattern=LinePattern.Dot));

  connect(der1.y, der2.u) annotation (Line(points={{-9,0},{8,0}}, color={0,0,127}));
  connect(der2.y, transformAbsoluteVector.r_in) annotation (Line(points={{31,0},{38,0}}, color={0,0,127}));
  connect(transformAbsoluteVector.r_out, a) annotation (Line(points={{61,0},{110,0}}, color={0,0,127}));
  annotation (
    Icon(
      coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
      graphics={
        Line(
          points={{70,0},{100,0}},
          color={0,0,127}),
        Text(
          extent={{58,48},{142,18}},
          textString="acc",
          textColor={0,0,0}),
        Text(
          extent={{15,-67},{146,-92}},
          textColor={95,95,95},
          textString="resolve"),
        Line(
          points={{0,-70},{0,-95}},
          color={95,95,95},
          pattern=LinePattern.Dot),
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
The absolute acceleration vector of the origin of <code>frame_a</code>
is determined and provided at the output signal connector&nbsp;<code>a</code>.
</p>
<p>
Via parameter <code>resolveInFrame</code> it is defined, in which frame
the acceleration vector is resolved.
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
and&nbsp;<code>a</code> is resolved in the frame, to which
<code>frame_resolve</code> is connected.
Note, if this connector is enabled, it must be connected.
</p>
<p>
Example: If <code>resolveInFrame = Types.ResolveInFrameA.frame_resolve</code>,
the output vector is computed as:
</p>
<div>
<img src=\"modelica://PlanarMechanics/Resources/Images/equations/equation-x2brh9fX.png\" alt=\"v0 = der([x,y,phi])\"/>
</div>
<div>
<img src=\"modelica://PlanarMechanics/Resources/Images/equations/equation-Kgd1NoyE.png\" alt=\"v = [cos(frame_resolve.phi), sin(frame_resolve.phi),0;-sin(frame_resolve.phi),cos(frame_resolve.phi),0;0,0,1] * [v0[1];v0[2];v0[3]]\"/>
</div>
<div>
<img src=\"modelica://PlanarMechanics/Resources/Images/equations/equation-FoL9Qy7b.png\" alt=\"a = der(v)\"/>
</div>
<p>
where [<var>x</var>&nbsp;<var>y</var>&nbsp;<var>&phi;</var>]
is position and angle vector of origin of <code>frame_a</code> resolved
in world frame.
</p>
</html>"));
end AbsoluteAcceleration;
