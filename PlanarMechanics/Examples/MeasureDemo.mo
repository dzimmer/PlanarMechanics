within PlanarMechanics.Examples;
model MeasureDemo
      extends Modelica.Icons.Example;

  Parts.Body body(
    m=1,
    I=0.1)
    annotation (Placement(transformation(extent={{20,10},{40,30}})));
  Parts.FixedTranslation fixedTranslation(r={1,0})
    annotation (Placement(transformation(extent={{-24,10},{-4,30}})));
  Parts.Fixed fixed annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-90,20})));
  Parts.Body body1(
    m=0.4,
    I=0.02)
    annotation (Placement(transformation(extent={{60,-30},{80,-10}})));
  Parts.FixedTranslation fixedTranslation1(r={0.4,0})
    annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
  inner PlanarWorld planarWorld(enableAnimation=true,
    animateWorld=false,
    animateGravity=false)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Sensors.AbsolutePosition absolutePosition(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-10,-90})));
  Sensors.RelativePosition relativePosition(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.world)
    annotation (Placement(transformation(extent={{40,82},{60,102}})));
  Joints.Revolute revolute1(phi(fixed=true), w(fixed=true))
    annotation (Placement(transformation(extent={{-56,10},{-36,30}})));
  Sensors.AbsoluteVelocity absoluteVelocity(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a)
    annotation (Placement(transformation(extent={{20,-80},{0,-60}})));
  Sensors.RelativeVelocity relativeVelocity(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_b)
    annotation (Placement(transformation(extent={{20,62},{40,82}})));
  Sensors.AbsoluteAcceleration absoluteAcceleration(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={30,-50})));
  Sensors.RelativeAcceleration relativeAcceleration(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_b)
    annotation (Placement(transformation(extent={{0,42},{20,62}})));
  Joints.Revolute revolute2(phi(fixed=true), w(fixed=true))
    annotation (Placement(transformation(extent={{-14,-30},{6,-10}})));
equation
  connect(fixedTranslation.frame_b,body. frame_a) annotation (Line(
      points={{-4,20},{20,20}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(fixedTranslation1.frame_b,body1. frame_a)
                                                  annotation (Line(
      points={{40,-20},{60,-20}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(fixed.frame_a, revolute1.frame_a) annotation (Line(
      points={{-80,20},{-56,20}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(revolute1.frame_b, fixedTranslation.frame_a) annotation (Line(
      points={{-36,20},{-24,20}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(absoluteAcceleration.frame_resolve, absoluteAcceleration.frame_a)
    annotation (Line(
      points={{30,-60},{30,-50},{40,-50}},
      color={95,95,95},
      pattern=LinePattern.Dot,
      smooth=Smooth.None));
  connect(revolute2.frame_b, fixedTranslation1.frame_a) annotation (Line(
      points={{6,-20},{20,-20}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(revolute2.frame_a, fixedTranslation.frame_b) annotation (Line(
      points={{-14,-20},{-28,-20},{-28,0},{-4,0},{-4,20}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(fixedTranslation.frame_b, relativeAcceleration.frame_a) annotation (
      Line(
      points={{-4,20},{-4,52},{0,52}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(fixedTranslation.frame_b, relativeVelocity.frame_a) annotation (Line(
      points={{-4,20},{-4,72},{20,72}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(fixedTranslation.frame_b, relativePosition.frame_a) annotation (Line(
      points={{-4,20},{-4,92},{40,92}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(relativeAcceleration.frame_b, body1.frame_a) annotation (Line(
      points={{20,52},{60,52},{60,-20}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(relativeVelocity.frame_b, body1.frame_a) annotation (Line(
      points={{40,72},{60,72},{60,-20}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(relativePosition.frame_b, body1.frame_a) annotation (Line(
      points={{60,92},{60,-20}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(body1.frame_a, absoluteAcceleration.frame_a) annotation (Line(
      points={{60,-20},{60,-50},{40,-50}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(body1.frame_a, absoluteVelocity.frame_a) annotation (Line(
      points={{60,-20},{60,-70},{20,-70}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(body1.frame_a, absolutePosition.frame_a) annotation (Line(
      points={{60,-20},{60,-90},{0,-90}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (experiment(StopTime=10),
    Documentation(info="<html>
<p><h4><font color=\"#008000\">Measure Demo</font></h4></p>
<p>This example shows how to use absolute and relative sensors for position, velocity and acceleration. For demonstration purposes a double pendulum is used.</p>
</html>"));
end MeasureDemo;
