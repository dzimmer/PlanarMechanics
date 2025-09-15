within PlanarMechanics.Sensors;
model RelativeVelocity "Measure relative velocity between the origins of two frame connectors"
  extends Internal.PartialRelativeSensor;

  Modelica.Blocks.Interfaces.RealOutput v_w_rel[3](
    final quantity = {"Velocity", "Velocity", "AngularVelocity"},
    final unit = {"m/s", "m/s", "rad/s"})
    "Vector of relative measurements from frame_a to frame_b on velocity level, resolved in frame defined by resolveInFrame"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-110})));
  Modelica.Blocks.Interfaces.RealOutput v_rel[2](
    each final quantity = "Velocity",
    each final unit = "m/s") "Vector of relative velocity, resolved in frame defined by resolveInFrame" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-60,-110})));
  Modelica.Blocks.Interfaces.RealOutput w_rel(
    final quantity="AngularVelocity",
    final unit="rad/s") "Relative angular velocity" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={60,-110})));
  Interfaces.Frame_resolve frame_resolve if resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve "Coordinate system in which v_rel is optionally resolved"
    annotation (Placement(transformation(extent={{84,64},{116,96}})));

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB resolveInFrame=
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a
    "Frame in which output vector v_rel shall be resolved (1: world, 2: frame_a, 3: frame_b, 4: frame_resolve)";

protected
  RelativePosition relativePosition(
    resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Interfaces.ZeroPosition zeroPosition if not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve)
    annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
  Modelica.Blocks.Continuous.Der der_r_rel[3] annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-30})));
  TransformRelativeVector transformRelativeVector(
    frame_r_in= Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a,
    frame_r_out=resolveInFrame)
    annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
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
  connect(relativePosition.r_rel, der_r_rel[1:2].u) annotation (Line(
      points={{-6,-11},{-6,-14},{0,-14},{0,-18}},
      color={0,0,127}));
  connect(relativePosition.phi_rel, der_r_rel[3].u) annotation (Line(points={{6,-11},{6,-14},{0,-14},{0,-18}},
                                                                                                       color={0,0,127}));
  connect(der_r_rel.y, transformRelativeVector.r_in) annotation (Line(
      points={{-1.77636e-15,-41},{-1.77636e-15,-50},{0,-50},{0,-58}},
      color={0,0,127}));
  connect(transformRelativeVector.frame_a, frame_a) annotation (Line(
      points={{-10,-70},{-70,-70},{-70,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(transformRelativeVector.frame_b, frame_b) annotation (Line(
      points={{10,-70},{70,-70},{70,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(transformRelativeVector.frame_resolve, frame_resolve) annotation (Line(
      points={{10,-61.9},{30,-61.9},{30,80},{100,80}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(zeroPosition.frame_resolve, transformRelativeVector.frame_resolve)
    annotation (Line(
      points={{40,-50},{30,-50},{30,-61.9},{10,-61.9}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(transformRelativeVector.r_out, v_w_rel) annotation (Line(
      points={{0,-81},{0,-88.25},{0,-88.25},{
          0,-95.5},{0,-95.5},{0,-110}},
      color={0,0,127}));
  connect(transformRelativeVector.r_out[1:2], v_rel) annotation (Line(points={{0,-81},{0,-90},{-60,-90},{-60,-110}}, color={0,0,127}));
  connect(transformRelativeVector.r_out[3], w_rel) annotation (Line(points={{0,-80.6667},{0,-90},{60,-90},{60,-110}},        color={0,0,127}));
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
          extent={{-110,-70},{-60,-100}},
          textColor={64,64,64},
          textString="m/s"),
        Text(
          extent={{-20,-70},{60,-100}},
          textColor={64,64,64},
          textString="rad/s"),
        Text(
          extent={{-150,140},{150,100}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-40,-10},{40,-70}},
          textString="m/s
m/s
rad/s",
          textColor={0,0,0})}),
    Documentation(revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>",  info="<html>
<p>
The relative velocity vector [<var>v<sub>x</sub></var>&nbsp;<var>v<sub>y</sub></var>]
and the angular velocity&nbsp;<var>&omega;</var>
of the origin of <code>frame_b</code> to origin of <code>frame_a</code>
are determined and provided at the output signal
connectors <code>v_rel</code> and <code>w_rel</code>, respectively.
Optionally, the two outputs can be concatenated to just one output <code>v_w_rel</code>
instead, when setting the parameter <code>concatenateOutput&nbsp;=&nbsp;true</code>.
</p>
<p>
Via parameter <code>resolveInFrame</code> it is defined, in which frame
the velocity vector is resolved.
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
and <code>v_rel</code> is resolved in the frame, to which
<code>frame_resolve</code> is connected.
Note, if this connector is enabled, it must be connected.
</p>
<p>
Example: If resolveInFrame = Types.ResolveInFrameAB.frame_resolve, the output vector is computed as:
</p>
<div>
<img src=\"modelica://PlanarMechanics/Resources/Images/equations/equation-LZbFgA50.png\" alt=\"r_rel = transpose([cos(frame_resolve.phi), -sin(frame_resolve.phi), 0; sin(frame_resolve.phi),cos(frame_resolve.phi), 0;0,0,1]) * [frame_b.x - frame_a.x;frame_b.y - frame_a.y;frame_b.phi - frame_a.phi]\"/>
</div>
<div>
<img src=\"modelica://PlanarMechanics/Resources/Images/equations/equation-b53N2SsO.png\" alt=\"v_rela = der(r_rel)\"/>
</div>
<div>
<img src=\"modelica://PlanarMechanics/Resources/Images/equations/equation-PGBmAMb7.png\" alt=\"v_rel = transpose([cos(frame_resolve.phi), -sin(frame_resolve.phi),0;sin(frame_resolve.phi),cos(frame_resolve.phi),0;0,0,1]) * [cos(frame_a.phi),-sin(frame_a.phi), 0;sin(frame_a.phi), cos(frame_a.phi),0;0,0,1] * r_rela\"/>
</div>
<p>
With <var>r<sub>rel</sub></var>&nbsp;= {<code>r_rel</code>, <code>phi_rel</code>}
and <var>v<sub>rel</sub></var>&nbsp;= {<code>v_rel</code>, <code>w_rel</code>}&nbsp;= <code>v_w_rel</code>.
</p>
</html>"));
end RelativeVelocity;
