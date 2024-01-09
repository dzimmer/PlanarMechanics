within PlanarMechanics.Sensors;
model CutForceAndTorque "Measure cut force vector and cut torque"

  import Modelica.Mechanics.MultiBody.Types;

  Modelica.Blocks.Interfaces.RealOutput force[2](
    each final quantity = "Force",
    each final unit = "N")
    "Cut force resolved in frame defined by resolveInFrame"
    annotation (Placement(transformation(
        origin={-80,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Blocks.Interfaces.RealOutput torque(
    final quantity = "Torque",
    final unit = "N.m")
    "Cut torque resolved in frame defined by resolveInFrame"
    annotation (Placement(transformation(
        origin={0,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));

  parameter Boolean animation = true
    "= true, if animation shall be enabled (show force and torque arrow)";
  parameter Boolean positiveSign = true
    "= true, if force and torque with positive sign is returned (= frame_a.f/.t), otherwise with negative sign (= frame_b.f/.t)";

  input Real N_to_m(unit="N/m") = planarWorld.defaultN_to_m
    "Force arrow scaling (length = force/N_to_m)"
    annotation (Dialog(group="if animation = true", enable=animation));
  input Real Nm_to_m(unit="N.m/m") = planarWorld.defaultNm_to_m
    "Torque arrow scaling (length = torque/Nm_to_m)"
    annotation (Dialog(group="if animation = true", enable=animation));
  input MB.Types.Color forceColor = PlanarMechanics.Types.Defaults.ForceColor
    "Color of force arrow"
    annotation (HideResult=true, Dialog(colorSelector=true, group="if animation = true", enable=animation));
  input MB.Types.Color torqueColor = PlanarMechanics.Types.Defaults.TorqueColor
    "Color of torque arrow"
    annotation (HideResult=true, Dialog(colorSelector=true, group="if animation = true", enable=animation));
  input MB.Types.SpecularCoefficient specularCoefficient = planarWorld.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (HideResult=true, Dialog(group="if animation = true", enable=animation));

  extends Internal.PartialCutForceSensor;

protected
  parameter Integer csign=if positiveSign then +1 else -1;
  SI.Position f_in_m[3]={frame_a.fx, frame_a.fy, 0}*csign/N_to_m
    "Force mapped from N to m for animation";
  SI.Position t_in_m[3]={0,0,frame_a.t}*csign/Nm_to_m
    "Torque mapped from Nm to m for animation";
  MB.Visualizers.Advanced.Vector arrowForce(
    coordinates=f_in_m,
    color=forceColor,
    specularCoefficient=specularCoefficient,
    r=MB.Frames.resolve1(planarWorld.R, {frame_b.x,frame_b.y,0}) + planarWorld.r_0,
    quantity=MB.Types.VectorQuantity.Force,
    headAtOrigin=true,
    R=planarWorld.R) if planarWorld.enableAnimation and animation;
  MB.Visualizers.Advanced.Vector arrowTorque(
    coordinates=t_in_m,
    color=torqueColor,
    specularCoefficient=specularCoefficient,
    r=MB.Frames.resolve1(planarWorld.R, {frame_b.x,frame_b.y,0}) + planarWorld.r_0,
    quantity=MB.Types.VectorQuantity.Torque,
    headAtOrigin=true,
    R=planarWorld.R) if planarWorld.enableAnimation and animation;
    //R=Modelica.Mechanics.MultiBody.Frames.planarRotation({0,0,1},frame_b.phi,0),
  Internal.BasicCutForce cutForce(
    resolveInFrame=resolveInFrame,
    positiveSign=positiveSign)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Internal.BasicCutTorque cutTorque(
    positiveSign=positiveSign)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Interfaces.ZeroPosition zeroPosition
    if not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve)
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
equation
  connect(cutForce.frame_a, frame_a) annotation (Line(
      points={{-60,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(cutForce.frame_b, cutTorque.frame_a) annotation (Line(
      points={{-40,0},{40,0}},
      color={95,95,95},
      thickness=0.5));
  connect(cutTorque.frame_b, frame_b) annotation (Line(
      points={{60,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(cutForce.force, force) annotation (Line(
      points={{-58,-11},{-58,-60},{-80,-60},{-80,-110}},
      color={0,0,127}));
  connect(cutTorque.torque, torque) annotation (Line(
      points={{42,-11},{42,-79.75},{0,-79.75},{0,-110}},
      color={0,0,127}));
  connect(zeroPosition.frame_resolve, cutForce.frame_resolve) annotation (Line(
      points={{-20,-30},{-42,-30},{-42,-10}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(cutForce.frame_resolve, frame_resolve) annotation (Line(
      points={{-42,-10},{-42,-60},{80,-60},{80,-100}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  annotation (
    Icon(
      coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,100}}),
      graphics={
        Line(points={{-80,-100},{-80,0}}, color={0,0,127}),
        Line(points={{0,-100},{0,-70}}, color={0,0,127}),
        Text(
          extent={{-188,-70},{-72,-96}},
          textString="force"),
        Text(
          extent={{-56,-70},{60,-96}},
          textString="torque")}),
    Documentation(revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>",  info="<html>
<p>
The cut-force and cut-torque acting between the two frames to which this
model is connected, are determined and provided at the output signal connectors
<code>force</code> (=&nbsp;<code>frame_a.f</code>) and <code>torque</code>
(=&nbsp;<code>frame_a.t</code>).
If parameter <code>positiveSign&nbsp;= false</code>, the negative
cut-force and cut-torque is provided (=&nbsp;<code>frame_b.f</code>, <code>frame_b.t</code>).
</p>
<p>
Via parameter <code>resolveInFrame</code> it is defined, in which frame
the <code>force</code> vector is resolved.
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\">Options of parameter <strong>resolveInFrame</strong></caption>
  <tr>
    <th>resolveInFrame = &hellip;</th>
    <th>Force vector resolved in</th>
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
the conditional connector <code>frame_resolve</code> is enabled and
output <code>force</code> is resolved in the frame, to which
<code>frame_resolve</code> is connected.
Note, if this connector is enabled, it must be connected.
</p>

<p>
In the following figure the animation of the
sensor is shown. The dark blue coordinate system is <code>frame_b</code>,
and the green arrows are the cut force and the cut torque,
respectively, acting at <code>frame_b</code> and
with negative sign at <code>frame_a</code>.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Sensors/CutForceAndTorque.png\" alt=\"CutForceAndTorque animation\">
</div>
</html>"));
end CutForceAndTorque;
