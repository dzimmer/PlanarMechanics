within PlanarMechanics.Examples;
model MeasureDemo "Measure demo"
      extends Modelica.Icons.Example;

  Parts.Body body(
    m=1,
    I=0.1)
    annotation (Placement(transformation(extent={{10,10},{30,30}})));
  Parts.FixedTranslation fixedTranslation(r={1,0})
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  Parts.Fixed fixed annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-90,20})));
  Parts.Body body1(
    m=0.4,
    I=0.02)
    annotation (Placement(transformation(extent={{70,-30},{90,-10}})));
  Parts.FixedTranslation fixedTranslation1(r={0.4,0})
    annotation (Placement(transformation(extent={{30,-30},{50,-10}})));
  inner PlanarWorld planarWorld(enableAnimation=true,
    animateWorld=false,
    animateGravity=false)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Sensors.AbsolutePosition absolutePosition(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        origin={-10,-90})));
  Sensors.RelativePosition relativePosition(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.world)
    annotation (Placement(transformation(extent={{40,82},{60,102}})));
  Joints.Revolute revolute1(phi(fixed=true), w(fixed=true))
    annotation (Placement(transformation(extent={{-70,10},{-50,30}})));
  Sensors.AbsoluteVelocity absoluteVelocity(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a)
    annotation (Placement(transformation(extent={{20,-80},{0,-60}})));
  Sensors.RelativeVelocity relativeVelocity(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_b)
    annotation (Placement(transformation(extent={{20,62},{40,82}})));
  Sensors.AbsoluteAcceleration absoluteAcceleration(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        origin={30,-50})));
  Sensors.RelativeAcceleration relativeAcceleration(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_b)
    annotation (Placement(transformation(extent={{0,42},{20,62}})));
  Joints.Revolute revolute2(phi(fixed=true), w(fixed=true))
    annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
equation
  connect(fixedTranslation.frame_b,body. frame_a) annotation (Line(
      points={{-20,20},{-2,20},{10,20}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation1.frame_b,body1. frame_a)
                                                  annotation (Line(
      points={{50,-20},{56,-20},{70,-20}},
      color={95,95,95},
      thickness=0.5));
  connect(fixed.frame, revolute1.frame_a) annotation (Line(
      points={{-80,20},{-70,20}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute1.frame_b, fixedTranslation.frame_a) annotation (Line(
      points={{-50,20},{-40,20}},
      color={95,95,95},
      thickness=0.5));
  connect(absoluteAcceleration.frame_resolve, absoluteAcceleration.frame_a)
    annotation (Line(
      points={{30,-60},{30,-50},{40,-50}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(revolute2.frame_b, fixedTranslation1.frame_a) annotation (Line(
      points={{20,-20},{20,-20},{30,-20}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute2.frame_a, fixedTranslation.frame_b) annotation (Line(
      points={{0,-20},{-10,-20},{-10,20},{-20,20},{-20,20}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation.frame_b, relativeAcceleration.frame_a) annotation (
      Line(
      points={{-20,20},{-20,20},{-10,20},{-10,52},{0,52}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation.frame_b, relativeVelocity.frame_a) annotation (Line(
      points={{-20,20},{-20,20},{-10,20},{-10,72},{20,72}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation.frame_b, relativePosition.frame_a) annotation (Line(
      points={{-20,20},{-20,20},{-10,20},{-10,92},{40,92}},
      color={95,95,95},
      thickness=0.5));
  connect(relativeAcceleration.frame_b, body1.frame_a) annotation (Line(
      points={{20,52},{60,52},{60,-20},{70,-20}},
      color={95,95,95},
      thickness=0.5));
  connect(relativeVelocity.frame_b, body1.frame_a) annotation (Line(
      points={{40,72},{60,72},{60,-20},{70,-20}},
      color={95,95,95},
      thickness=0.5));
  connect(relativePosition.frame_b, body1.frame_a) annotation (Line(
      points={{60,92},{60,36},{60,-20},{70,-20}},
      color={95,95,95},
      thickness=0.5));
  connect(body1.frame_a, absoluteAcceleration.frame_a) annotation (Line(
      points={{70,-20},{70,-20},{60,-20},{60,-50},{40,-50}},
      color={95,95,95},
      thickness=0.5));
  connect(body1.frame_a, absoluteVelocity.frame_a) annotation (Line(
      points={{70,-20},{70,-20},{60,-20},{60,-70},{20,-70}},
      color={95,95,95},
      thickness=0.5));
  connect(body1.frame_a, absolutePosition.frame_a) annotation (Line(
      points={{70,-20},{70,-20},{60,-20},{60,-90},{0,-90}},
      color={95,95,95},
      thickness=0.5));
  annotation (experiment(StopTime=10),
    Documentation(info="<html>
<p>This example shows how to use absolute and relative sensors for position, velocity and acceleration. For demonstration purposes a double pendulum is used.</p>
</html>",
        revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010-2020 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>"));
end MeasureDemo;
