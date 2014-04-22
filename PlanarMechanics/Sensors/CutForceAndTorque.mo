within PlanarMechanics.Sensors;
model CutForceAndTorque "Measure cut force and cut torque vector"

  import SI = Modelica.SIunits;
  import Modelica.Mechanics.MultiBody.Types;

  Modelica.Blocks.Interfaces.RealOutput force[2](final quantity="Force", final unit="N")
    "Cut force resolved in frame defined by resolveInFrame"
       annotation (Placement(transformation(
        origin={-80,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Blocks.Interfaces.RealOutput torque
    "Cut torque resolved in frame defined by resolveInFrame"
       annotation (Placement(transformation(
        origin={0,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));

  parameter Boolean animation=true
    "= true, if animation shall be enabled (show force and torque arrow)";
  parameter Boolean positiveSign=true
    "= true, if force and torque with positive sign is returned (= frame_a.f/.t), otherwise with negative sign (= frame_b.f/.t)";
  input Real N_to_m(unit="N/m") = 1000
    "Force arrow scaling (length = force/N_to_m)"
    annotation (Dialog(group="if animation = true", enable=animation));
  input Real Nm_to_m(unit="N.m/m") = 1000
    "Torque arrow scaling (length = torque/Nm_to_m)"
    annotation (Dialog(group="if animation = true", enable=animation));
  input SI.Diameter forceDiameter=planarWorld.defaultArrowDiameter
    "Diameter of force arrow" annotation (Dialog(group="if animation = true", enable=animation));
  input SI.Diameter torqueDiameter=forceDiameter " Diameter of torque arrow"
                                annotation (Dialog(group="if animation = true", enable=animation));
  input Types.Color forceColor=Modelica.Mechanics.MultiBody.Types.Defaults.ForceColor
    "Color of force arrow"
    annotation (Dialog(group="if animation = true", enable=animation));
  input Types.Color torqueColor=Modelica.Mechanics.MultiBody.Types.Defaults.TorqueColor
    "Color of torque arrow"
    annotation (Dialog(group="if animation = true", enable=animation));
  input Modelica.Mechanics.MultiBody.Types.SpecularCoefficient specularCoefficient = planarWorld.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(group="if animation = true", enable=animation));

  extends Internal.PartialCutForceSensor;

protected
 inner Modelica.Mechanics.MultiBody.World world;
  parameter Integer csign=if positiveSign then +1 else -1;
  SI.Position f_in_m[3]={frame_a.fx, frame_a.fy, 0}*csign/N_to_m
    "Force mapped from N to m for animation";
  SI.Position t_in_m[3]={0,0,frame_a.t}*csign/Nm_to_m
    "Torque mapped from Nm to m for animation";
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Arrow forceArrow(
    diameter=forceDiameter,
    color=forceColor,
    specularCoefficient=specularCoefficient,
    r={frame_b.x, frame_b.y, 0},
    r_tail=f_in_m,
    r_head=-f_in_m) if planarWorld.enableAnimation and animation;
    //R=Modelica.Mechanics.MultiBody.Frames.planarRotation({0,0,1},frame_b.phi,0),
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.DoubleArrow torqueArrow(
    diameter=torqueDiameter,
    color=torqueColor,
    specularCoefficient=specularCoefficient,
    r={frame_b.x, frame_b.y, 0},
    r_tail=t_in_m,
    r_head=-t_in_m) if planarWorld.enableAnimation and animation;
    //R=Modelica.Mechanics.MultiBody.Frames.planarRotation({0,0,1},frame_b.phi,0),
  Internal.BasicCutForce cutForce(resolveInFrame=resolveInFrame, positiveSign=
        positiveSign)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Internal.BasicCutTorque cutTorque(positiveSign=positiveSign)
    annotation (Placement(transformation(extent={{-2,-10},{18,10}})));
  Interfaces.ZeroPosition zeroPosition if
    not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve)
    annotation (Placement(transformation(extent={{60,30},{80,50}})));
equation
  connect(cutForce.frame_a, frame_a) annotation (Line(
      points={{-60,5.88418e-16},{-70,5.88418e-16},{-70,9.21485e-16},{-80,
          9.21485e-16},{-80,3.33067e-16},{-100,3.33067e-16}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(cutForce.frame_b, cutTorque.frame_a) annotation (Line(
      points={{-40,5.88418e-16},{-30.5,5.88418e-16},{-30.5,1.17684e-15},{-21,
          1.17684e-15},{-21,5.88418e-16},{-2,5.88418e-16}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(cutTorque.frame_b, frame_b) annotation (Line(
      points={{18,5.88418e-16},{38.5,5.88418e-16},{38.5,9.21485e-16},{59,
          9.21485e-16},{59,3.33067e-16},{100,3.33067e-16}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(cutForce.force, force) annotation (Line(
      points={{-58,-11},{-58,-20},{-80,-20},{-80,-110}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(cutTorque.torque, torque) annotation (Line(
      points={{-4.44089e-16,-11},{-4.44089e-16,-35.75},{-9.99201e-16,-35.75},{
          -9.99201e-16,-60.5},{-5.55112e-16,-60.5},{-5.55112e-16,-110}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(zeroPosition.frame_resolve, cutForce.frame_resolve) annotation (Line(
      points={{60,40},{-26,40},{-26,-20},{-42,-20},{-42,-10}},
      color={95,95,95},
      pattern=LinePattern.Dot,
      smooth=Smooth.None));
  connect(cutForce.frame_resolve, frame_resolve) annotation (Line(
      points={{-42,-10},{-42,-70},{80,-70},{80,-100}},
      color={95,95,95},
      pattern=LinePattern.Dot,
      smooth=Smooth.None));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,
            100}}), graphics={
        Line(points={{-80,-100},{-80,0}}, color={0,0,127}),
        Line(points={{0,-100},{0,-70}}, color={0,0,127}),
        Text(
          extent={{-188,-70},{-72,-96}},
          lineColor={0,0,0},
          textString="force"),
        Text(
          extent={{-56,-70},{60,-96}},
          lineColor={0,0,0},
          textString="torque")}),
    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p></html>",  info="<HTML>
<p>
The cut-force and cut-torque acting between the two frames to which this
model is connected, are determined and provided at the output signal connectors
<b>force</b> (= frame_a.f) and <b>torque</b> (= frame_a.t).
If parameter <b>positiveSign</b> =
<b>false</b>, the negative cut-force and cut-torque is provided
(= frame_b.f, frame_b.t).

<p>
Via parameter <b>resolveInFrame</b> it is defined, in which frame
the two vectors are resolved:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>resolveInFrame =<br>Types.ResolveInFrameAB.</b></th><th><b>Meaning</b></th></tr>
<tr><td valign=\"top\">world</td>
    <td valign=\"top\">Resolve vectors in world frame</td></tr>

<tr><td valign=\"top\">frame_a</td>
    <td valign=\"top\">Resolve vectors in frame_a</td></tr>

<tr><td valign=\"top\">frame_b</td>
    <td valign=\"top\">Resolve vectors in frame_b</td></tr>

<tr><td valign=\"top\">frame_resolve</td>
    <td valign=\"top\">Resolve vectors in frame_resolve</td></tr>
</table>

<p>
If resolveInFrame = Types.ResolveInFrameAB.frame_resolve, the conditional connector
\"frame_resolve\" is enabled and the output vectors force and torque are resolved in the frame, to
which frame_resolve is connected. Note, if this connector is enabled, it must
be connected.
</p>

<p>
In the following figure the animation of a CutForceAndTorque
sensor is shown. The dark blue coordinate system is frame_b,
and the green arrows are the cut force and the cut torque,
respectively, acting at frame_b and
with negative sign at frame_a.
</p>

<IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Sensors/CutForceAndTorque.png\">
</HTML>"));
end CutForceAndTorque;
