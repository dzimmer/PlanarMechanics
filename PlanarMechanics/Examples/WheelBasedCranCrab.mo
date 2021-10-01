within PlanarMechanics.Examples;
model WheelBasedCranCrab "A pendulum mounted on an ideal rolling wheel"
  extends Modelica.Icons.Example;
  Joints.IdealRolling idealRolling(
    R=0.3,
    phi(fixed=true),
    w(fixed=true),
    x(fixed=true, start=0))               annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,50})));
  Parts.Body body(
    m=1,
    I=0.1)
    annotation (Placement(transformation(extent={{10,20},{30,40}})));
  Joints.Revolute revolute(phi(fixed=true, start=1.3962634015955), w(fixed=true))
                           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,10})));
  Parts.FixedTranslation fixedTranslation(r={1,0}) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,-20})));
  Parts.Body body1(
    m=2,
    I=0.2)       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,-50})));
  inner PlanarWorld planarWorld(defaultWidthFraction=10, defaultZPosition=0)
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
equation
  connect(revolute.frame_a, idealRolling.frame_a) annotation (Line(
      points={{-20,20},{-20,40}},
      color={95,95,95},
      thickness=0.5));
  connect(body.frame_a, idealRolling.frame_a) annotation (Line(
      points={{10,30},{-20,30},{-20,40}},
      color={95,95,95},
      thickness=0.5));
  connect(body1.frame_a, fixedTranslation.frame_b) annotation (Line(
      points={{-20,-40},{-20,-35},{-20,-30}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation.frame_a, revolute.frame_b) annotation (Line(
      points={{-20,-10},{-20,0}},
      color={95,95,95},
      thickness=0.5));
  annotation (experiment(StopTime=4.5),
    Documentation(revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010-2020 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>",
      info="<html>
<p>This model contains non-holonomic constraints.</p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/Examples/WheelBasedCranCrab_1.png\" alt=\"Diagram WheelBasedCranCrab_1\"></p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/Examples/WheelBasedCranCrab_2.png\" alt=\"Diagram WheelBasedCranCrab_2\"></p>
<p>Selected continuous time states</p>
<ul>
<li>body1.frame_a.phi</li>
<li>body1.r[1]</li>
<li>body1.w</li>
<li>revolute.phi</li>
<li>revolute.w</li>
</ul>
</html>"));
end WheelBasedCranCrab;
