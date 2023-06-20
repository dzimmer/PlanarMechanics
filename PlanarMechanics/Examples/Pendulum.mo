within PlanarMechanics.Examples;
model Pendulum "A free swinging pendulum"
  extends Modelica.Icons.Example;

  Parts.Body body(
    m=1,
    I=0.1)
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Joints.Revolute revolute(
    useFlange=true,
    phi(fixed=true, start=0),
    w(fixed=true, start=0))
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Parts.FixedTranslation fixedTranslation(r= {1,0})
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Parts.Fixed fixed(phi=0) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-60,0})));
  inner PlanarWorld planarWorld(defaultWidthFraction=10)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Mechanics.Rotational.Components.Damper damper(
    d=0.02)
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
equation
  connect(revolute.frame_b, fixedTranslation.frame_a) annotation (Line(
      points={{-20,0},{-15,0},{-10,0}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation.frame_b, body.frame_a) annotation (Line(
      points={{10,0},{10,0},{30,0}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute.frame_a, fixed.frame) annotation (Line(
      points={{-40,0},{-46,0},{-46,-1.22125e-015},{-50,-1.22125e-015}},
      color={95,95,95},
      thickness=0.5));
  connect(damper.flange_b, revolute.flange_a) annotation (Line(points={{-20,-40},{-20,-20},{-30,-20},{-30,-10}}));
  connect(revolute.support,damper. flange_a) annotation (Line(points={{-36,-10},{-36,-20},{-40,-20},{-40,-40}}));
  annotation (experiment(StopTime=3),
    Documentation(revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>",  info="<html>
<div>
<img src=\"modelica://PlanarMechanics/Resources/Images/Examples/Pendulum_1.png\" alt=\"Time domain diagram of pendulum's angle\">
</div>
<div>
<img src=\"modelica://PlanarMechanics/Resources/Images/Examples/Pendulum_2.png\" alt=\"Time domain diagram of pendulum's angular velocity and acceleration\">
</div>
<div>
<img src=\"modelica://PlanarMechanics/Resources/Images/Examples/Pendulum_3.png\" alt=\"Time domain diagram of pendulum's body position\">
</div>
<p>Selected continuous time states</p>
<ul>
  <li>revolute.phi</li>
  <li>revolute.w</li>
</ul>
</html>"));
end Pendulum;
