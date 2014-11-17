within PlanarMechanics.Examples;
model ControlledCraneCrab "A controlled crane crab"
  extends Modelica.Icons.Example;

  Parts.Body body(
    m=70,
    I=0)   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,-60})));
  Parts.FixedTranslation fixedTranslation(r={0,2.5})
                                                    annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,-30})));
  Parts.Fixed fixed annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-70,30})));
  Parts.Body body1(
    m=250,
    I=0,
    a(start={1,0}))
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Mechanics.Translational.Sources.Force force annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-10,70})));
  Modelica.Blocks.Continuous.PID PID(
    Td=0.2,
    k=-320*9.81*5,
    initType=Modelica.Blocks.Types.InitPID.InitialState,
    xi_start=0,
    Ti=1e9) annotation (Placement(transformation(extent={{40,60},{20,80}})));
  inner PlanarWorld planarWorld
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  Joints.Prismatic prismatic(r={1,0}, useFlange=true,
    s(fixed=true),
    v(fixed=true))
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Joints.Revolute revolute(useFlange=true,
    w(fixed=true),
    phi(fixed=true, start=-0.34906585039887))
                                           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,0})));
equation
  connect(fixedTranslation.frame_b, body.frame_a) annotation (Line(
      points={{-10,-40},{-10,-45},{-10,-50}},
      color={95,95,95},
      thickness=0.5));
  connect(force.f, PID.y) annotation (Line(
      points={{2,70},{2,70},{19,70}},
      color={0,0,127}));
  connect(angleSensor.phi, PID.u) annotation (Line(
      points={{41,0},{70,0},{70,70},{42,70}},
      color={0,0,127}));

  connect(fixed.frame, prismatic.frame_a) annotation (Line(
      points={{-60,30},{-40,30}},
      color={95,95,95},
      thickness=0.5));
  connect(prismatic.frame_b, body1.frame_a) annotation (Line(
      points={{-20,30},{0,30}},
      color={95,95,95},
      thickness=0.5));
  connect(prismatic.flange_a, force.flange) annotation (Line(
      points={{-30,39},{-30,50},{-30,70},{-20,70}},
      color={0,127,0}));
  connect(prismatic.frame_b, revolute.frame_a) annotation (Line(
      points={{-20,30},{-10,30},{-10,10}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute.frame_b, fixedTranslation.frame_a) annotation (Line(
      points={{-10,-10},{-10,-20}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute.flange_a, angleSensor.flange) annotation (Line(
      points={{0,0},{10,0},{10,0},{20,0}}));
  annotation (experiment(StopTime=3),
    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p></html>",  info="<html>
<p>A simple PID (actually PD) controlles the pendulum into upright position.</p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/ControlledCraneCrab_1.png\"/></p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/ControlledCraneCrab_2.png\"/></p>
<p>Selected continuous time states</p>
<ul>
<li>actuatedPrismatic.s</li>
<li>actuatedPrismatic.v</li>
<li>actuatedRevolute.phi</li>
<li>actuatedRevolute.w</li>
<li>PID.D.x</li>
<li>PID.I.y</li>
</ul>
</html>"));
end ControlledCraneCrab;
