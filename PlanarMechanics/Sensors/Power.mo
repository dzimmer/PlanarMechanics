within PlanarMechanics.Sensors;
model Power "Measure power flowing from frame_a to frame_b"
  extends Modelica.Icons.RotationalSensor;
  extends PlanarMechanics.Interfaces.PartialTwoFrames;

  Modelica.Blocks.Interfaces.RealOutput power(
    final quantity = "Power",
    final unit = "W")
    "Power at frame_a as output signal"
    annotation (Placement(transformation(
      origin={-80,-110},
      extent={{10,-10},{-10,10}},
      rotation=90)));

equation
  //Connections.branch(frame_a.R, frame_b.R);
  //frame_a.r_0 = frame_b.r_0;
  {frame_a.x, frame_a.y} = {frame_b.x, frame_b.y};
  frame_a.phi = frame_b.phi;
  //frame_a.R = frame_b.R;
  zeros(2) = {frame_a.fx, frame_a.fy} + {frame_b.fx, frame_b.fy};
  0 = frame_a.t + frame_b.t;
  //power = frame_a.f*Frames.resolve2(frame_a.R, der(frame_a.r_0)) + frame_a.t*Frames.angularVelocity2(frame_a.R);
  power = {frame_a.fx, frame_a.fy} * der({frame_a.x, frame_a.y})
      + frame_a.t * der(frame_a.phi);

  annotation (
    Icon(
      coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
      graphics={
        Line(points={{-70,0},{-101,0}}),
        Line(points={{70,0},{100,0}}),
        Line(points={{-80,0},{-80,-100}}, color={0,0,127}),
        Text(
          extent={{-60,-92},{16,-114}},
          textString="power"),
        Text(
          extent={{-150,120},{150,80}},
          textString="%name",
          lineColor={0,0,255})}),
    Documentation(revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<b>Developed 2010-2020 at the DLR Institute of System Dynamics and Control</b>
</p>
</html>",  info="<HTML>
<p>
This component provides the power flowing from frame_a to frame_b
as output signal <b>power</b>.
</p>
</HTML>"));
end Power;
