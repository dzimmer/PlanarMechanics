within PlanarMechanicsTest.Transformations;
model Test_resolve2in1_Translational "Test derivations of resolve2in1 for translational movement"
  extends Modelica.Icons.Example;

  Modelica.Blocks.Math.Add mustBeZeroAbs[2](each k2=-1) annotation (Placement(transformation(extent={{80,-30},{100,-10}})));
  Modelica.Blocks.Math.Add mustBeZeroRel[2](each k2=-1) annotation (Placement(transformation(extent={{80,-50},{100,-70}})));
  Modelica.Blocks.Sources.RealExpression exprVelocityOfBody[2](
    y=constantSpeed.v_fixed*{Modelica.Math.cos(fixed.phi),Modelica.Math.sin(fixed.phi)}) annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  PlanarMechanics.Sensors.AbsoluteVelocity absoluteVelocity(
    resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world)
    annotation (Placement(transformation(extent={{40,-20},{60,0}})));
  PlanarMechanics.Sensors.RelativeVelocity relativeVelocity(
    resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.world)
    annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  inner PlanarMechanics.PlanarWorld planarWorld annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  PlanarMechanics.Parts.Body body(m=1, I=1) annotation (Placement(transformation(extent={{40,20},{60,40}})));
  PlanarMechanics.Parts.Fixed fixed(phi=0.5235987755983)
    annotation (Placement(transformation(extent={{-60,20},{-80,40}})));
  PlanarMechanics.Joints.Prismatic prismatic(
    useFlange=true,
    r={1,0},
    s(fixed=true, start=0.5))
    annotation (Placement(transformation(extent={{-20,40},{0,20}})));
  Modelica.Mechanics.Translational.Sources.ConstantSpeed constantSpeed(
    v_fixed=-1) annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
equation
  connect(fixed.frame, prismatic.frame_a) annotation (Line(
      points={{-60,30},{-20,30}},
      color={95,95,95},
      thickness=0.5));
  connect(prismatic.frame_b, body.frame_a) annotation (Line(
      points={{0,30},{40,30}},
      color={95,95,95},
      thickness=0.5));
  connect(fixed.frame,relativeVelocity. frame_a) annotation (Line(
      points={{-60,30},{-40,30},{-40,-10},{-20,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(relativeVelocity.frame_b, body.frame_a) annotation (Line(
      points={{0,-10},{20,-10},{20,30},{40,30}},
      color={95,95,95},
      thickness=0.5));
  connect(absoluteVelocity.frame_a, body.frame_a) annotation (Line(
      points={{40,-10},{20,-10},{20,30},{40,30}},
      color={95,95,95},
      thickness=0.5));

  connect(constantSpeed.flange, prismatic.flange_a) annotation (Line(points={{-20,60},{-10,60},{-10,40}}, color={0,127,0}));
  connect(absoluteVelocity.v[1:2], mustBeZeroAbs.u1) annotation (Line(points={{61,-10},{70,-10},{70,-14},{78,-14}}, color={0,0,127}));
  connect(exprVelocityOfBody.y, mustBeZeroAbs.u2) annotation (Line(points={{61,-40},{70,-40},{70,-26},{78,-26}}, color={0,0,127}));
  connect(exprVelocityOfBody.y,mustBeZeroRel. u2) annotation (Line(points={{61,-40},{70,-40},{70,-54},{78,-54}}, color={0,0,127}));
  connect(relativeVelocity.v_rel[1:2],mustBeZeroRel. u1) annotation (Line(points={{-10,-21},{-10,-66},{78,-66}}, color={0,0,127}));
  annotation (experiment(StopTime=1));
end Test_resolve2in1_Translational;
