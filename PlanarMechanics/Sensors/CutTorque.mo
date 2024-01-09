within PlanarMechanics.Sensors;
model CutTorque "Measure cut torque"
  extends Internal.PartialCutTorqueSensor;

  Modelica.Blocks.Interfaces.RealOutput torque(
    final quantity = "Torque",
    final unit = "N.m")
    "Cut torque resolved in frame defined by resolveInFrame"
    annotation (Placement(transformation(
        origin={-80,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));

  parameter Boolean animation = true
    "= true, if animation shall be enabled (show arrow)";
  parameter Boolean positiveSign = true
    "= true, if torque with positive sign is returned (= frame_a.t), otherwise with negative sign (= frame_b.t)";

  input Real Nm_to_m(unit="N.m/m") = planarWorld.defaultNm_to_m
    "Torque arrow scaling (length = torque/Nm_to_m)"
    annotation (Dialog(group="if animation = true", enable=animation));
  input MB.Types.Color torqueColor = PlanarMechanics.Types.Defaults.TorqueColor
    "Color of torque arrow"
    annotation (HideResult=true, Dialog(colorSelector=true, group="if animation = true", enable=animation));
  input MB.Types.SpecularCoefficient specularCoefficient = planarWorld.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (HideResult=true, Dialog(group="if animation = true", enable=animation));

protected
  SI.Position t_in_m[3] = {0,0,frame_a.t}*(if positiveSign then +1 else -1)/Nm_to_m
    "Torque mapped from Nm to m for animation";
  MB.Visualizers.Advanced.Vector arrowTorque(
    coordinates=t_in_m,
    color=torqueColor,
    specularCoefficient=specularCoefficient,
    r=MB.Frames.resolve1(planarWorld.R, {frame_b.x,frame_b.y,0}) + planarWorld.r_0,
    quantity=MB.Types.VectorQuantity.Torque,
    headAtOrigin=true,
    R=planarWorld.R) if planarWorld.enableAnimation and animation;
    //R=Modelica.Mechanics.MultiBody.Frames.planarRotation({0,0,1},frame_b.phi,0),
  Internal.BasicCutTorque cutTorque(
    positiveSign=positiveSign)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
//   Interfaces.ZeroPosition zeroPosition if
//     not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve)
//     annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
equation
  connect(cutTorque.frame_a, frame_a) annotation (Line(
      points={{-10,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(cutTorque.frame_b, frame_b) annotation (Line(
      points={{10,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(cutTorque.torque, torque) annotation (Line(
      points={{-8,-11},{-8,-60},{-80,-60},{-80,-110}},
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
    Icon(
      coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,100}}),
      graphics={
        Text(
          extent={{-180,-72},{-64,-98}},
          textString="torque"),
        Line(
          points={{-80,-100},{-80,0}}, color={0,0,127})}),
    Documentation(
      revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>",
      info="<html>
<p>
The cut-torque acting between the two frames to which this model
is connected, is determined and provided at the output signal
connector <code>torque</code> (=&nbsp;<code>frame_a.t</code>).
If parameter <code>positiveSign&nbsp;= false</code>, the negative
cut-torque is provided (=&nbsp;<code>frame_b.t</code>).
</p>
<p>
In the following figure the modeling and animation of this
sensor is shown.
</p>
<div>
<img src=\"modelica://PlanarMechanics/Resources/Images/Sensors/CutTorque1.png\" alt=\"Modelica diagram\">
<br>
<img src=\"modelica://PlanarMechanics/Resources/Images/Sensors/CutTorque2.png\" alt=\"CutTorque2 animation\">
</div>
</html>"));
end CutTorque;
