within PlanarMechanics.VehicleComponents.Examples;
model TestDryFrictionWheel "Dry friction wheel"
  extends Modelica.Icons.Example;

  Joints.Prismatic prismatic(
    r={0,1},
    s(start=1, fixed=true),
    v(fixed=true))
                annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-10})));
  Joints.Revolute revolute(phi(fixed=true), w(fixed=true))
                           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-40})));
  Parts.Fixed fixed annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-70})));
  Modelica.Mechanics.Rotational.Sources.ConstantTorque engineTorque(
      tau_constant=2)
    annotation (Placement(transformation(extent={{-32,60},{-12,80}})));
  Parts.Body body(m=10, I=1)
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(
    phi(fixed=true, start=0),
    J=1,
    w(start=0, fixed=true)) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={0,60})));
  VehicleComponents.Wheels.DryFrictionWheelJoint dryFrictionWheelJoint(
    radius=0.3,
    r={1,0},
    N=100,
    vAdhesion=0.1,
    vSlide=0.3,
    mu_A=0.8,
    mu_S=0.4,
    w_roll(fixed=false, start=10))
              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,30})));
  inner PlanarWorld planarWorld(constantGravity={0,0})
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
equation
  connect(prismatic.frame_a, revolute.frame_b) annotation (Line(
      points={{0,-20},{0,-20},{0,-30}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute.frame_a, fixed.frame) annotation (Line(
      points={{0,-50},{0,-50},{0,-60}},
      color={95,95,95},
      thickness=0.5));
  connect(engineTorque.flange, inertia.flange_a) annotation (Line(
      points={{-12,70},{0,70}}));
  connect(body.frame_a, prismatic.frame_b) annotation (Line(
      points={{20,10},{0,10},{0,0}},
      color={95,95,95},
      thickness=0.5));
  connect(dryFrictionWheelJoint.frame_a, prismatic.frame_b) annotation (
      Line(
      points={{0,26},{0,0}},
      color={95,95,95},
      thickness=0.5));
  connect(dryFrictionWheelJoint.flange_a, inertia.flange_b) annotation (
      Line(
      points={{0,40},{0,40},{0,50}}));
  annotation (experiment(StopTime=20),
    Documentation(revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010-2020 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>",
      info="<html>
<div>
<img src=\"modelica://PlanarMechanics/Resources/Images/VehicleComponents/Examples/TestDryFrictionWheel_1.png\" alt=\"Diagram TestDryFrictionWheel_1\">
</div>
<div>
<img src=\"modelica://PlanarMechanics/Resources/Images/VehicleComponents/Examples/TestDryFrictionWheel_2.png\" alt=\"Diagram TestDryFrictionWheel_2\">
</div>
<p>Selected continuous time states</p>
<ul>
<li>inertia.phi</li>
<li>inertia.w</li>
<li>prismatic.s</li>
<li>prismatic.v</li>
<li>revolute.phi</li>
<li>revolute.w</li>
</ul>
</html>"));
end TestDryFrictionWheel;
