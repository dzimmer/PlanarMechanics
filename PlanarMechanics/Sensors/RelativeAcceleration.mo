within PlanarMechanics.Sensors;
model RelativeAcceleration "Measure relative acceleration between the origins of two frame connectors"
  extends Internal.PartialRelativeSensor;

  Modelica.Blocks.Interfaces.RealOutput a_z_rel[3](
    final quantity = {"Acceleration", "Acceleration", "AngularAcceleration"},
    final unit = {"m/s2", "m/s2", "rad/s2"})
    "Vector of relative measurements from frame_a to frame_b on acceleration level, resolved in frame defined by resolveInFrame"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-110})));
  Modelica.Blocks.Interfaces.RealOutput a_rel[2](
    each final quantity = "Acceleration",
    each final unit = "m/s2") "Vector of relative acceleration, resolved in frame defined by resolveInFrame" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-60,-110})));
  Modelica.Blocks.Interfaces.RealOutput z_rel(
    final quantity="AngularAcceleration",
    final unit="rad/s2") "Relative angular acceleration" annotation (Placement(transformation(
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
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Interfaces.ZeroPosition zeroPosition if not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve)
    annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
  Modelica.Blocks.Continuous.Der der_r_rel[3] annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,0})));
  TransformRelativeVector transformRelativeVector(
    frame_r_in= Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a,
    frame_r_out=resolveInFrame)
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Modelica.Blocks.Continuous.Der der_r_rel1[3] annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-70})));
equation
  connect(relativePosition.frame_a, frame_a) annotation (Line(
      points={{-10,40},{-70,40},{-70,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(relativePosition.frame_b, frame_b) annotation (Line(
      points={{10,40},{70,40},{70,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(relativePosition.r_rel, der_r_rel[1:2].u)
    annotation (Line(
      points={{-6,29},{-6,20},{0,20},{0,12}},
      color={0,0,127}));
  connect(relativePosition.phi_rel, der_r_rel[3].u) annotation (Line(points={{6,29},{6,20},{0,20},{0,12}}, color={0,0,127}));
  connect(transformRelativeVector.frame_a, frame_a) annotation (Line(
      points={{-10,-40},{-70,-40},{-70,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(transformRelativeVector.frame_b, frame_b) annotation (Line(
      points={{10,-40},{70,-40},{70,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(transformRelativeVector.frame_resolve, frame_resolve) annotation (Line(
      points={{10,-31.9},{30,-31.9},{30,80},{100,80}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(zeroPosition.frame_resolve, transformRelativeVector.frame_resolve)
    annotation (Line(
      points={{40,-20},{30,-20},{30,-31.9},{10,-31.9}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(der_r_rel.y, transformRelativeVector.r_in) annotation (Line(
      points={{-2.22045e-15,-11},{-2.22045e-15,-14},{0,-14},{0,-28}},
      color={0,0,127}));
  connect(transformRelativeVector.r_out, der_r_rel1.u) annotation (Line(
      points={{0,-51},{0,-58},{2.22045e-15,-58}},
      color={0,0,127}));
  connect(der_r_rel1.y, a_z_rel) annotation (Line(
      points={{-2.22045e-15,-81},{-2.22045e-15,-110},{0,-110}},
      color={0,0,127}));
  connect(der_r_rel1[1:2].y, a_rel) annotation (Line(points={{0,-81},{0,-90},{-60,-90},{-60,-110}}, color={0,0,127}));
  connect(der_r_rel1[3].y, z_rel) annotation (Line(points={{0,-81},{0,-90},{60,-90},{60,-110}}, color={0,0,127}));
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
          extent={{-120,-70},{-60,-100}},
          textColor={64,64,64},
          textString="m/s2"),
        Text(
          extent={{-30,-70},{60,-100}},
          textColor={64,64,64},
          textString="rad/s2"),
        Text(
          extent={{-150,140},{150,100}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-40,-10},{40,-70}},
          textColor={0,0,0},
          textString="m/s2
m/s2
rad/s2")}),
    Documentation(revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>",  info="<html>
<p>
The relative acceleration vector [<var>v<sub>x</sub></var>&nbsp;<var>v<sub>y</sub></var>]
and the angular acceleration&nbsp;<var>z</var>
of the origin of <code>frame_b</code> to origin of <code>frame_a</code>
are determined and provided at the output signal
connectors <code>a_rel</code> and <code>z_rel</code>, respectively.
Optionally, the two outputs can be concatenated to just one output <code>a_z_rel</code>
instead, when setting the parameter <code>concatenateOutput&nbsp;=&nbsp;true</code>.
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
and <code>a_rel</code> is resolved in the frame, to which
<code>frame_resolve</code> is connected.
Note, if this connector is enabled, it must be connected.
</p>
<p>
Example: If <code>resolveInFrame = Types.ResolveInFrameAB.frame_resolve</code>,
the output vector is computed as:
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
<div>
<img src=\"modelica://PlanarMechanics/Resources/Images/equations/equation-NK9IGjAY.png\" alt=\"a_rel = der(v_rel)\"/>
</div>
<p>
With <var>r<sub>rel</sub></var>&nbsp;= {<code>r_rel</code>, <code>phi_rel</code>}
and <var>a<sub>rel</sub></var>&nbsp;= {<code>a_rel</code>, <code>z_rel</code>}&nbsp;= <code>a_z_rel</code>.
</p>
</html>"));
end RelativeAcceleration;
