within PlanarMechanics.Sensors;
model AbsolutePosition
  "Measure absolute position vector of the origin of a frame connector"
  extends Internal.PartialAbsoluteSensor;
  Modelica.Blocks.Interfaces.RealOutput  r[3](each final quantity="Position", each final unit = "m")
    "Absolute position vector resolved in frame defined by resolveInFrame"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,0})));

  Interfaces.Frame_resolve frame_resolve if resolveInFrame ==
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve
    "Coordinate system in which output vector r is optionally resolved"
    annotation (Placement(transformation(extent={{-16,-16},{16,16}},
        rotation=-90,
        origin={0,-100}),
        iconTransformation(extent={{-16,-16},{16,16}},
        rotation=-90,
        origin={0,-101})));

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameA resolveInFrame=
  Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a
    "Frame in which output vector r shall be resolved (1: world, 2: frame_a, 3:frame_resolve)";

protected
  Internal.BasicAbsolutePosition position(resolveInFrame=resolveInFrame)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  Interfaces.ZeroPosition zeroPosition if
    not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve)
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));

equation
  connect(position.frame_resolve, frame_resolve)         annotation (Line(
      points={{5.88418e-16,-10},{5.88418e-16,-32.5},{9.21485e-16,-32.5},{
          9.21485e-16,-55},{3.33067e-16,-55},{3.33067e-16,-100}},
      color={95,95,95},
      pattern=LinePattern.Dot,
      smooth=Smooth.None));
  connect(zeroPosition.frame_resolve, position.frame_resolve)
    annotation (Line(
      points={{20,-30},{5.88418e-16,-30},{5.88418e-16,-10}},
      color={95,95,95},
      pattern=LinePattern.Dot,
      smooth=Smooth.None));
  connect(position.r, r) annotation (Line(
      points={{11,6.10623e-16},{35.75,6.10623e-16},{35.75,1.16573e-15},{60.5,
          1.16573e-15},{60.5,5.55112e-16},{110,5.55112e-16}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(position.frame_a, frame_a) annotation (Line(
      points={{-10,5.88418e-16},{-32.5,5.88418e-16},{-32.5,9.21485e-16},{-55,
          9.21485e-16},{-55,3.33067e-16},{-100,3.33067e-16}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}),       graphics), Icon(coordinateSystem(
          preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Line(
          points={{70,0},{100,0}},
          color={0,0,127},
          smooth=Smooth.None),
        Text(
          extent={{-127,95},{134,143}},
          textString="%name",
          lineColor={0,0,255}),
        Text(
          extent={{62,46},{146,16}},
          lineColor={0,0,0},
          textString="r"),
        Text(
          visible = (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve),
          extent={{15,-67},{146,-92}},
          lineColor={95,95,95},
          textString="resolve"),
        Line(
          visible = (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve),
          points={{0,-96},{0,-96},{0,-70},{0,-70}},
          color={0,0,0},
          smooth=Smooth.None,
          pattern=LinePattern.Dot)}),
    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p></html>",  info="<html>
<p>The absolute position and angle vector<b> [x,y,phi]</b> of the origin of frame_a is determined and provided at the output signal connector <b>r</b>.</p>
<p>Via parameter <b>resolveInFrame</b> it is defined, in which frame the position and angle vector is resolved: </p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\"><tr>
<td><p align=\"center\"><h4>resolveInFrame =</h4></p><p align=\"center\">Types.ResolveInFrameA.</p></td>
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
<td valign=\"top\"><p>frame_resolve</p></td>
<td valign=\"top\"><p>Resolve vector in frame_resolve</p></td>
</tr>
</table>
<p>If resolveInFrame = Types.ResolveInFrameA.frame_resolve, the conditional connector &QUOT;frame_resolve&QUOT; is enabled and r is resolved in the frame, to which frame_resolve is connected. Note, if this connector is enabled, it must be connected. </p>
<p>Example: If resolveInFrame = Types.ResolveInFrameA.<code>frame_resolve</code>, the output vector is computed as: </p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/equations/equation-dcUlfcwL.png\" alt=\"r =transpose([cos(frame_resolve.phi), -sin(frame_resolve.phi), 0; sin(frame_resolve.phi),cos(frame_resolve.phi), 0;0, 0, 1]) * [frame_a.x;frame_a.y;frame_a.phi] - [0;0;frame_resolve.phi]\"/></p>
</html>"));
end AbsolutePosition;
