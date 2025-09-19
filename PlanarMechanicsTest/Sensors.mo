within PlanarMechanicsTest;
package Sensors "Test models for PlanarMechanics.Sensors"
  extends Modelica.Icons.Package;
  model PositionDistance "Test absolute and relative position sensors and distance sensor, resolved in different frames"
    extends Modelica.Icons.Example;

    PlanarMechanics.Sensors.Distance distance annotation (Placement(transformation(extent={{-20,40},{0,60}})));
    PlanarMechanics.Sensors.AbsolutePosition absolutePosition(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world)
      annotation (Placement(transformation(extent={{40,10},{60,30}})));
    PlanarMechanics.Sensors.AbsolutePosition absolutePosition1(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a)
      annotation (Placement(transformation(extent={{40,-20},{60,0}})));
    PlanarMechanics.Sensors.AbsolutePosition absolutePosition3(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve)
      annotation (Placement(transformation(extent={{40,-80},{60,-60}})));
    PlanarMechanics.Sensors.RelativePosition relativePosition(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.world)
      annotation (Placement(transformation(extent={{-20,10},{0,30}})));
    PlanarMechanics.Sensors.RelativePosition relativePosition1(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a)
      annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
    PlanarMechanics.Sensors.RelativePosition relativePosition2(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_b)
      annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
    PlanarMechanics.Sensors.RelativePosition relativePosition3(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve)
      annotation (Placement(transformation(extent={{-20,-60},{0,-80}})));
    inner PlanarMechanics.PlanarWorld planarWorld annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
    PlanarMechanics.Parts.Body body(m=1, I=1) annotation (Placement(transformation(extent={{40,70},{60,90}})));
    PlanarMechanics.Joints.Prismatic prismatic(
      r={1,0},
      s(fixed=true, start=0.5),
      v(fixed=true, start=-1)) annotation (Placement(transformation(extent={{-20,70},{0,90}})));
    PlanarMechanics.Parts.Fixed fixed annotation (Placement(transformation(extent={{-60,70},{-80,90}})));
    PlanarMechanics.Parts.Fixed fixed1(
      r={0.65,0.4},
      phi=0.5235987755983)
      annotation (Placement(transformation(extent={{80,40},{100,60}})));
    PlanarMechanics.Sensors.Distance distance1
      annotation (Placement(transformation(extent={{60,40},{40,60}})));
    PlanarMechanics.Parts.Fixed fixedRotated(
      r={0,-1},
      phi=0.29670597283904) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={-50,-90})));
  equation
    connect(fixed.frame, prismatic.frame_a) annotation (Line(
        points={{-60,80},{-20,80}},
        color={95,95,95},
        thickness=0.5));
    connect(prismatic.frame_b, body.frame_a) annotation (Line(
        points={{0,80},{40,80}},
        color={95,95,95},
        thickness=0.5));
    connect(fixed.frame, relativePosition.frame_a) annotation (Line(
        points={{-60,80},{-40,80},{-40,20},{-20,20}},
        color={95,95,95},
        thickness=0.5));
    connect(relativePosition.frame_b, body.frame_a) annotation (Line(
        points={{0,20},{20,20},{20,80},{40,80}},
        color={95,95,95},
        thickness=0.5));
    connect(fixed.frame, distance.frame_a) annotation (Line(
        points={{-60,80},{-40,80},{-40,50},{-20,50}},
        color={95,95,95},
        thickness=0.5));
    connect(distance.frame_b, body.frame_a) annotation (Line(
        points={{0,50},{20,50},{20,80},{40,80}},
        color={95,95,95},
        thickness=0.5));
    connect(absolutePosition.frame_a, body.frame_a) annotation (Line(
        points={{40,20},{20,20},{20,80},{40,80}},
        color={95,95,95},
        thickness=0.5));

    connect(distance1.frame_b, body.frame_a) annotation (Line(
        points={{40,50},{20,50},{20,80},{40,80}},
        color={95,95,95},
        thickness=0.5));
    connect(fixed1.frame, distance1.frame_a) annotation (Line(
        points={{80,50},{60,50}},
        color={95,95,95},
        thickness=0.5));
    connect(fixed.frame, relativePosition1.frame_a) annotation (Line(
        points={{-60,80},{-40,80},{-40,-10},{-20,-10}},
        color={95,95,95},
        thickness=0.5));
    connect(relativePosition1.frame_b, body.frame_a) annotation (Line(
        points={{0,-10},{20,-10},{20,80},{40,80}},
        color={95,95,95},
        thickness=0.5));
    connect(absolutePosition1.frame_a, body.frame_a) annotation (Line(
        points={{40,-10},{20,-10},{20,80},{40,80}},
        color={95,95,95},
        thickness=0.5));
    connect(fixed.frame, relativePosition2.frame_a) annotation (Line(
        points={{-60,80},{-40,80},{-40,-40},{-20,-40}},
        color={95,95,95},
        thickness=0.5));
    connect(relativePosition2.frame_b, body.frame_a) annotation (Line(
        points={{0,-40},{20,-40},{20,80},{40,80}},
        color={95,95,95},
        thickness=0.5));
    connect(absolutePosition3.frame_a, body.frame_a) annotation (Line(
        points={{40,-70},{20,-70},{20,80},{40,80}},
        color={95,95,95},
        thickness=0.5));
    connect(fixed.frame, relativePosition3.frame_a) annotation (Line(
        points={{-60,80},{-40,80},{-40,-70},{-20,-70}},
        color={95,95,95},
        thickness=0.5));
    connect(relativePosition3.frame_b, body.frame_a) annotation (Line(
        points={{0,-70},{20,-70},{20,80},{40,80}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedRotated.frame, relativePosition3.frame_resolve) annotation (Line(
        points={{-40,-90},{0,-90},{0,-78.1}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedRotated.frame, absolutePosition3.frame_resolve) annotation (Line(
        points={{-40,-90},{50,-90},{50,-80}},
        color={95,95,95},
        thickness=0.5));
    annotation (experiment(StopTime=1));
  end PositionDistance;

  model VelocityResolveInFrame "Test absolute and relative velocity sensors, resolved in different frames"
    extends Modelica.Icons.Example;

    PlanarMechanics.Sensors.AbsoluteVelocity absoluteVelocity(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world)
      annotation (Placement(transformation(extent={{50,20},{70,40}})));
    PlanarMechanics.Sensors.AbsoluteVelocity absoluteVelocity1(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a)
      annotation (Placement(transformation(extent={{50,-10},{70,10}})));
    PlanarMechanics.Sensors.AbsoluteVelocity absoluteVelocity2(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve)
      annotation (Placement(transformation(extent={{50,-70},{70,-50}})));
    PlanarMechanics.Sensors.RelativeVelocity relativeVelocity(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.world)
      annotation (Placement(transformation(extent={{-10,20},{10,40}})));
    PlanarMechanics.Sensors.RelativeVelocity relativeVelocity1(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    PlanarMechanics.Sensors.RelativeVelocity relativeVelocity2(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_b)
      annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
    PlanarMechanics.Sensors.RelativeVelocity relativeVelocity3(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve)
      annotation (Placement(transformation(extent={{-10,-50},{10,-70}})));
    inner PlanarMechanics.PlanarWorld planarWorld(constantGravity={0,0})
      annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
    PlanarMechanics.Parts.Body body(
      m=1,
      I=1,
      r(each fixed=true, start={0.02,0.6}),
      v(each fixed=true, start={0.14,-0.75}),
      phi(fixed=true, start=-0.87266462599716),
      w(fixed=true, start=0.3)) annotation (Placement(transformation(extent={{50,50},{70,70}})));
    PlanarMechanics.Parts.Fixed fixed annotation (Placement(transformation(extent={{-50,50},{-70,70}})));
    PlanarMechanics.Parts.Fixed fixedRotated(
      r={0,-1},
      phi=0.29670597283904) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={-40,-80})));
    PlanarMechanics.Parts.SpringDamper springDamper(
      c_x=1,
      c_y=1,
      c_phi=1,
      d_x=0.1,
      d_y=0.1,
      d_phi=0.1,
      s_relx0=0.1) annotation (Placement(transformation(extent={{-20,50},{0,70}})));
    PlanarMechanics.Parts.FixedTranslation fixedTranslation(r={0.13,0.22}) annotation (Placement(transformation(extent={{12,50},{32,70}})));
  equation
    connect(fixed.frame, relativeVelocity.frame_a) annotation (Line(
        points={{-50,60},{-30,60},{-30,30},{-10,30}},
        color={95,95,95},
        thickness=0.5));
    connect(relativeVelocity.frame_b, body.frame_a) annotation (Line(
        points={{10,30},{40,30},{40,60},{50,60}},
        color={95,95,95},
        thickness=0.5));
    connect(absoluteVelocity.frame_a, body.frame_a) annotation (Line(
        points={{50,30},{40,30},{40,60},{50,60}},
        color={95,95,95},
        thickness=0.5));
    connect(fixed.frame, relativeVelocity1.frame_a) annotation (Line(
        points={{-50,60},{-30,60},{-30,0},{-10,0}},
        color={95,95,95},
        thickness=0.5));
    connect(relativeVelocity1.frame_b, body.frame_a) annotation (Line(
        points={{10,0},{40,0},{40,60},{50,60}},
        color={95,95,95},
        thickness=0.5));
    connect(absoluteVelocity1.frame_a, body.frame_a) annotation (Line(
        points={{50,0},{40,0},{40,60},{50,60}},
        color={95,95,95},
        thickness=0.5));
    connect(fixed.frame, relativeVelocity2.frame_a) annotation (Line(
        points={{-50,60},{-30,60},{-30,-30},{-10,-30}},
        color={95,95,95},
        thickness=0.5));
    connect(relativeVelocity2.frame_b, body.frame_a) annotation (Line(
        points={{10,-30},{40,-30},{40,60},{50,60}},
        color={95,95,95},
        thickness=0.5));
    connect(absoluteVelocity2.frame_a, body.frame_a) annotation (Line(
        points={{50,-60},{40,-60},{40,60},{50,60}},
        color={95,95,95},
        thickness=0.5));
    connect(fixed.frame, relativeVelocity3.frame_a) annotation (Line(
        points={{-50,60},{-30,60},{-30,-60},{-10,-60}},
        color={95,95,95},
        thickness=0.5));
    connect(relativeVelocity3.frame_b, body.frame_a) annotation (Line(
        points={{10,-60},{40,-60},{40,60},{50,60}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedRotated.frame, relativeVelocity3.frame_resolve) annotation (Line(
        points={{-30,-80},{10,-80},{10,-68}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedRotated.frame, absoluteVelocity2.frame_resolve) annotation (Line(
        points={{-30,-80},{60,-80},{60,-70}},
        color={95,95,95},
        thickness=0.5));
    connect(fixed.frame, springDamper.frame_a) annotation (Line(
        points={{-50,60},{-20,60}},
        color={95,95,95},
        thickness=0.5));
    connect(springDamper.frame_b, fixedTranslation.frame_a) annotation (Line(
        points={{0,60},{12,60}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedTranslation.frame_b, body.frame_a) annotation (Line(
        points={{32,60},{50,60}},
        color={95,95,95},
        thickness=0.5));
    annotation (
      experiment(StopTime=5));
  end VelocityResolveInFrame;

  model AccelerationResolveInFrame "Test absolute and relative acceleration sensors, resolved in different frames"
    extends Modelica.Icons.Example;

    PlanarMechanics.Sensors.AbsoluteAcceleration absoluteAcceleration(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world)
      annotation (Placement(transformation(extent={{50,20},{70,40}})));
    PlanarMechanics.Sensors.AbsoluteAcceleration absoluteAcceleration1(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a)
      annotation (Placement(transformation(extent={{50,-10},{70,10}})));
    PlanarMechanics.Sensors.AbsoluteAcceleration absoluteAcceleration2(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve)
      annotation (Placement(transformation(extent={{50,-70},{70,-50}})));
    PlanarMechanics.Sensors.RelativeAcceleration relativeAcceleration(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.world)
      annotation (Placement(transformation(extent={{-10,20},{10,40}})));
    PlanarMechanics.Sensors.RelativeAcceleration relativeAcceleration1(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    PlanarMechanics.Sensors.RelativeAcceleration relativeAcceleration2(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_b)
      annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
    PlanarMechanics.Sensors.RelativeAcceleration relativeAcceleration3(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve)
      annotation (Placement(transformation(extent={{-10,-50},{10,-70}})));
    inner PlanarMechanics.PlanarWorld planarWorld(constantGravity={0,0})
      annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
    PlanarMechanics.Parts.Body body(
      m=1,
      I=1,
      r(each fixed=true, start={0.02,0.6}),
      v(each fixed=true, start={0.14,-0.75}),
      phi(fixed=true, start=-0.87266462599716),
      w(fixed=true, start=0.3))     annotation (Placement(transformation(extent={{50,50},{70,70}})));
    PlanarMechanics.Parts.Fixed fixed annotation (Placement(transformation(extent={{-50,50},{-70,70}})));
    PlanarMechanics.Parts.Fixed fixedRotated(
      r={0,-1},
      phi=0.29670597283904) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={-40,-80})));
    PlanarMechanics.Parts.SpringDamper springDamper(
      c_x=1,
      c_y=1,
      c_phi=1,
      d_x=0.1,
      d_y=0.1,
      d_phi=0.1,
      s_relx0=0.1) annotation (Placement(transformation(extent={{-20,50},{0,70}})));
    PlanarMechanics.Parts.FixedTranslation fixedTranslation(r={0.13,0.22}) annotation (Placement(transformation(extent={{12,50},{32,70}})));
  equation
    connect(fixed.frame, relativeAcceleration.frame_a) annotation (Line(
        points={{-50,60},{-30,60},{-30,30},{-10,30}},
        color={95,95,95},
        thickness=0.5));
    connect(relativeAcceleration.frame_b, body.frame_a) annotation (Line(
        points={{10,30},{40,30},{40,60},{50,60}},
        color={95,95,95},
        thickness=0.5));
    connect(absoluteAcceleration.frame_a, body.frame_a) annotation (Line(
        points={{50,30},{40,30},{40,60},{50,60}},
        color={95,95,95},
        thickness=0.5));
    connect(fixed.frame, relativeAcceleration1.frame_a) annotation (Line(
        points={{-50,60},{-30,60},{-30,0},{-10,0}},
        color={95,95,95},
        thickness=0.5));
    connect(relativeAcceleration1.frame_b, body.frame_a) annotation (Line(
        points={{10,0},{40,0},{40,60},{50,60}},
        color={95,95,95},
        thickness=0.5));
    connect(absoluteAcceleration1.frame_a, body.frame_a) annotation (Line(
        points={{50,0},{40,0},{40,60},{50,60}},
        color={95,95,95},
        thickness=0.5));
    connect(fixed.frame, relativeAcceleration2.frame_a) annotation (Line(
        points={{-50,60},{-30,60},{-30,-30},{-10,-30}},
        color={95,95,95},
        thickness=0.5));
    connect(relativeAcceleration2.frame_b, body.frame_a) annotation (Line(
        points={{10,-30},{40,-30},{40,60},{50,60}},
        color={95,95,95},
        thickness=0.5));
    connect(absoluteAcceleration2.frame_a, body.frame_a) annotation (Line(
        points={{50,-60},{40,-60},{40,60},{50,60}},
        color={95,95,95},
        thickness=0.5));
    connect(fixed.frame, relativeAcceleration3.frame_a) annotation (Line(
        points={{-50,60},{-30,60},{-30,-60},{-10,-60}},
        color={95,95,95},
        thickness=0.5));
    connect(relativeAcceleration3.frame_b, body.frame_a) annotation (Line(
        points={{10,-60},{40,-60},{40,60},{50,60}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedRotated.frame, relativeAcceleration3.frame_resolve) annotation (Line(
        points={{-30,-80},{10,-80},{10,-68}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedRotated.frame, absoluteAcceleration2.frame_resolve) annotation (Line(
        points={{-30,-80},{60,-80},{60,-70}},
        color={95,95,95},
        thickness=0.5));
    connect(fixed.frame, springDamper.frame_a) annotation (Line(
        points={{-50,60},{-20,60}},
        color={95,95,95},
        thickness=0.5));
    connect(springDamper.frame_b, fixedTranslation.frame_a) annotation (Line(
        points={{0,60},{12,60}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedTranslation.frame_b, body.frame_a) annotation (Line(
        points={{32,60},{50,60}},
        color={95,95,95},
        thickness=0.5));
    annotation (
      experiment(StopTime=5));
  end AccelerationResolveInFrame;

  model AbsoluteRotated "Test sensors measuring absolute quantities in rotated frame_a"
    extends Modelica.Icons.Example;

    inner PlanarMechanics.PlanarWorld planarWorld annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
    PlanarMechanics.Parts.Body body(m=1, I=1) annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
    PlanarMechanics.Parts.Fixed fixed(phi=-0.78539816339745)
      annotation (Placement(transformation(extent={{-40,-30},{-60,-10}})));
    PlanarMechanics.Joints.Prismatic prismatic(
      r={1,1},
      s(fixed=true, start=0),
      v(fixed=true, start=1))  annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
    PlanarMechanics.Sensors.AbsolutePosition absolutePosition(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a)
      annotation (Placement(transformation(extent={{40,0},{60,20}})));
    PlanarMechanics.Sensors.AbsoluteVelocity absoluteVelocity(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a)
      annotation (Placement(transformation(extent={{40,30},{60,50}})));
    PlanarMechanics.Sensors.AbsoluteAcceleration absoluteAcceleration(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a)
      annotation (Placement(transformation(extent={{40,60},{60,80}})));
  equation
    connect(fixed.frame, prismatic.frame_a) annotation (Line(
        points={{-40,-20},{-20,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(prismatic.frame_b, body.frame_a) annotation (Line(
        points={{0,-20},{40,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(absolutePosition.frame_a, body.frame_a) annotation (Line(
        points={{40,10},{20,10},{20,-20},{40,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(absoluteVelocity.frame_a, body.frame_a) annotation (Line(
        points={{40,40},{20,40},{20,-20},{40,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(absoluteAcceleration.frame_a, body.frame_a) annotation (Line(
        points={{40,70},{20,70},{20,-20},{40,-20}},
        color={95,95,95},
        thickness=0.5));

    annotation (experiment(StopTime=1));
  end AbsoluteRotated;

  model AbsoluteRotatedAcc "Test sensors measuring absolute quantities of accelerating body in rotated frame_a"
    extends Modelica.Icons.Example;

    inner PlanarMechanics.PlanarWorld planarWorld annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
    PlanarMechanics.Parts.Body body(m=1, I=1) annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
    PlanarMechanics.Parts.Fixed fixed(phi=-0.78539816339745)
      annotation (Placement(transformation(extent={{-40,-30},{-60,-10}})));
    PlanarMechanics.Joints.Prismatic prismatic(
      r={1,1},
      s(fixed=true, start=0),
      v(fixed=true, start=1))  annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
    PlanarMechanics.Sensors.AbsolutePosition absolutePosition(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a)
      annotation (Placement(transformation(extent={{40,0},{60,20}})));
    PlanarMechanics.Sensors.AbsoluteVelocity absoluteVelocity(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a)
      annotation (Placement(transformation(extent={{40,30},{60,50}})));
    PlanarMechanics.Sensors.AbsoluteAcceleration absoluteAcceleration(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a)
      annotation (Placement(transformation(extent={{40,60},{60,80}})));
    PlanarMechanics.Sources.WorldForce worldForce(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.world, N_to_m=30)
      annotation (Placement(transformation(extent={{-20,-70},{0,-50}})));
    Modelica.Blocks.Sources.Constant const[2](k={10,0}) annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
    Modelica.Blocks.Sources.Constant signalTorque(k=0) "Torque signal" annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
  equation
    connect(fixed.frame, prismatic.frame_a) annotation (Line(
        points={{-40,-20},{-20,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(prismatic.frame_b, body.frame_a) annotation (Line(
        points={{0,-20},{40,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(absolutePosition.frame_a, body.frame_a) annotation (Line(
        points={{40,10},{20,10},{20,-20},{40,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(absoluteVelocity.frame_a, body.frame_a) annotation (Line(
        points={{40,40},{20,40},{20,-20},{40,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(absoluteAcceleration.frame_a, body.frame_a) annotation (Line(
        points={{40,70},{20,70},{20,-20},{40,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(worldForce.frame_b, body.frame_a) annotation (Line(
        points={{0,-60},{20,-60},{20,-20},{40,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(const.y, worldForce.force) annotation (Line(points={{-39,-60},{-22,-60}}, color={0,0,127}));
    connect(signalTorque.y, worldForce.torque) annotation (Line(points={{-39,-90},{-30,-90},{-30,-66},{-22,-66}}, color={0,0,127}));
    annotation (experiment(StopTime=1));
  end AbsoluteRotatedAcc;

  model AbsoluteAccCentrifugal "Test sensors measuring absolute quantities in for steady state rotation of frame_a"
    extends Modelica.Icons.Example;

    inner PlanarMechanics.PlanarWorldIn3D planarWorld(
      constantGravity={0,0},
      animateGravity=false,
      animateWorld=false,
      connectToMultiBody=false,
      enableAnimation=true,
      inheritGravityFromMultiBody=false)
      annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
    PlanarMechanics.Parts.Body body(m=1, I=0.1)
      annotation (Placement(transformation(extent={{10,-30},{30,-10}})));
    PlanarMechanics.Parts.FixedTranslation fixedTranslation(r={10,0})
      annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
    PlanarMechanics.Parts.Fixed fixed annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={-90,-20})));
    PlanarMechanics.Joints.Revolute revolute1(
      phi(fixed=true),
      w(fixed=true,
        displayUnit="rad/s",
        start=10))
      annotation (Placement(transformation(extent={{-70,-30},{-50,-10}})));
    PlanarMechanics.Sensors.AbsolutePosition absolutePosition(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a)
      annotation (Placement(transformation(extent={{20,10},{40,30}})));
    PlanarMechanics.Sensors.AbsoluteVelocity absoluteVelocity(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a)
      annotation (Placement(transformation(extent={{20,40},{40,60}})));
    PlanarMechanics.Sensors.AbsoluteAcceleration absoluteAcceleration(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a)
      annotation (Placement(transformation(extent={{20,70},{40,90}})));
  equation
    connect(fixedTranslation.frame_b, body.frame_a) annotation (Line(
        points={{-20,-20},{10,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(fixed.frame, revolute1.frame_a) annotation (Line(
        points={{-80,-20},{-70,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(revolute1.frame_b, fixedTranslation.frame_a) annotation (Line(
        points={{-50,-20},{-40,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(absolutePosition.frame_a, body.frame_a) annotation (Line(
        points={{20,20},{0,20},{0,-20},{10,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(absoluteVelocity.frame_a, body.frame_a) annotation (Line(
        points={{20,50},{0,50},{0,-20},{10,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(absoluteAcceleration.frame_a, body.frame_a) annotation (Line(
        points={{20,80},{0,80},{0,-20},{10,-20}},
        color={95,95,95},
        thickness=0.5));

    annotation (
      experiment(StopTime=1),
      Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={
          Text(
            extent={{-60,-40},{60,-100}},
            textColor={28,108,200},
            horizontalAlignment=TextAlignment.Left,
            textString="Assumptions:
Gravity to isolate the effect of centrifugal acc.
Global frame is at phi = 0 for easier comprehension of the body rotation.
The joint rotates at constant speed w = 10 rad/s.
The body moves on a circular path at constant velocity: v = w * r = 10*10 m/s.
The bodies acceleration due to centrifugal forces is: a = w * r^2 = 10*10*10 m/s^2.

Expected results:
- The measured velocity wrt to frame_a is {0,v,w}. Correct!
- The measured acc resolved in frame_a is {a,0,0}. Actual result: {0,0,0}")}),
      __Dymola_Commands(executeCall(
          ensureSimulated=true,
          autoRun=true) = {createPlot(
            id=1,
            position={0,0,1289,847},
            y={"revolute1.w","absoluteVelocity.v[1]","absoluteVelocity.v[2]",
            "absoluteVelocity.v[3]"},
            range={0.0,1.0,-50.0,150.0},
            grid=true,
            colors={{28,108,200},{238,46,47},{0,140,72},{217,67,180}},
            range2={8.5,11.5},
            axes={2,1,1,1}),createPlot(
            id=1,
            position={0,0,1289,279},
            y={"absolutePosition.r[1]","absolutePosition.r[2]",
            "absolutePosition.r[3]"},
            range={0.0,1.0,-5.0,15.0},
            grid=true,
            subPlot=3,
            colors={{28,108,200},{238,46,47},{0,140,72}}),createPlot(
            id=1,
            position={0,0,1289,279},
            y={"body.a[1]","body.a[2]","absoluteAcceleration.a[1]",
            "absoluteAcceleration.a[2]","absoluteAcceleration.a[3]"},
            range={0.0,1.0,-1500.0,1500.0},
            grid=true,
            subPlot=2,
            colors={{28,108,200},{238,46,47},{0,140,72},{217,67,180},{0,0,0}})}
          "PlotTestResults"));
  end AbsoluteAccCentrifugal;

  model AbsoluteAccCentrifugalAcc "Test sensors measuring absolute quantities in for accelerated rotation of frame_a"
    extends Modelica.Icons.Example;

    inner PlanarMechanics.PlanarWorldIn3D planarWorld(
      constantGravity={0,0},
      animateGravity=false,
      animateWorld=false,
      connectToMultiBody=false,
      enableAnimation=true,
      inheritGravityFromMultiBody=false)
      annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
    PlanarMechanics.Parts.Body body(m=1, I=0.1)
      annotation (Placement(transformation(extent={{10,-30},{30,-10}})));
    PlanarMechanics.Parts.FixedTranslation fixedTranslation(r={10,0})
      annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
    PlanarMechanics.Parts.Fixed fixed annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={-90,-20})));
    PlanarMechanics.Joints.Revolute revolute1(
      useFlange=true,
      phi(fixed=true),
      w(fixed=true,
        displayUnit="rad/s",
        start=10))
      annotation (Placement(transformation(extent={{-70,-30},{-50,-10}})));
    PlanarMechanics.Sensors.AbsolutePosition absolutePosition(resolveInFrame=
      Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a)
      annotation (Placement(transformation(extent={{20,10},{40,30}})));
    PlanarMechanics.Sensors.AbsoluteVelocity absoluteVelocity(resolveInFrame=
      Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a)
      annotation (Placement(transformation(extent={{20,40},{40,60}})));
    PlanarMechanics.Sensors.AbsoluteAcceleration absoluteAcceleration(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a)
      annotation (Placement(transformation(extent={{20,70},{40,90}})));
    Modelica.Mechanics.Rotational.Sources.ConstantTorque constantTorque(tau_constant=100) annotation (Placement(transformation(extent={{-90,-70},{-70,-50}})));
  equation
    connect(fixedTranslation.frame_b, body.frame_a) annotation (Line(
        points={{-20,-20},{10,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(fixed.frame, revolute1.frame_a) annotation (Line(
        points={{-80,-20},{-70,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(revolute1.frame_b, fixedTranslation.frame_a) annotation (Line(
        points={{-50,-20},{-40,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(absolutePosition.frame_a, body.frame_a) annotation (Line(
        points={{20,20},{0,20},{0,-20},{10,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(absoluteVelocity.frame_a, body.frame_a) annotation (Line(
        points={{20,50},{0,50},{0,-20},{10,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(absoluteAcceleration.frame_a, body.frame_a) annotation (Line(
        points={{20,80},{0,80},{0,-20},{10,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(constantTorque.flange, revolute1.axis) annotation (Line(points={{-70,-60},{-60,-60},{-60,-30}}, color={0,0,0}));

    annotation (experiment(StopTime=1));
  end AbsoluteAccCentrifugalAcc;

  model CutForces "Test resolveInFrame of CutForce sensor"
    extends Modelica.Icons.Example;

    PlanarMechanics.Parts.Body body(m=1, I=0.1) annotation (Placement(transformation(extent={{80,-10},{100,10}})));
    PlanarMechanics.Sensors.CutForce cutForce_inFrameA(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a) annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
    PlanarMechanics.Sensors.CutForce cutForce_inWorld(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    PlanarMechanics.Sensors.CutForce cutForce_inFrameResolve(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve) annotation (Placement(transformation(extent={{50,-10},{70,10}})));
    PlanarMechanics.Joints.Revolute revolute(
      useFlange=true,
      phi(fixed=true, start=0),
      w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-40,10},{-20,-10}})));
    PlanarMechanics.Parts.FixedTranslation fixedTranslation(r={1,0})  annotation (Placement(transformation(extent={{20,-10},{40,10}})));
    PlanarMechanics.Parts.Fixed fixed(phi=0) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={-90,0})));
    inner PlanarMechanics.PlanarWorld planarWorld(
      defaultWidthFraction=10,
      defaultN_to_m=1)
      annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
    Modelica.Mechanics.Rotational.Components.Damper damper(d=0.1)
      annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  equation
    connect(revolute.frame_a, cutForce_inFrameA.frame_b) annotation (Line(
        points={{-40,0},{-50,0}},
        color={95,95,95},
        thickness=0.5));
    connect(cutForce_inFrameA.frame_a, fixed.frame) annotation (Line(
        points={{-70,0},{-80,0}},
        color={95,95,95},
        thickness=0.5));
    connect(revolute.frame_b, cutForce_inWorld.frame_a) annotation (Line(
        points={{-20,0},{-10,0}},
        color={95,95,95},
        thickness=0.5));
    connect(cutForce_inWorld.frame_b, fixedTranslation.frame_a) annotation (Line(
        points={{10,0},{20,0}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedTranslation.frame_b, cutForce_inFrameResolve.frame_a) annotation (Line(
        points={{40,0},{50,0}},
        color={95,95,95},
        thickness=0.5));
    connect(cutForce_inFrameResolve.frame_b, body.frame_a) annotation (Line(
        points={{70,0},{80,0}},
        color={95,95,95},
        thickness=0.5));
    connect(fixed.frame, cutForce_inFrameResolve.frame_resolve) annotation (Line(
        points={{-80,0},{-76,0},{-76,-30},{68,-30},{68,-10}},
        color={95,95,95},
        thickness=0.5));
    connect(damper.flange_b, revolute.axis) annotation (Line(points={{-20,40},{-20,20},{-30,20},{-30,10}}));
    connect(revolute.support,damper. flange_a) annotation (Line(points={{-36,10},{-36,20},{-40,20},{-40,40}}));
    annotation (
      experiment(StopTime=3));
  end CutForces;

  model CutTorques "Test CutTorque sensor"
    extends Modelica.Icons.Example;

    PlanarMechanics.Parts.Body body(m=1, I=0.1) annotation (Placement(transformation(extent={{80,-10},{100,10}})));
    PlanarMechanics.Sensors.CutTorque cutTorque annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
    PlanarMechanics.Joints.Revolute revolute(
      useFlange=true,
      phi(fixed=true, start=0),
      w(fixed=true, start=0)) annotation (Placement(transformation(extent={{10,10},{30,-10}})));
    PlanarMechanics.Parts.FixedTranslation fixedTranslation(r={1,0})  annotation (Placement(transformation(extent={{40,-10},{60,10}})));
    PlanarMechanics.Parts.Fixed fixed(phi=0) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={-70,0})));
    inner PlanarMechanics.PlanarWorld planarWorld(
      defaultWidthFraction=10,
      defaultN_to_m=1,
      defaultNm_to_m=1)
      annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
    PlanarMechanics.Sources.WorldForce worldForce(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_b)
      annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
    Modelica.Blocks.Sources.Sine signalVec3[2](
      each f=signalTorque.f,
      amplitude={0,-5},
      each startTime=signalTorque.startTime)
      "Vector of force signals"
      annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
    Modelica.Blocks.Sources.Sine signalTorque(
      f=1,
      amplitude=1,
      startTime=1.8) "Torque signal" annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
    PlanarMechanics.Parts.FixedTranslation fixedTranslation1(r={0.5,0})
      annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
    Modelica.Mechanics.Rotational.Components.Damper damper(d=0.1)
      annotation (Placement(transformation(extent={{10,30},{30,50}})));
  equation
    connect(fixedTranslation.frame_b, body.frame_a) annotation (Line(
        points={{60,0},{80,0}},
        color={95,95,95},
        thickness=0.5));
    connect(worldForce.frame_b, body.frame_a) annotation (Line(
        points={{60,-40},{70,-40},{70,0},{80,0}},
        color={95,95,95},
        thickness=0.5));
    connect(signalVec3.y,worldForce. force) annotation (Line(
        points={{21,-40},{38,-40}},
        color={0,0,127}));
    connect(revolute.frame_b, fixedTranslation.frame_a) annotation (Line(
        points={{30,0},{40,0}},
        color={95,95,95},
        thickness=0.5));
    connect(fixed.frame, cutTorque.frame_a) annotation (Line(
        points={{-60,0},{-50,0}},
        color={95,95,95},
        thickness=0.5));
    connect(cutTorque.frame_b, fixedTranslation1.frame_a) annotation (Line(
        points={{-30,0},{-20,0}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedTranslation1.frame_b, revolute.frame_a) annotation (Line(
        points={{0,0},{10,0}},
        color={95,95,95},
        thickness=0.5));
    connect(damper.flange_b, revolute.axis) annotation (Line(points={{30,40},{30,20},{20,20},{20,10}}));
    connect(revolute.support,damper. flange_a) annotation (Line(points={{14,10},{14,20},{10,20},{10,40}}));
    connect(signalTorque.y, worldForce.torque) annotation (Line(points={{21,-70},{30,-70},{30,-46},{38,-46}},   color={0,0,127}));
    annotation (
      experiment(StopTime=3));
  end CutTorques;

  model CutForcesAndTorques "Test resolveInFrame of CutForceAndTorque sensor"
    extends Modelica.Icons.Example;

    PlanarMechanics.Parts.Body body(m=1, I=0.1) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={80,-60})));
    PlanarMechanics.Sensors.CutForceAndTorque cutForceAndTorque_inFrameA(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a) annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
    PlanarMechanics.Sensors.CutForceAndTorque cutForceAndTorque_inWorld(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world) annotation (Placement(transformation(extent={{50,-10},{70,10}})));
    PlanarMechanics.Sensors.CutForceAndTorque cutForceAndTorque_inFrameResolve(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    PlanarMechanics.Joints.Revolute revolute(
      useFlange=true,
      phi(fixed=true, start=0),
      w(fixed=true, start=0)) annotation (Placement(transformation(extent={{20,10},{40,-10}})));
    PlanarMechanics.Parts.FixedTranslation fixedTranslation(r={1,0})  annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={80,-20})));
    PlanarMechanics.Parts.Fixed fixed(phi=0) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={-90,0})));
    inner PlanarMechanics.PlanarWorld planarWorld(
      defaultWidthFraction=10,
      defaultN_to_m=1,
      defaultNm_to_m=1)
      annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
    PlanarMechanics.Parts.FixedTranslation fixedTranslation1(r={0.5,0})
      annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
    PlanarMechanics.Sources.WorldForce worldForce(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_b)
      annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
    Modelica.Blocks.Sources.Sine signalVec2[2](
      each f=signalTorque.f,
      amplitude={0,-5},
      each startTime=signalTorque.startTime)
      "Vector of force signals"
      annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
    Modelica.Blocks.Sources.Sine signalTorque(
      f=1,
      amplitude=1,
      startTime=1.8) "Torque signal" annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
    Modelica.Mechanics.Rotational.Components.Damper damper(d=0.1)
      annotation (Placement(transformation(extent={{20,30},{40,50}})));
  equation
    connect(cutForceAndTorque_inFrameA.frame_a, fixed.frame) annotation (Line(
        points={{-70,0},{-80,0}},
        color={95,95,95},
        thickness=0.5));
    connect(revolute.frame_b, cutForceAndTorque_inWorld.frame_a) annotation (Line(
        points={{40,0},{50,0}},
        color={95,95,95},
        thickness=0.5));
    connect(cutForceAndTorque_inWorld.frame_b, fixedTranslation.frame_a) annotation (Line(
        points={{70,0},{80,0},{80,-10}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedTranslation1.frame_a, cutForceAndTorque_inFrameA.frame_b) annotation (Line(
        points={{-40,0},{-50,0}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedTranslation.frame_b, body.frame_a) annotation (Line(
        points={{80,-30},{80,-50}},
        color={95,95,95},
        thickness=0.5));
    connect(body.frame_a, cutForceAndTorque_inFrameResolve.frame_resolve) annotation (Line(
        points={{80,-50},{80,-40},{8,-40},{8,-10}},
        color={95,95,95},
        thickness=0.5));
    connect(cutForceAndTorque_inFrameResolve.frame_a, fixedTranslation1.frame_b) annotation (Line(
        points={{-10,0},{-20,0}},
        color={95,95,95},
        thickness=0.5));
    connect(cutForceAndTorque_inFrameResolve.frame_b, revolute.frame_a) annotation (Line(
        points={{10,0},{20,0}},
        color={95,95,95},
        thickness=0.5));
    connect(worldForce.frame_b, body.frame_a) annotation (Line(
        points={{0,-40},{80,-40},{80,-50}},
        color={95,95,95},
        thickness=0.5));
    connect(signalVec2.y,worldForce. force) annotation (Line(
        points={{-39,-40},{-22,-40}},
        color={0,0,127}));
    connect(damper.flange_b, revolute.axis) annotation (Line(points={{40,40},{40,20},{30,20},{30,10}}));
    connect(revolute.support,damper. flange_a) annotation (Line(points={{24,10},{24,20},{20,20},{20,40}}));
    connect(signalTorque.y, worldForce.torque) annotation (Line(points={{-39,-70},{-30,-70},{-30,-46},{-22,-46}},
                                                                                                                color={0,0,127}));
    annotation (
      experiment(StopTime=3));
  end CutForcesAndTorques;
end Sensors;
