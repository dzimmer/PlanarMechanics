within PlanarMechanicsTest;
package Sensors "Test models for PlanarMechanics.Sensors"
  extends Modelica.Icons.Package;
  model PositionDistance "Test absolute and relative position sensors and distance sensor"
    extends Modelica.Icons.Example;

    inner PlanarMechanics.PlanarWorld planarWorld annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
    PlanarMechanics.Parts.Body body(m=1, I=1) annotation (Placement(transformation(extent={{40,20},{60,40}})));
    PlanarMechanics.Parts.Fixed fixed annotation (Placement(transformation(extent={{-60,20},{-80,40}})));
    PlanarMechanics.Joints.Prismatic prismatic(
      r={1,0},
      s(fixed=true, start=0.5),
      v(fixed=true, start=-1)) annotation (Placement(transformation(extent={{-20,20},{0,40}})));
    PlanarMechanics.Sensors.AbsolutePosition absolutePosition annotation (Placement(transformation(extent={{36,-40},{56,-20}})));
    PlanarMechanics.Sensors.RelativePosition relativePosition annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
    PlanarMechanics.Sensors.Distance distance annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  equation
    connect(fixed.frame, prismatic.frame_a) annotation (Line(
        points={{-60,30},{-20,30}},
        color={95,95,95},
        thickness=0.5));
    connect(prismatic.frame_b, body.frame_a) annotation (Line(
        points={{0,30},{40,30}},
        color={95,95,95},
        thickness=0.5));
    connect(fixed.frame, relativePosition.frame_a) annotation (Line(
        points={{-60,30},{-40,30},{-40,-30},{-20,-30}},
        color={95,95,95},
        thickness=0.5));
    connect(relativePosition.frame_b, body.frame_a) annotation (Line(
        points={{0,-30},{20,-30},{20,30},{40,30}},
        color={95,95,95},
        thickness=0.5));
    connect(fixed.frame, distance.frame_a) annotation (Line(
        points={{-60,30},{-40,30},{-40,0},{-20,0}},
        color={95,95,95},
        thickness=0.5));
    connect(distance.frame_b, body.frame_a) annotation (Line(
        points={{0,0},{20,0},{20,30},{40,30}},
        color={95,95,95},
        thickness=0.5));
    connect(absolutePosition.frame_a, body.frame_a) annotation (Line(
        points={{36,-30},{20,-30},{20,30},{40,30}},
        color={95,95,95},
        thickness=0.5));
    annotation ();
  end PositionDistance;

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
  end AbsoluteRotated;

  model AbsoluteRotatedAdd "Test sensors measuring absolute quantities of accelerating body in rotated frame_a"
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
    PlanarMechanics.Sources.WorldForce worldForce(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.world) annotation (Placement(transformation(extent={{-20,-70},{0,-50}})));
    Modelica.Blocks.Sources.Constant const[3](k={10,0,0}) annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
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
  end AbsoluteRotatedAdd;
end Sensors;
