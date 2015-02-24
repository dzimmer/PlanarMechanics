within PlanarMechanics.VehicleComponents.Examples;
model TestIdealWheel "Test an ideal wheel"
  extends Modelica.Icons.Example;

  VehicleComponents.Wheels.IdealWheelJoint idealWheelJoint(
    radius=0.3,
    r={1,0},
    animate=true)
             annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,30})));
  Joints.Prismatic prismatic(
    r={0,1}, s(start=1, fixed=true))
                annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-10})));
  Joints.Revolute revolute(
    phi(fixed=true),
    w(fixed=false),
    stateSelect=StateSelect.always)
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
  Parts.Body body(m=10, I=1,
    animate=false)
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(
    phi(fixed=true, start=0),
    w(fixed=true, start=0),
    J=1)                    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={0,60})));
  inner PlanarWorld planarWorld(enableAnimation=true, constantGravity={0,0})
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  inner MB.World world
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
equation
  connect(idealWheelJoint.frame_a, prismatic.frame_b) annotation (Line(
      points={{0,26},{0,0}},
      color={95,95,95},
      thickness=0.5));
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
  connect(inertia.flange_b, idealWheelJoint.flange_a) annotation (Line(
      points={{0,50},{0,40}}));
  connect(body.frame_a, prismatic.frame_b) annotation (Line(
      points={{20,10},{0,10},{0,0}},
      color={95,95,95},
      thickness=0.5));
  annotation (Documentation(revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/>
<b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b>
</p>
</html>",
      info="<html>
<p>It introduces one non-holonomic constraint. Difficult for index-reduction.</p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/TestIdealWheel_1.png\"></p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/TestIdealWheel_2.png\"></p>
<p>Selected continuous time states</p>
<ul>
<li>inertia.phi</li>
<li>prismatic.s</li>
<li>revolute.phi</li>
<li>revolute.w</li>
</ul>
</html>"),
    experiment(StopTime=10));
end TestIdealWheel;
