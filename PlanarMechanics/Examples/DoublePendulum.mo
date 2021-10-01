within PlanarMechanics.Examples;
model DoublePendulum
  "Simple double pendulum with two revolute joints and two bodies"
  extends Modelica.Icons.Example;

  Parts.Body body(
    m=1,
    I=0.1)
    annotation (Placement(transformation(extent={{0,10},{20,30}})));
  Parts.FixedTranslation fixedTranslation(r={1,0})
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  Parts.Fixed fixed annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-90,20})));
  Parts.Body body1(
    m=0.2,
    I=0.01)
    annotation (Placement(transformation(extent={{60,-30},{80,-10}})));
  Parts.FixedTranslation fixedTranslation1(r={0.4,0})
    annotation (Placement(transformation(extent={{30,-30},{50,-10}})));
  inner PlanarWorld planarWorld(enableAnimation=true,
    animateWorld=true,
    animateGravity=true)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Joints.Revolute revolute(phi(fixed=true, start=0), w(fixed=true, start=0),
    stateSelect=StateSelect.always)
    annotation (Placement(transformation(extent={{-70,10},{-50,30}})));
  Joints.Revolute revolute1(phi(fixed=true, start=0), w(fixed=true, start=0),
    stateSelect=StateSelect.always)
    annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
equation
  connect(fixedTranslation.frame_b, body.frame_a) annotation (Line(
      points={{-20,20},{0,20}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation1.frame_b, body1.frame_a)
                                                  annotation (Line(
      points={{50,-20},{50,-20},{60,-20}},
      color={95,95,95},
      thickness=0.5));
  connect(fixed.frame, revolute.frame_a) annotation (Line(
      points={{-80,20},{-76,20},{-70,20}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute.frame_b, fixedTranslation.frame_a) annotation (Line(
      points={{-50,20},{-40,20}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute1.frame_b, fixedTranslation1.frame_a) annotation (Line(
      points={{20,-20},{30,-20}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation.frame_b, revolute1.frame_a) annotation (Line(
      points={{-20,20},{-10,20},{-10,-20},{0,-20}},
      color={95,95,95},
      thickness=0.5));
  annotation (experiment(StopTime=10),
    Documentation(revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010-2020 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>",
      info="<html>
<p>Beware this is a chaotic system. However, the chaotic part should start after 10s.</p>
<div>
<img src=\"modelica://PlanarMechanics/Resources/Images/Examples/DoublePendulum_1.png\" alt=\"Diagram DoublePendulum_1\">
</div>
<div>
<img src=\"modelica://PlanarMechanics/Resources/Images/Examples/DoublePendulum_2.png\" alt=\"Diagram DoublePendulum_2\">
</div>
<p>Selected continuous time states</p>
<ul>
<li>revolute.phi</li>
<li>revolute.w</li>
<li>revolute1.phi</li>
<li>revolute1.w</li>
</ul>
</html>"));
end DoublePendulum;
