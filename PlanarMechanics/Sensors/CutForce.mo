within PlanarMechanics.Sensors;
model CutForce "Measure cut force vector"

  import SI = Modelica.SIunits;

  Modelica.Blocks.Interfaces.RealOutput force[2](final quantity="Force", final unit="N")
    "Cut force resolved in frame defined by resolveInFrame"
       annotation (Placement(transformation(
        origin={-80,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));

  parameter Boolean animation=true
    "= true, if animation shall be enabled (show arrow)";
  parameter Boolean positiveSign=true
    "= true, if force with positive sign is returned (= frame_a.f), otherwise with negative sign (= frame_b.f)";

  input Real N_to_m(unit="N/m") = 1000
    " Force arrow scaling (length = force/N_to_m)"
    annotation (Dialog(group="if animation = true", enable=animation));
  input SI.Diameter forceDiameter=planarWorld.defaultArrowDiameter
    " Diameter of force arrow" annotation (Dialog(group="if animation = true", enable=animation));
  input Types.Color forceColor=Modelica.Mechanics.MultiBody.Types.Defaults.
      ForceColor " Color of force arrow"
    annotation (Dialog(group="if animation = true", enable=animation));
  input Modelica.Mechanics.MultiBody.Types.SpecularCoefficient specularCoefficient = planarWorld.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(group="if animation = true", enable=animation));

  extends Internal.PartialCutForceSensor;

protected
  SI.Position f_in_m[3]={frame_a.fx, frame_a.fy, 0}*(if positiveSign then +1 else -1)/N_to_m
    "Force mapped from N to m for animation";
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Arrow forceArrow(
    diameter=forceDiameter,
    color=forceColor,
    specularCoefficient=specularCoefficient,
    r={frame_b.x, frame_b.y, 0},
    r_tail=f_in_m,
    r_head=-f_in_m) if planarWorld.enableAnimation and animation;

  Internal.BasicCutForce cutForce(resolveInFrame=resolveInFrame, positiveSign=
        positiveSign)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Interfaces.ZeroPosition zeroPosition if
    not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve)
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
equation
  connect(cutForce.frame_a, frame_a)      annotation (Line(
      points={{-50,5.88418e-16},{-62.5,5.88418e-16},{-62.5,9.21485e-16},{-75,
          9.21485e-16},{-75,3.33067e-16},{-100,3.33067e-16}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(cutForce.frame_b, frame_b)      annotation (Line(
      points={{-30,5.88418e-16},{2.5,5.88418e-16},{2.5,9.21485e-16},{35,
          9.21485e-16},{35,3.33067e-16},{100,3.33067e-16}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(cutForce.frame_resolve, frame_resolve)      annotation (Line(
      points={{-32,-10},{-32,-60},{80,-60},{80,-100}},
      color={95,95,95},
      pattern=LinePattern.Dot,
      smooth=Smooth.None));
  connect(cutForce.force, force)      annotation (Line(
      points={{-48,-11},{-48,-60},{-80,-60},{-80,-110}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(zeroPosition.frame_resolve, cutForce.frame_resolve)      annotation (
      Line(
      points={{-5.55112e-16,-30},{-32,-30},{-32,-10}},
      color={95,95,95},
      pattern=LinePattern.Dot,
      smooth=Smooth.None));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={Text(
          extent={{-190,-70},{-74,-96}},
          lineColor={0,0,0},
          textString="force"), Line(points={{-80,-100},{-80,0}}, color={0,0,
              127})}),
    Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,
            100}}),
            graphics),
    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p></html>",  info="<html>
<p>The cut-force acting between the two frames to which this model is connected, is determined and provided at the output signal connector <b>force</b> (= frame_a.f). If parameter <b>positiveSign</b> = <b>false</b>, the negative cut-force is provided (= frame_b.f). </p>
<p>Via parameter <b>resolveInFrame</b> it is defined, in which frame the force vector is resolved: </p>
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
<p><br/><br/><br/>If resolveInFrame = Types.ResolveInFrameAB.frame_resolve, the conditional connector &QUOT;frame_resolve&QUOT; is enabled and output force is resolved in the frame, to which frame_resolve is connected. Note, if this connector is enabled, it must be connected. </p>
<p>In the following figure the modeling and animation of a CutForce sensor is shown.</p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/CutForce2.png\"/>                                                                <img src=\"modelica://PlanarMechanics/Resources/Images/CutForce.png\"/> </p>
</html>"));
end CutForce;
