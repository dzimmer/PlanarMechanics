within PlanarMechanicsTest.Transformations;
model Test_resolve2in1_All "Test derivations of resolve2in1 for both rotational and translational movement - velocity sensors"
  extends Modelica.Icons.Example;
  import Modelica.Math.sin;
  import Modelica.Math.cos;

  Modelica.Blocks.Math.Add mustBeZero[3](each k2=-1) annotation (Placement(transformation(extent={{80,-40},{100,-20}})));
  PlanarMechanics.Sensors.AbsoluteVelocity absoluteVelocity(
    resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world)
    annotation (Placement(transformation(extent={{40,-20},{60,0}})));
  PlanarMechanics.Sensors.RelativeVelocity relativeVelocity(
    resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.world)
    annotation (Placement(transformation(extent={{-30,-20},{-10,0}})));
  inner PlanarMechanics.PlanarWorld planarWorld annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  PlanarMechanics.Parts.Body body(m=1, I=1) annotation (Placement(transformation(extent={{40,20},{60,40}})));
  PlanarMechanics.Parts.Fixed fixed(phi=0)
    annotation (Placement(transformation(extent={{-80,20},{-100,40}})));
  PlanarMechanics.Joints.Revolute revolute(
    useFlange=true,
    phi(fixed=true, start=0))
    annotation (Placement(transformation(extent={{-60,40},{-40,20}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(w_fixed=-1.2)
    annotation (Placement(transformation(extent={{-82,50},{-62,70}})));
  PlanarMechanics.Parts.FixedTranslation fixedTranslation(r={0.9,-0.13})
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  PlanarMechanics.Joints.Prismatic prismatic(
    useFlange=true,
    r={1,0},
    s(fixed=true, start=0.5))
    annotation (Placement(transformation(extent={{-30,40},{-10,20}})));
  Modelica.Mechanics.Translational.Sources.ConstantSpeed constantSpeed1(v_fixed=0.84)
                annotation (Placement(transformation(extent={{10,50},{-10,70}})));
equation
  connect(fixed.frame, revolute.frame_a) annotation (Line(
      points={{-80,30},{-60,30}},
      color={95,95,95},
      thickness=0.5));
  connect(fixed.frame,relativeVelocity. frame_a) annotation (Line(
      points={{-80,30},{-70,30},{-70,-10},{-30,-10}},
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

  connect(constantSpeed.flange, revolute.flange_a) annotation (Line(points={{-62,60},{-50,60},{-50,40}}, color={0,127,0}));
  connect(fixedTranslation.frame_b, body.frame_a) annotation (Line(
      points={{20,30},{40,30}},
      color={95,95,95},
      thickness=0.5));
  connect(constantSpeed1.flange, prismatic.flange_a) annotation (Line(points={{-10,60},{-20,60},{-20,40}}, color={0,127,0}));
  connect(revolute.frame_b, prismatic.frame_a) annotation (Line(
      points={{-40,30},{-30,30}},
      color={95,95,95},
      thickness=0.5));
  connect(prismatic.frame_b, fixedTranslation.frame_a) annotation (Line(
      points={{-10,30},{-8.88178e-16,30}},
      color={95,95,95},
      thickness=0.5));
  connect(absoluteVelocity.v, mustBeZero.u1) annotation (Line(points={{61,-10},{70,-10},{70,-24},{78,-24}}, color={0,0,127}));
  connect(relativeVelocity.v_rel, mustBeZero.u2) annotation (Line(points={{-20,-21},{-20,-36},{78,-36}}, color={0,0,127}));
  annotation (experiment(StopTime=1));
end Test_resolve2in1_All;
