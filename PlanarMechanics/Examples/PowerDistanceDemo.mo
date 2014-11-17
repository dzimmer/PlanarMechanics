within PlanarMechanics.Examples;
model PowerDistanceDemo "Power and distance sensor demo"
    extends Modelica.Icons.Example;
  Parts.Body body(
    I=0.1,
    m=0.5) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,-90})));
  Parts.FixedTranslation fixedTranslation(r={0,-1}) annotation (
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
  inner PlanarWorld planarWorld
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  Parts.Damper damper(d=1)
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Joints.Revolute revolute(w(fixed=true), phi(fixed=true, start=2.6179938779915))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,0})));
  Joints.Prismatic prismatic(
    r={1,0},
    v(fixed=true),
    s(fixed=true, start=1.0))
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Sensors.Power power annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,-60})));
  Sensors.Distance distance
    annotation (Placement(transformation(extent={{2,62},{22,82}})));
equation
  connect(damper.frame_a, fixed.frame) annotation (Line(
      points={{-40,50},{-60,50},{-60,30}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute.frame_a, body1.frame_a) annotation (Line(
      points={{-10,10},{-10,30},{0,30}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute.frame_b, fixedTranslation.frame_a) annotation (Line(
      points={{-10,-10},{-10,-20}},
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
  connect(damper.frame_b, prismatic.frame_b) annotation (Line(
      points={{-20,50},{-10,50},{-10,30},{-20,30}},
      color={95,95,95},
      thickness=0.5));
  connect(body.frame_a, power.frame_b) annotation (Line(
      points={{-10,-80},{-10,-70}},
      color={95,95,95},
      thickness=0.5));
  connect(distance.frame_a, fixed.frame) annotation (Line(
      points={{2,72},{-60,72},{-60,30}},
      color={95,95,95},
      thickness=0.5));
  connect(distance.frame_b, power.frame_b) annotation (Line(
      points={{22,72},{58,72},{58,-70},{-10,-70}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation.frame_b, power.frame_a) annotation (Line(
      points={{-10,-40},{-10,-50}},
      color={95,95,95},
      thickness=0.5));
  annotation (experiment(StopTime=6),
    Documentation(info="<html>
<p>This example shows how to use sensors for power and distance. The crane crab is used as an example.</p>
</html>",
        revisions="<html>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p>
</html>"));
end PowerDistanceDemo;
