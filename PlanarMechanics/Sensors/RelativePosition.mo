within PlanarMechanics.Sensors;
model RelativePosition
  "Measure relative position vector between the origins of two frame connectors"
  extends Internal.PartialRelativeSensor;
  Modelica.Blocks.Interfaces.RealOutput r_rel[3]
    "Relative position vector resolved in frame defined by resolveInFrame"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-110})));

  Interfaces.Frame_resolve frame_resolve if resolveInFrame ==
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve
    "Coordinate system in which r_rel is optionally resolved"
    annotation (Placement(transformation(extent={{84,64},{116,96}}),
        iconTransformation(extent={{84,65},{116,97}})));

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB
    resolveInFrame=
  Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a
    "Frame in which output vector r_rel shall be resolved (1: world, 2: frame_a, 3: frame_b, 4: frame_resolve)";

protected
  Internal.BasicRelativePosition relativePosition(resolveInFrame=resolveInFrame)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  Interfaces.ZeroPosition zeroPosition if
    not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve)
    annotation (Placement(transformation(extent={{52,20},{72,40}})));

equation
  connect(relativePosition.frame_a, frame_a) annotation (Line(
      points={{-10,5.88418e-16},{-32.5,5.88418e-16},{-32.5,9.21485e-16},{-55,
          9.21485e-16},{-55,3.33067e-16},{-100,3.33067e-16}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(relativePosition.frame_b, frame_b) annotation (Line(
      points={{10,5.88418e-16},{32.5,5.88418e-16},{32.5,9.21485e-16},{55,
          9.21485e-16},{55,3.33067e-16},{100,3.33067e-16}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(relativePosition.frame_resolve, frame_resolve) annotation (Line(
      points={{10,8.1},{26,8.1},{26,8},{36,8},{36,80},{100,80}},
      color={95,95,95},
      pattern=LinePattern.Dot,
      smooth=Smooth.None));
  connect(zeroPosition.frame_resolve, relativePosition.frame_resolve) annotation (Line(
      points={{52,30},{36,30},{36,8.1},{10,8.1}},
      color={95,95,95},
      pattern=LinePattern.Dot,
      smooth=Smooth.None));
  connect(relativePosition.r_rel, r_rel) annotation (Line(
      points={{6.10623e-16,-11},{6.10623e-16,-35.75},{1.16573e-15,-35.75},{
          1.16573e-15,-60.5},{5.55112e-16,-60.5},{5.55112e-16,-110}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Line(
          points={{0,-70},{0,-100}},
          color={0,0,127},
          smooth=Smooth.None),
        Text(
          extent={{-127,95},{134,143}},
          textString="%name",
          lineColor={0,0,255}),
        Text(
          extent={{18,-80},{102,-110}},
          lineColor={0,0,0},
          textString="r_rel")}),
    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p></html>",  info="<html>
<p>The relative position and angle vector<b> [x,y,phi]</b> between the origins of frame_a and frame_b are determined and provided at the output signal connector <b>r_rel</b>. </p>
<p>Via parameter <b>resolveInFrame</b> it is defined, in which frame the position vector is resolved: </p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\"><tr>
<td><p align=\"center\"><h4>resolveInFrame =</h4></p><p align=\"center\">Types.ResolveInFrameAB.</p></td>
<td><p align=\"center\"><h4>Meaning</h4></p></td>
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
<p>If resolveInFrame = Types.ResolveInFrameAB.frame_resolve, the conditional connector &QUOT;frame_resolve&QUOT; is enabled and r_rel is resolved in the frame, to which frame_resolve is connected. Note, if this connector is enabled, it must be connected. </p>
<p>Example: If resolveInFrame = Types.ResolveInFrameAB.frame_resolve, the output vector is computed as: </p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/equations/equation-LrRs4SXG.png\" alt=\"r_rel = transpose([cos(frame_resolve.phi), -sin(frame_resolve.phi), 0; sin(frame_resolve.phi),cos(frame_resolve.phi), 0;0,0,1]) * [frame_b.x - frame_a.x;frame_b.y - frame_a.y;frame_b.phi - frame_a.phi]\"/></p>
</html>"));
end RelativePosition;
