within PlanarMechanicsTest.Transformations;
model Test_resolve2in1_RotationalVel "Test derivations of resolve2in1 for rotational movement - velocity sensors"
  extends Modelica.Icons.Example;
  import Modelica.Math.sin;
  import Modelica.Math.cos;

  Modelica.Blocks.Math.Add mustBeZeroAbs[2](each k2=-1) annotation (Placement(transformation(extent={{80,-30},{100,-10}})));
  Modelica.Blocks.Math.Add mustBeZeroRel[2](each k2=-1) annotation (Placement(transformation(extent={{80,-50},{100,-70}})));
  Modelica.Blocks.Sources.RealExpression exprVelocityOfBody[2](
    y=constantSpeed.w_fixed*fixedTranslation.r[1]*{-sin(revolute.phi),cos(revolute.phi)})
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  PlanarMechanics.Sensors.AbsoluteVelocity absoluteVelocity(
    resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world)
    annotation (Placement(transformation(extent={{40,-20},{60,0}})));
  PlanarMechanics.Sensors.RelativeVelocity relativeVelocity(
    resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.world)
    annotation (Placement(transformation(extent={{-30,-20},{-10,0}})));
  inner PlanarMechanics.PlanarWorld planarWorld annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  PlanarMechanics.Parts.Body body(m=1, I=1) annotation (Placement(transformation(extent={{40,20},{60,40}})));
  PlanarMechanics.Parts.Fixed fixed(phi=0)
    annotation (Placement(transformation(extent={{-60,20},{-80,40}})));
  PlanarMechanics.Joints.Revolute revolute(
    useFlange=true,
    phi(fixed=true, start=0))
    annotation (Placement(transformation(extent={{-30,40},{-10,20}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(
    w_fixed=-1)
    annotation (Placement(transformation(extent={{-52,50},{-32,70}})));
  PlanarMechanics.Parts.FixedTranslation fixedTranslation(
    r={1,0})
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
equation
  connect(fixed.frame, revolute.frame_a) annotation (Line(
      points={{-60,30},{-30,30}},
      color={95,95,95},
      thickness=0.5));
  connect(fixed.frame,relativeVelocity. frame_a) annotation (Line(
      points={{-60,30},{-50,30},{-50,-10},{-30,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(relativeVelocity.frame_b, body.frame_a) annotation (Line(
      points={{-10,-10},{30,-10},{30,30},{40,30}},
      color={95,95,95},
      thickness=0.5));
  connect(absoluteVelocity.frame_a, body.frame_a) annotation (Line(
      points={{40,-10},{30,-10},{30,30},{40,30}},
      color={95,95,95},
      thickness=0.5));

  connect(constantSpeed.flange, revolute.flange_a) annotation (Line(points={{-32,60},{-20,60},{-20,40}}, color={0,127,0}));
  connect(absoluteVelocity.v[1:2], mustBeZeroAbs.u1) annotation (Line(points={{61,-10},{70,-10},{70,-14},{78,-14}}, color={0,0,127}));
  connect(exprVelocityOfBody.y, mustBeZeroAbs.u2) annotation (Line(points={{61,-40},{70,-40},{70,-26},{78,-26}}, color={0,0,127}));
  connect(revolute.frame_b, fixedTranslation.frame_a) annotation (Line(
      points={{-10,30},{-8.88178e-16,30}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation.frame_b, body.frame_a) annotation (Line(
      points={{20,30},{40,30}},
      color={95,95,95},
      thickness=0.5));
  connect(exprVelocityOfBody.y, mustBeZeroRel.u2) annotation (Line(points={{61,-40},{70,-40},{70,-54},{78,-54}}, color={0,0,127}));
  connect(relativeVelocity.v_rel[1:2], mustBeZeroRel.u1) annotation (Line(points={{-20,-21},{-20,-66},{78,-66}}, color={0,0,127}));
  annotation (experiment(StopTime=1));
end Test_resolve2in1_RotationalVel;
