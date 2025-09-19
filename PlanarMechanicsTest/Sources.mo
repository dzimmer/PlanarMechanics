within PlanarMechanicsTest;
package Sources "Test models for PlanarMechanics.Sources"
  extends Modelica.Icons.Package;

  model RelativeForce "Test relative force"
    extends Modelica.Icons.Example;

    PlanarMechanics.Parts.Body body(
      m=1,
      I=0.1) annotation (Placement(transformation(extent={{50,40},{70,60}})));
    PlanarMechanics.Sources.RelativeForce relativeForce_inWorld(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.world) annotation (Placement(transformation(extent={{0,10},{20,30}})));
    PlanarMechanics.Sources.RelativeForce relativeForce_inFrameA(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a) annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
    PlanarMechanics.Sources.RelativeForce relativeForce_inFrameB(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_b) annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
    PlanarMechanics.Sources.RelativeForce relativeForce_inFrameResolve(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve) annotation (Placement(transformation(extent={{0,-20},{20,0}})));
    PlanarMechanics.Joints.Revolute revolute(
      useFlange=true,
      phi(fixed=true, start=0.34906585039887),
      w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-30,60},{-10,40}})));
    PlanarMechanics.Parts.FixedTranslation fixedTranslation(
      r={0,-1}) annotation (Placement(transformation(extent={{0,40},{20,60}})));
    PlanarMechanics.Parts.Fixed fixed(
      phi=0) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={-50,50})));
    inner PlanarMechanics.PlanarWorld planarWorld(
      defaultWidthFraction=10,
      defaultN_to_m=1,
      defaultNm_to_m=1) annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
    Modelica.Blocks.Sources.Sine signalVec2[2](
      each f=1,
      amplitude={1,0},
      each startTime=0.8) "Vector of three excitation signals"
      annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
    Modelica.Blocks.Sources.Sine signalTorque(
      each f=1,
      amplitude=1,
      each startTime=0.8) "Torque signal" annotation (Placement(transformation(extent={{80,-100},{60,-80}})));
    PlanarMechanics.Parts.Fixed fixedRotated(
      r={0,-1},
      phi=0.29670597283904) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={-50,-30})));
    Modelica.Mechanics.Rotational.Components.Damper damper(
      d=0.1)
      annotation (Placement(transformation(extent={{-30,80},{-10,100}})));
  equation
    connect(revolute.frame_b, fixedTranslation.frame_a) annotation (Line(
        points={{-10,50},{0,50}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedTranslation.frame_b, body.frame_a) annotation (Line(
        points={{20,50},{50,50}},
        color={95,95,95},
        thickness=0.5));
    connect(revolute.frame_a, fixed.frame) annotation (Line(
        points={{-30,50},{-40,50}},
        color={95,95,95},
        thickness=0.5));
    connect(signalVec2.y, relativeForce_inFrameA.force) annotation (Line(points={{-59,-90},{-10,-90},{-10,-56},{4,-56},{4,-52}}, color={0,0,127}));
    connect(signalTorque.y, relativeForce_inFrameA.torque) annotation (Line(points={{59,-90},{30,-90},{30,-56},{10,-56},{10,-52}},  color={0,0,127}));
    connect(relativeForce_inFrameA.frame_b, body.frame_a) annotation (Line(
        points={{20,-40},{40,-40},{40,50},{50,50}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedRotated.frame, relativeForce_inFrameA.frame_a) annotation (Line(
        points={{-40,-30},{-20,-30},{-20,-40},{0,-40}},
        color={95,95,95},
        thickness=0.5));
    connect(relativeForce_inFrameResolve.frame_b, body.frame_a) annotation (Line(
        points={{20,-10},{40,-10},{40,50},{50,50}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedRotated.frame, relativeForce_inFrameResolve.frame_a) annotation (Line(
        points={{-40,-30},{-20,-30},{-20,-10},{0,-10}},
        color={95,95,95},
        thickness=0.5));
    connect(signalVec2.y, relativeForce_inFrameResolve.force) annotation (Line(points={{-59,-90},{-10,-90},{-10,-26},{4,-26},{4,-22}},   color={0,0,127}));
    connect(signalTorque.y, relativeForce_inFrameResolve.torque) annotation (Line(points={{59,-90},{30,-90},{30,-26},{10,-26},{10,-22}},    color={0,0,127}));
    connect(body.frame_a, relativeForce_inFrameResolve.frame_resolve) annotation (Line(
        points={{50,50},{40,50},{40,-20},{16,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(signalVec2.y, relativeForce_inFrameB.force) annotation (Line(points={{-59,-90},{4,-90},{4,-82}}, color={0,0,127}));
    connect(signalTorque.y, relativeForce_inFrameB.torque) annotation (Line(points={{59,-90},{10,-90},{10,-82}},color={0,0,127}));
    connect(relativeForce_inFrameB.frame_b, body.frame_a) annotation (Line(
        points={{20,-70},{40,-70},{40,50},{50,50}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedRotated.frame, relativeForce_inFrameB.frame_a) annotation (Line(
        points={{-40,-30},{-20,-30},{-20,-70},{0,-70}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedRotated.frame, relativeForce_inWorld.frame_a) annotation (Line(
        points={{-40,-30},{-20,-30},{-20,20},{0,20}},
        color={95,95,95},
        thickness=0.5));
    connect(signalVec2.y, relativeForce_inWorld.force) annotation (Line(points={{-59,-90},{-10,-90},{-10,4},{4,4},{4,8}},    color={0,0,127}));
    connect(signalTorque.y, relativeForce_inWorld.torque) annotation (Line(points={{59,-90},{30,-90},{30,4},{10,4},{10,8}},     color={0,0,127}));
    connect(relativeForce_inWorld.frame_b, body.frame_a) annotation (Line(
        points={{20,20},{40,20},{40,50},{50,50}},
        color={95,95,95},
        thickness=0.5));
    connect(damper.flange_b, revolute.axis) annotation (Line(points={{-10,90},{-10,70},{-20,70},{-20,60}}));
    connect(revolute.support, damper.flange_a) annotation (Line(points={{-26,60},{-26,70},{-30,70},{-30,90}}));
    annotation (
      experiment(StopTime=3));
  end RelativeForce;

  model SpeedDependentForce "Test quadratic speed dependent force"
    extends Modelica.Icons.Example;

    PlanarMechanics.Sources.QuadraticSpeedDependentForce force_inWorld(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.world,
      F_nominal=0.15,
      v_nominal=1,
      tau_nominal=0,
      w_nominal=1) annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
    PlanarMechanics.Sources.QuadraticSpeedDependentForce force_inFrameA(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_b,
      F_nominal=0.15,
      v_nominal=1,
      tau_nominal=0,
      w_nominal=1) annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
    PlanarMechanics.Sources.QuadraticSpeedDependentForce force_inFrameResolve(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_resolve,
      F_nominal=0.15,
      v_nominal=1,
      tau_nominal=0,
      w_nominal=1) annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
    PlanarMechanics.Parts.Body body(
      m=1,
      I=0.1) annotation (Placement(transformation(extent={{30,10},{50,30}})));
    PlanarMechanics.Joints.Revolute revolute(
      useFlange=true,
      phi(fixed=true, start=0.34906585039887),
      w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-40,30},{-20,10}})));
    PlanarMechanics.Parts.FixedTranslation fixedTranslation(
      r={0,-1}) annotation (Placement(transformation(extent={{-10,10},{10,30}})));
    PlanarMechanics.Parts.Fixed fixed(
      phi=0) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={-60,20})));
    inner PlanarMechanics.PlanarWorld planarWorld(
      defaultWidthFraction=10,
      defaultN_to_m=1,
      defaultNm_to_m=1) annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
    Modelica.Mechanics.Rotational.Components.Damper damper(
      d=0.1)
      annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
    PlanarMechanics.Parts.Fixed fixedRotated(
      r={0,-1},
      phi=0.29670597283904) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={-60,-80})));
  equation
    connect(revolute.frame_b, fixedTranslation.frame_a) annotation (Line(
        points={{-20,20},{-10,20}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedTranslation.frame_b, body.frame_a) annotation (Line(
        points={{10,20},{30,20}},
        color={95,95,95},
        thickness=0.5));
    connect(revolute.frame_a, fixed.frame) annotation (Line(
        points={{-40,20},{-50,20}},
        color={95,95,95},
        thickness=0.5));
    connect(force_inFrameResolve.frame_b, body.frame_a) annotation (Line(
        points={{10,-70},{20,-70},{20,20},{30,20}},
        color={95,95,95},
        thickness=0.5));
    connect(force_inWorld.frame_b, body.frame_a) annotation (Line(
        points={{10,-10},{20,-10},{20,20},{30,20}},
        color={95,95,95},
        thickness=0.5));
    connect(force_inFrameA.frame_b, body.frame_a) annotation (Line(
        points={{10,-40},{20,-40},{20,20},{30,20}},
        color={95,95,95},
        thickness=0.5));
    connect(damper.flange_b, revolute.axis) annotation (Line(points={{-20,60},{-20,40},{-30,40},{-30,30}}));
    connect(revolute.support, damper.flange_a) annotation (Line(points={{-36,30},{-36,40},{-40,40},{-40,60}}));
    connect(fixedRotated.frame, force_inFrameResolve.frame_resolve) annotation (Line(
        points={{-50,-80},{0,-80}},
        color={95,95,95},
        thickness=0.5));
    annotation (
      experiment(StopTime=3));
  end SpeedDependentForce;

  model WolrdForce "Test world force"
    extends Modelica.Icons.Example;

    PlanarMechanics.Sources.WorldForce force_inWorld(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.world) annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
    PlanarMechanics.Sources.WorldForce force_inFrameA(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_b) annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
    PlanarMechanics.Sources.WorldForce force_inFrameResolve(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_resolve)
      annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
    PlanarMechanics.Parts.Body body(
      m=1,
      I=0.1) annotation (Placement(transformation(extent={{30,10},{50,30}})));
    PlanarMechanics.Joints.Revolute revolute(
      useFlange=true,
      phi(fixed=true, start=0.34906585039887),
      w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-40,30},{-20,10}})));
    PlanarMechanics.Parts.FixedTranslation fixedTranslation(
      r={0,-1}) annotation (Placement(transformation(extent={{-10,10},{10,30}})));
    PlanarMechanics.Parts.Fixed fixed(
      phi=0) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={-60,20})));
    inner PlanarMechanics.PlanarWorld planarWorld(
      defaultWidthFraction=10,
      defaultN_to_m=1,
      defaultNm_to_m=1) annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
    Modelica.Blocks.Sources.Sine signalVec2[2](
      each f=signalTorque.f,
      amplitude={1,0},
      each startTime=signalTorque.startTime) "Vector of force signals"
      annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
    Modelica.Blocks.Sources.Sine signalTorque(
      f=1,
      amplitude=1,
      startTime=0.8) "Torque signal" annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
    Modelica.Mechanics.Rotational.Components.Damper damper(
      d=0.1)
      annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
    PlanarMechanics.Parts.Fixed fixedRotated(
      r={0,-1},
      phi=0.29670597283904) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={-50,-80})));
  equation
    connect(revolute.frame_b, fixedTranslation.frame_a) annotation (Line(
        points={{-20,20},{-10,20}},
        color={95,95,95},
        thickness=0.5));
    connect(fixedTranslation.frame_b, body.frame_a) annotation (Line(
        points={{10,20},{30,20}},
        color={95,95,95},
        thickness=0.5));
    connect(revolute.frame_a, fixed.frame) annotation (Line(
        points={{-40,20},{-50,20}},
        color={95,95,95},
        thickness=0.5));
    connect(force_inFrameResolve.frame_b, body.frame_a) annotation (Line(
        points={{10,-70},{20,-70},{20,20},{30,20}},
        color={95,95,95},
        thickness=0.5));
    connect(force_inWorld.frame_b, body.frame_a) annotation (Line(
        points={{10,-10},{20,-10},{20,20},{30,20}},
        color={95,95,95},
        thickness=0.5));
    connect(force_inFrameA.frame_b, body.frame_a) annotation (Line(
        points={{10,-40},{20,-40},{20,20},{30,20}},
        color={95,95,95},
        thickness=0.5));
    connect(signalVec2.y, force_inWorld.force) annotation (Line(points={{-39,-20},{-30,-20},{-30,-10},{-12,-10}}, color={0,0,127}));
    connect(signalVec2.y, force_inFrameA.force) annotation (Line(points={{-39,-20},{-30,-20},{-30,-40},{-12,-40}},
                                                                                               color={0,0,127}));
    connect(signalVec2.y, force_inFrameResolve.force) annotation (Line(points={{-39,-20},{-30,-20},{-30,-70},{-12,-70}}, color={0,0,127}));
    connect(damper.flange_b, revolute.axis) annotation (Line(points={{-20,60},{-20,40},{-30,40},{-30,30}}));
    connect(revolute.support, damper.flange_a) annotation (Line(points={{-36,30},{-36,40},{-40,40},{-40,60}}));
    connect(fixedRotated.frame, force_inFrameResolve.frame_resolve) annotation (Line(
        points={{-40,-80},{0,-80}},
        color={95,95,95},
        thickness=0.5));
    connect(signalTorque.y, force_inWorld.torque) annotation (Line(points={{-39,-50},{-26,-50},{-26,-16},{-12,-16}}, color={0,0,127}));
    connect(signalTorque.y, force_inFrameA.torque) annotation (Line(points={{-39,-50},{-26,-50},{-26,-46},{-12,-46}}, color={0,0,127}));
    connect(signalTorque.y, force_inFrameResolve.torque) annotation (Line(points={{-39,-50},{-26,-50},{-26,-76},{-12,-76}}, color={0,0,127}));
    annotation (
      experiment(StopTime=3));
  end WolrdForce;
end Sources;
