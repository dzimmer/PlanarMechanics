within PlanarMechanics.Sensors;
model AbsoluteAcceleration
  "Measure absolute acceleration vector of origin of frame connector"
  extends Internal.PartialAbsoluteSensor;
  Modelica.Blocks.Interfaces.RealOutput a[3](each final quantity="Velocity", each final
            unit =                                                                    "m/s2")
    "Absolute velocity vector resolved in frame defined by resolveInFrame"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={110,0})));

  Interfaces.Frame_resolve frame_resolve if
    resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve
    "Coordinate system in which output vector v is optionally resolved"
    annotation (Placement(transformation(extent={{-16,-16},{16,16}},
        rotation=-90,
        origin={0,-100}),
        iconTransformation(extent={{-16,-16},{16,16}},
        rotation=-90,
        origin={0,-100})));

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameA resolveInFrame=
      Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a
    "Frame in which output vector v shall be resolved (1: world, 2: frame_a, 3: frame_resolve)";

protected
  Internal.BasicAbsolutePosition position(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Continuous.Der der1[3]                           annotation (Placement(transformation(
        extent={{-20,-20},{0,0}},
        origin={-6,10})));
  TransformAbsoluteVector transformAbsoluteVector(frame_r_in=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world,
      frame_r_out=resolveInFrame) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={20,0})));
  Interfaces.ZeroPosition zeroPosition
    annotation (Placement(transformation(extent={{-60,-60},{-80,-40}})));
  Interfaces.ZeroPosition zeroPosition1 if
       not (
    resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve)
    annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
  Modelica.Blocks.Continuous.Der der2[3]                           annotation (Placement(transformation(
        extent={{-20,-20},{0,0}},
        origin={68,10})));
equation
  connect(position.r, der1.u) annotation (Line(
      points={{-39,6.10623e-16},{-32.25,6.10623e-16},{-32.25,1.27676e-15},{
          -25.5,1.27676e-15},{-25.5,6.66134e-16},{-28,6.66134e-16}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(position.frame_a, frame_a) annotation (Line(
      points={{-60,5.88418e-16},{-70,5.88418e-16},{-70,9.21485e-16},{-80,
          9.21485e-16},{-80,3.33067e-16},{-100,3.33067e-16}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(zeroPosition.frame_resolve, position.frame_resolve) annotation (Line(
      points={{-60,-50},{-50,-50},{-50,-10}},
      color={95,95,95},
      pattern=LinePattern.Dot,
      smooth=Smooth.None));
  connect(transformAbsoluteVector.frame_a, frame_a) annotation (Line(
      points={{20,10},{20,20},{-70,20},{-70,3.33067e-16},{-100,3.33067e-16}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(transformAbsoluteVector.frame_resolve, zeroPosition1.frame_resolve)
    annotation (Line(
      points={{19.9,-10},{32,-10},{32,-50},{60,-50}},
      color={95,95,95},
      pattern=LinePattern.Dot,
      smooth=Smooth.None));
  connect(transformAbsoluteVector.frame_resolve, frame_resolve) annotation (Line(
      points={{19.9,-10},{20,-10},{20,-50},{3.33067e-16,-50},{3.33067e-16,-100}},
      color={95,95,95},
      pattern=LinePattern.Dot,
      smooth=Smooth.None));

  connect(der1.y, transformAbsoluteVector.r_in) annotation (Line(
      points={{-5,6.10623e-16},{17.5,6.10623e-16},{17.5,1.17885e-15},{8,
          1.17885e-15}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(transformAbsoluteVector.r_out, der2.u) annotation (Line(
      points={{31,-1.73933e-16},{38.5,-1.73933e-16},{38.5,6.66134e-16},{46,
          6.66134e-16}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(der2.y, a) annotation (Line(
      points={{69,6.10623e-16},{89.5,6.10623e-16},{89.5,5.55112e-16},{110,
          5.55112e-16}},
      color={0,0,127},
      smooth=Smooth.None));

  annotation (Icon(coordinateSystem(
          preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Line(
          points={{70,0},{100,0}},
          color={0,0,127},
          smooth=Smooth.None),
        Text(
          extent={{-130,72},{131,120}},
          textString="%name",
          lineColor={0,0,255}),
        Text(
          extent={{58,48},{142,18}},
          lineColor={0,0,0},
          textString="a"),
        Text(
          extent={{15,-67},{146,-92}},
          lineColor={95,95,95},
          textString="resolve"),
        Line(
          points={{0,-70},{0,-95}},
          color={95,95,95},
          smooth=Smooth.None,
          pattern=LinePattern.Dot)}),
    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p></html>",  info="<html>
<p>The absolute acceleration vector of the origin of frame_a is determined and provided at the output signal connector <b>a</b>. </p>
<p>Via parameter <b>resolveInFrame</b> it is defined, in which frame the velocity vector is resolved: </p>
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
<p>If resolveInFrame = Types.ResolveInFrameA.frame_resolve, the conditional connector &QUOT;frame_resolve&QUOT; is enabled and v is resolved in the frame, to which frame_resolve is connected. Note, if this connector is enabled, it must be connected. </p>
<p>Example: If resolveInFrame = Types.ResolveInFrameA.frame_resolve, the output vector is computed as: </p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/equations/equation-x2brh9fX.png\" alt=\"
v0 = der([x,y,phi])\"/></p><p><img src=\"modelica://PlanarMechanics/Resources/Images/equations/equation-Kgd1NoyE.png\" alt=\"v = [cos(frame_resolve.phi), sin(frame_resolve.phi),0;-sin(frame_resolve.phi),cos(frame_resolve.phi),0;0,0,1] * [v0[1];v0[2];v0[3]]\"/></p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/equations/equation-FoL9Qy7b.png\" alt=\"a = der(v)\"/></p>
<p><code>where </code><img src=\"modelica://PlanarMechanics/Resources/Images/equations/equation-zBL2JSRi.png\" alt=\"[x,y,phi]\"/><code> is position and angle vector of origin of frame_a resolved in world coordinate.</code> </p>
</html>"));
end AbsoluteAcceleration;
