within PlanarMechanics.Examples;
model InvertedCraneCrab "An inverted model of a pendulum"
  extends Modelica.Icons.Example;

  Parts.Body body(
    I=0.1,
    m=0.5) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,-60})));
  Parts.FixedTranslation fixedTranslation(r={0,1})  annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,-30})));
  Parts.Fixed fixed annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-70,30})));
  Parts.Body body1(
    m=1,
    I=0.1)
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  Modelica.Mechanics.Translational.Sources.Force force(useSupport=false)
    annotation (Placement(transformation(extent={{0,60},{-20,80}})));
  Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor
    annotation (Placement(transformation(extent={{8,-10},{28,10}})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints
    annotation (Placement(transformation(extent={{38,-20},{88,20}})));
  Modelica.Blocks.Sources.Ramp ramp(
    startTime=0,
    duration=0.5,
    height=0.5,
    offset=-0.5)  annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=180,
        origin={74,0})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(initType=Modelica.Blocks.Types.Init.SteadyState,
      T=0.1) annotation (Placement(transformation(extent={{62,-6},{50,6}})));
  inner PlanarWorld planarWorld
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  Joints.Revolute revolute(useFlange=true) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,0})));
  Joints.Prismatic prismatic(useFlange=true, r={1,0},
    s(fixed=true),
    v(fixed=true))
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
equation
  connect(inverseBlockConstraints.u1, angleSensor.phi) annotation (Line(
      points={{35.5,0},{33.875,0},{33.875,0},{
          32.25,0},{32.25,0},{29,0}},
      color={0,0,127}));
  connect(inverseBlockConstraints.y1, force.f) annotation (Line(
      points={{89.25,0},{96,0},{96,70},{2,70}},
      color={0,0,127}));
  connect(fixedTranslation.frame_b, body.frame_a) annotation (Line(
      points={{-10,-40},{-10,-50}},
      color={95,95,95},
      thickness=0.5));
  connect(ramp.y, firstOrder.u) annotation (Line(
      points={{67.4,0},{64.7,0},{64.7,0},{63.2,
          0}},
      color={0,0,127}));
  connect(firstOrder.y, inverseBlockConstraints.u2) annotation (Line(
      points={{49.4,0},{47.8,0},{47.8,0},{46.2,
          0},{46.2,0},{43,0}},
      color={0,0,127}));

  connect(revolute.flange_a, angleSensor.flange)
    annotation (Line(points={{0,0},{4,0},{8,0}}));
  connect(revolute.frame_b, fixedTranslation.frame_a) annotation (Line(
      points={{-10,-10},{-10,-20}},
      color={95,95,95},
      thickness=0.5));

  connect(revolute.frame_a, body1.frame_a) annotation (Line(
      points={{-10,10},{-10,30},{0,30}},
      color={95,95,95},
      thickness=0.5));
  connect(fixed.frame, prismatic.frame_a) annotation (Line(
      points={{-60,30},{-40,30}},
      color={95,95,95},
      thickness=0.5));
  connect(prismatic.frame_b, body1.frame_a) annotation (Line(
      points={{-20,30},{0,30}},
      color={95,95,95},
      thickness=0.5));
  connect(force.flange, prismatic.flange_a) annotation (Line(
      points={{-20,70},{-30,70},{-30,39}},
      color={0,127,0}));
  annotation (Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p></html>",  info="<html>
<p>The trajectory is stipulated, the force is being measured.</p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/InvertedCraneCrab_1.png\"/></p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/InvertedCraneCrab_2.png\"/></p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/InvertedCraneCrab_3.png\"/></p>
<p>Selected continuous time states</p>
<ul>
<li>prismatic.s</li>
<li>prismatic.v</li>
<li>revolute.phi</li>
</ul>
</html>"),
    experiment(StopTime=3),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics));
end InvertedCraneCrab;
