within PlanarMechanics.Examples;
model CounterSpin "Wheel with counter-spin and dry-friction law"
  extends Modelica.Icons.Example;

  Parts.Body body(
    m=0.01,
    I=0.0005,
    animate=false,
    r(each fixed=false),
    v(each fixed=false))
              annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-10,0})));
  inner PlanarWorld planarWorld
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Joints.DryFrictionBasedRolling slipBasedRolling(
    R=0.1,
    vAdhesion=0.01,
    mu_S=0.15,
    phi(fixed=true),
    w(fixed=true, start=15),
    vx(fixed=true, start=2),
    x(fixed=true),
    vSlide=0.03,
    mu_A=0.5) annotation (Placement(transformation(extent={{20,-10},{40,10}})));
equation
  connect(body.frame_a, slipBasedRolling.frame_a) annotation (Line(
      points={{0,0},{20,0}},
      color={95,95,95},
      thickness=0.5));
  annotation (experiment(StopTime=3),
    Documentation(revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010-2020 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>",  info="<html>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/Examples/CounterSpin_1.png\" alt=\"Diagram CounterSpin_1\"></p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/Examples/CounterSpin_2.png\" alt=\"Diagram CounterSpin_2\"></p>
<p>The model contains a large local stiffness before 2&nbsp;s</p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/Examples/CounterSpin_3.png\" alt=\"Diagram CounterSpin_3\"></p>
<p>Selected continuous time states</p>
<ul>
<li>body.r[1]</li>
<li>body.v[1]</li>
<li>slipBasedRolling.phi</li>
<li>slipBasedRolling.w</li>
</ul>
</html>"));
end CounterSpin;
