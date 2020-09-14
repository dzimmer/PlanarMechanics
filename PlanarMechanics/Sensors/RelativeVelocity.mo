within PlanarMechanics.Sensors;
model RelativeVelocity
  "Measure relative velocity vector between the origins of two frame connectors"
  extends Internal.PartialRelativeSensor;

  Modelica.Blocks.Interfaces.RealOutput v_rel[3]
    "Relative velocity vector resolved in frame defined by resolveInFrame"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-110})));
  Interfaces.Frame_resolve frame_resolve if resolveInFrame ==
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve
    "Coordinate system in which v_rel is optionally resolved"
    annotation (Placement(transformation(extent={{84,64},{116,96}})));

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB resolveInFrame=
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a
    "Frame in which output vector v_rel shall be resolved (1: world, 2: frame_a, 3: frame_b, 4: frame_resolve)";

protected
  RelativePosition relativePosition(
    resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Interfaces.ZeroPosition zeroPosition if not (
    resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve)
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
  connect(relativePosition.r_rel, der_r_rel.u) annotation (Line(
      points={{0,-11},{0,-18},{1.77636e-15,-18}},
      color={0,0,127}));
  connect(der_r_rel.y, transformRelativeVector.r_in) annotation (Line(
      points={{-1.77636e-15,-41},{-1.77636e-15,-50},{0,-50},{0,-58}},
      color={0,0,127}));
  connect(transformRelativeVector.r_out, v_rel) annotation (Line(
      points={{0,-81},{0,-88.25},{0,-88.25},{
          0,-95.5},{0,-95.5},{0,-110}},
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

  annotation (
    Icon(
      coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
      graphics={
        Line(
          points={{0,-70},{0,-100}},
          color={0,0,127}),
        Text(
          extent={{18,-80},{102,-110}},
          textString="v_rel"),
        Text(
          extent={{-150,140},{150,100}},
          textString="%name",
          lineColor={0,0,255})}),
    Documentation(revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<b>Developed 2010-2020 at the DLR Institute of System Dynamics and Control</b>
</p>
</html>",  info="<html>
<p>The relative velocity vector between the origins of frame_a and of frame_b are determined and provided at the output signal connector <b>v_rel</b>.</p>
<p><code>Via parameter <b>resolveInFrame</b> it is defined, in which frame the velocity vector is resolved: </code></p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\"><tr>
<td><p align=\"center\"><code><b>resolveInFrame =</b>Types.ResolveInFrameAB.</code></p></td>
<td><pre><b>Meaning</b></pre></td>
</tr>
<tr>
<td valign=\"top\"><p>world</p></td>
<td valign=\"top\"><p>Resolve vector in world frame</p></td>
</tr>
<tr>
<td valign=\"top\"><p>frame_a</p></td>
<td valign=\"top\"><p>Resolve vector in frame_a</p></td>
</tr>
<tr>
<td valign=\"top\"><p>frame_b</p></td>
<td valign=\"top\"><p>Resolve vector in frame_b</p></td>
</tr>
<tr>
<td valign=\"top\"><p>frame_resolve</p></td>
<td valign=\"top\"><p>Resolve vector in frame_resolve</p></td>
</tr>
</table>
<p>If <code>resolveInFrame = Types.ResolveInFrameAB.frame_resolve</code>, the conditional connector &quot;frame_resolve&quot; is enabled and v_rel is resolved in the frame, to which frame_resolve is connected. Note, if this connector is enabled, it must be connected. Example: If resolveInFrame = Types.ResolveInFrameAB.frame_resolve, the output vector is computed as: </p>
<pre><img src=\"modelica://PlanarMechanics/Resources/Images/equations/equation-LZbFgA50.png\" alt=\"r_rel = transpose([cos(frame_resolve.phi), -sin(frame_resolve.phi), 0; sin(frame_resolve.phi),cos(frame_resolve.phi), 0;0,0,1]) * [frame_b.x - frame_a.x;frame_b.y - frame_a.y;frame_b.phi - frame_a.phi]\"/>
<img src=\"modelica://PlanarMechanics/Resources/Images/equations/equation-b53N2SsO.png\" alt=\"v_rela = der(r_rel)\"/></pre>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/equations/equation-PGBmAMb7.png\" alt=\"v_rel = transpose([cos(frame_resolve.phi), -sin(frame_resolve.phi),0;sin(frame_resolve.phi),cos(frame_resolve.phi),0;0,0,1]) * [cos(frame_a.phi),-sin(frame_a.phi), 0;sin(frame_a.phi), cos(frame_a.phi),0;0,0,1] * r_rela\"/></p>
</html>"));
end RelativeVelocity;
