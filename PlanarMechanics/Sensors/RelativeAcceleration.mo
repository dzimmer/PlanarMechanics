within PlanarMechanics.Sensors;
model RelativeAcceleration
  "Measure relative acceleration vector between the origins of two frame connectors"
  extends Internal.PartialRelativeSensor;
  Modelica.Blocks.Interfaces.RealOutput a_rel[3](each final quantity="Velocity", each final
            unit =                                                                        "m/s")
    "Relative velocity vector resolved in frame defined by resolveInFrame"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-110})));

  Interfaces.Frame_resolve frame_resolve if resolveInFrame ==
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve
    "Coordinate system in which v_rel is optionally resolved"
    annotation (Placement(transformation(extent={{84,64},{116,96}}),
        iconTransformation(extent={{84,65},{116,97}})));

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB
    resolveInFrame=
  Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a
    "Frame in which output vector v_rel shall be resolved (1: world, 2: frame_a, 3: frame_b, 4: frame_resolve)";

protected
  RelativePosition relativePosition(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a)
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  Interfaces.ZeroPosition zeroPosition if
    not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve)
    annotation (Placement(transformation(extent={{49,-37},{69,-17}})));
  Modelica.Blocks.Continuous.Der der_r_rel[3]                      annotation (Placement(transformation(
        extent={{-20,-20},{0,0}},
        rotation=-90,
        origin={10,-17})));
  TransformRelativeVector transformRelativeVector(
      frame_r_in= Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a,
      frame_r_out=resolveInFrame)
    annotation (Placement(transformation(extent={{-10,-53},{10,-33}})));
  Modelica.Blocks.Continuous.Der der_r_rel1[3]                      annotation (Placement(transformation(
        extent={{-20,-20},{0,0}},
        rotation=-90,
        origin={10,-87})));
equation
  connect(relativePosition.frame_a, frame_a) annotation (Line(
      points={{-10,30},{-32.5,30},{-32.5,9.21485e-16},{-55,9.21485e-16},{-55,
          3.33067e-16},{-100,3.33067e-16}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(relativePosition.frame_b, frame_b) annotation (Line(
      points={{10,30},{32.5,30},{32.5,9.21485e-16},{55,9.21485e-16},{55,
          3.33067e-16},{100,3.33067e-16}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(relativePosition.r_rel, der_r_rel.u)
                                          annotation (Line(
      points={{6.10623e-16,19},{6.10623e-16,5},{4.64678e-15,5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(transformRelativeVector.frame_a, frame_a) annotation (Line(
      points={{-10,-43},{-70,-43},{-70,3.33067e-16},{-100,3.33067e-16}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(transformRelativeVector.frame_b, frame_b) annotation (Line(
      points={{10,-43},{80,-43},{80,3.33067e-16},{100,3.33067e-16}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(transformRelativeVector.frame_resolve, frame_resolve) annotation (Line(
      points={{10,-34.9},{35,-34.9},{35,80},{100,80}},
      color={95,95,95},
      pattern=LinePattern.Dot,
      smooth=Smooth.None));
  connect(zeroPosition.frame_resolve, transformRelativeVector.frame_resolve)
    annotation (Line(
      points={{49,-27},{35,-27},{35,-34.9},{10,-34.9}},
      color={95,95,95},
      pattern=LinePattern.Dot,
      smooth=Smooth.None));
  connect(der_r_rel.y, transformRelativeVector.r_in) annotation (Line(
      points={{3.66379e-16,-18},{6.66134e-16,-18},{6.66134e-16,-31}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(transformRelativeVector.r_out, der_r_rel1.u) annotation (Line(
      points={{6.10623e-16,-54},{6.10623e-16,-59.5},{4.64678e-15,-59.5},{
          4.64678e-15,-65}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(der_r_rel1.y, a_rel) annotation (Line(
      points={{3.66379e-16,-88},{3.66379e-16,-94.5},{5.55112e-16,-94.5},{
          5.55112e-16,-110}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}},
        grid={1,1}),           graphics), Icon(coordinateSystem(
          preserveAspectRatio=true,  extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={
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
          textString="v_rel")}),
    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p></html>",  info="<html>
<p>The relative acceleration vector between the origins of frame_a and of frame_b are determined and provided at the output signal connector <b>a_rel</b>. </p>
<p><code>Via parameter <b>resolveInFrame</b> it is defined, in which frame the velocity vector is resolved: </code></p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\"><tr>
<td><p align=\"center\"><code><b>resolveInFrame =</b>Types.ResolveInFrameAB.</code></p></td>
<td><p><h4>Meaning</h4></p></td>
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
<p><br/>If resolveInFrame = Types.ResolveInFrameAB.frame_resolve, the conditional connector &QUOT;frame_resolve&QUOT; is enabled and a_rel is resolved in the frame, to which frame_resolve is connected. Note, if this connector is enabled, it must be connected. Example: If resolveInFrame = Types.ResolveInFrameAB.frame_resolve, the output vector is computed as: <img src=\"modelica://PlanarMechanics/Resources/Images/equations/equation-LZbFgA50.png\" alt=\"r_rel = transpose([cos(frame_resolve.phi), -sin(frame_resolve.phi), 0; sin(frame_resolve.phi),cos(frame_resolve.phi), 0;0,0,1]) * [frame_b.x - frame_a.x;frame_b.y - frame_a.y;frame_b.phi - frame_a.phi]\"/> </p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/equations/equation-b53N2SsO.png\" alt=\"v_rela = der(r_rel)\"/></p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/equations/equation-PGBmAMb7.png\" alt=\"v_rel = transpose([cos(frame_resolve.phi), -sin(frame_resolve.phi),0;sin(frame_resolve.phi),cos(frame_resolve.phi),0;0,0,1]) * [cos(frame_a.phi),-sin(frame_a.phi), 0;sin(frame_a.phi), cos(frame_a.phi),0;0,0,1] * r_rela\"/></p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/equations/equation-NK9IGjAY.png\" alt=\"a_rel = der(v_rel)\"/> </p>
</html>"));
end RelativeAcceleration;
