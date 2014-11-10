within PlanarMechanics.Sensors;
model CutTorque "Measure cut torque vector"
  extends Internal.PartialCutTorqueSensor;

  import SI = Modelica.SIunits;

  Modelica.Blocks.Interfaces.RealOutput torque
    "Cut torque resolved in frame defined by resolveInFrame"
       annotation (Placement(transformation(
        origin={-80,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));

  parameter Boolean animation=true
    "= true, if animation shall be enabled (show arrow)";
  parameter Boolean positiveSign=true
    "= true, if torque with positive sign is returned (= frame_a.t), otherwise with negative sign (= frame_b.t)";
  input Real Nm_to_m(unit="N.m/m") = 1000
    "Torque arrow scaling (length = torque/Nm_to_m)"
    annotation (Dialog(group="if animation = true", enable=animation));
  input SI.Diameter torqueDiameter=planarWorld.defaultArrowDiameter
    "Diameter of torque arrow" annotation (Dialog(group="if animation = true", enable=animation));
  input Types.Color torqueColor=Modelica.Mechanics.MultiBody.Types.Defaults.TorqueColor
    "Color of torque arrow"
    annotation (Dialog(group="if animation = true", enable=animation));
  input Modelica.Mechanics.MultiBody.Types.SpecularCoefficient specularCoefficient = planarWorld.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(group="if animation = true", enable=animation));

protected
 inner Modelica.Mechanics.MultiBody.World world;
  SI.Position t_in_m[3]={0,0,frame_a.t}*(if positiveSign then +1 else -1)/Nm_to_m
    "Torque mapped from Nm to m for animation";
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.DoubleArrow torqueArrow(
    diameter=torqueDiameter,
    color=torqueColor,
    specularCoefficient=specularCoefficient,
    r={frame_b.x, frame_b.y, 0},
    r_tail=t_in_m,
    r_head=-t_in_m) if planarWorld.enableAnimation and animation;
    //R=Modelica.Mechanics.MultiBody.Frames.planarRotation({0,0,1},frame_b.phi,0),
  Internal.BasicCutTorque cutTorque(positiveSign=
       positiveSign)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
//   Interfaces.ZeroPosition zeroPosition if
//     not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve)
//     annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
equation
  connect(cutTorque.frame_a, frame_a) annotation (Line(
      points={{-50,0},{-71.5,0},{-81,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(cutTorque.frame_b, frame_b) annotation (Line(
      points={{-30,0},{-6.5,0},{29,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(cutTorque.torque, torque) annotation (Line(
      points={{-48,-11},{-48,-60},{-80,-60},{-80,-110}},
      color={0,0,127}));
//   connect(cutTorque.frame_resolve, frame_resolve) annotation (Line(
//       points={{-44,-10},{-44,-74},{80,-74},{80,-100}},
//       color={95,95,95},
//       pattern=LinePattern.Dot,
//       ));
//  connect(zeroPosition.frame_resolve, cutTorque.frame_resolve) annotation (Line(
//       points={{-20,-30},{-44,-30},{-44,-10}},
//       color={95,95,95},
//       pattern=LinePattern.Dot,
//       ));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,
            100}}), graphics={Text(
          extent={{-180,-72},{-64,-98}},
          textString="torque"), Line(points={{-80,-100},{-80,0}}, color={0,0,
              127})}),
    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p></html>",  info="<html>
<p>The cut-torque acting between the two frames to which this model is connected, is determined and provided at the output signal connector <b>torque</b> (= frame_a.t). If parameter <b>positiveSign</b> = <b>false</b>, the negative cut-torque is provided (= frame_b.t).</p>
<p>Via parameter <b>resolveInFrame</b> it is defined, in which frame the torque vector is resolved: </p>
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
<p>If <code>resolveInFrame = Types.ResolveInFrameAB.frame_resolve</code>, the conditional connector &quot;frame_resolve&quot; is enabled and output torque is resolved in the frame, to which frame_resolve is connected. Note, if this connector is enabled, it must be connected.</p>
<p>In the following figure the modeling and animation of a CutTorque sensor is shown.</p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/CutTorque1.png\"/>
<img src=\"modelica://PlanarMechanics/Resources/Images/CutTorque2.png\"/></p>
</html>"));
end CutTorque;
