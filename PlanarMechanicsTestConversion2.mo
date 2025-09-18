within ;
package PlanarMechanicsTestConversion2 "Collection of classes to test proper conversion to PlanarMechanics 2.0.0"
  package Joints
    model Issue169 "Conversion test for issue #169"
      PlanarMechanics.Joints.Prismatic prismatic(
        useFlange=true,
        r={1,0},
        s(fixed=true),
        v(fixed=true)) annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
      PlanarMechanics.Joints.Revolute revolute(
        useFlange=true,
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(extent={{0,-10},{20,10}})));
      inner PlanarMechanics.PlanarWorld planarWorld annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
      PlanarMechanics.Parts.Fixed fixed annotation (Placement(transformation(extent={{-60,-10},{-80,10}})));
      PlanarMechanics.Parts.Body body(
        stateSelect=StateSelect.never,
        m=5,
        I=0.5) annotation (Placement(transformation(extent={{40,-10},{60,10}})));
      Modelica.Mechanics.Translational.Sources.Force2 force annotation (Placement(transformation(extent={{-40,-20},{-20,-40}})));
      Modelica.Mechanics.Rotational.Sources.Torque2 torque annotation (Placement(transformation(extent={{0,-20},{20,-40}})));
      Modelica.Blocks.Sources.Constant const(k=1) annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
    equation
      connect(fixed.frame, prismatic.frame_a) annotation (Line(
          points={{-60,0},{-40,0}},
          color={95,95,95},
          thickness=0.5));
      connect(prismatic.frame_b, revolute.frame_a) annotation (Line(
          points={{-20,0},{0,0}},
          color={95,95,95},
          thickness=0.5));
      connect(revolute.frame_b, body.frame_a) annotation (Line(
          points={{20,0},{40,0}},
          color={95,95,95},
          thickness=0.5));
      connect(force.flange_a, prismatic.support) annotation (Line(points={{-40,-30},{-40,-10},{-36,-10}}, color={0,127,0}));
      connect(force.flange_b, prismatic.flange_a) annotation (Line(points={{-20,-30},{-20,-10},{-30,-10}}, color={0,127,0}));
      connect(torque.flange_a, revolute.support) annotation (Line(points={{0,-30},{0,-10},{4,-10}}, color={0,0,0}));
      connect(torque.flange_b, revolute.flange_a) annotation (Line(points={{20,-30},{20,-10},{10,-10}}, color={0,0,0}));
      connect(const.y, force.f) annotation (Line(points={{-39,-70},{-30,-70},{-30,-34}}, color={0,0,127}));
      connect(const.y, torque.tau) annotation (Line(points={{-39,-70},{10,-70},{10,-34}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
    end Issue169;
  end Joints;

  package Sources
    model Issue191 "Conversion test for issue #191"
      PlanarMechanics.Sources.QuadraticSpeedDependentForce quadraticSpeedDependentForce_frame_a(
        resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a,
        F_nominal=-0.5,
        v_nominal=1,
        tau_nominal=-0.1,
        w_nominal=1,
        diameter=0.02) annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
      PlanarMechanics.Sources.QuadraticSpeedDependentForce quadraticSpeedDependentForce_world(
        F_nominal=-0.5,
        v_nominal=1,
        tau_nominal=-0.1,
        w_nominal=1,
        diameter=0.02,
        resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world) annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
      PlanarMechanics.Sources.QuadraticSpeedDependentForce quadraticSpeedDependentForce_frame_resolve(
        resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve,
        F_nominal=-0.5,
        v_nominal=1,
        tau_nominal=-0.1,
        w_nominal=1,
        diameter=0.02) annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
      PlanarMechanics.Parts.Body body(
        m=5,
        I=0.5,
        r(fixed=true),
        v(fixed=true),
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(extent={{20,-10},{40,10}})));
      inner PlanarMechanics.PlanarWorld planarWorld annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
      PlanarMechanics.Parts.Fixed fixed(phi=0.5235987755983) annotation (Placement(transformation(extent={{-40,-70},{-60,-50}})));
    equation
      connect(quadraticSpeedDependentForce_frame_a.frame_b, body.frame_a) annotation (Line(
          points={{-20,30},{0,30},{0,0},{20,0}},
          color={95,95,95},
          thickness=0.5));
      connect(quadraticSpeedDependentForce_world.frame_b, body.frame_a) annotation (Line(
          points={{-20,0},{20,0}},
          color={95,95,95},
          thickness=0.5));
      connect(quadraticSpeedDependentForce_frame_resolve.frame_b, body.frame_a) annotation (Line(
          points={{-20,-30},{0,-30},{0,0},{20,0}},
          color={95,95,95},
          thickness=0.5));
      connect(fixed.frame, quadraticSpeedDependentForce_frame_resolve.frame_resolve) annotation (Line(
          points={{-40,-60},{-30,-60},{-30,-40}},
          color={95,95,95},
          thickness=0.5));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
    end Issue191;

    model Issue244 "Conversion test for issue #144"
      PlanarMechanics.Sources.RelativeForce relativeForce annotation (Placement(transformation(extent={{-20,20},{0,40}})));
      PlanarMechanics.Sources.WorldForce worldForce annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
      inner PlanarMechanics.PlanarWorld planarWorld annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
      PlanarMechanics.Parts.Fixed fixed annotation (Placement(transformation(extent={{-40,20},{-60,40}})));
      PlanarMechanics.Parts.Body body(
        m=5,
        I=1,
        r(each fixed=true),
        v(each fixed=true),
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(extent={{40,0},{60,20}})));
      Modelica.Blocks.Sources.Constant const[3](each k=1) annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
    equation
      connect(fixed.frame, relativeForce.frame_a) annotation (Line(
          points={{-40,30},{-20,30}},
          color={95,95,95},
          thickness=0.5));
      connect(relativeForce.frame_b, body.frame_a) annotation (Line(
          points={{0,30},{20,30},{20,10},{40,10}},
          color={95,95,95},
          thickness=0.5));
      connect(worldForce.frame_b, body.frame_a) annotation (Line(
          points={{0,-30},{20,-30},{20,10},{40,10}},
          color={95,95,95},
          thickness=0.5));
      connect(const.y, relativeForce.force) annotation (Line(points={{-39,-10},{-16,-10},{-16,18}}, color={0,0,127}));
      connect(const.y, worldForce.force) annotation (Line(points={{-39,-10},{-30,-10},{-30,-30},{-22,-30}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
    end Issue244;
  end Sources;

  package Utilities

    function call_atan3b_issue_149 "Conversion test for issue #149"
      input Real x=0.2;
      output Real y;
    algorithm
     y :=  PlanarMechanics.Utilities.Functions.atan3b(x, x);
    end call_atan3b_issue_149;
  end Utilities;

  package Visualizers
    model Issue189 "Conversion test for issue #189"
      PlanarMechanics.Visualizers.Advanced.DoubleArrow doubleArrow(
        R=Modelica.Mechanics.MultiBody.Frames.nullRotation(),
        r={0,0,0},
        r_tail={0,0,0},
        r_head={0,0,0},
        diameter=planarWorld.defaultArrowDiameter,
        color={155,0,0},
        specularCoefficient=0.7) annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
      PlanarMechanics.Sources.RelativeForce relativeForce(animation=true, diameter=0.03) annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
      PlanarMechanics.Sources.WorldForce worldForce(diameter=0.04) annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
      PlanarMechanics.Sources.QuadraticSpeedDependentForce quadraticSpeedDependentForce(
        F_nominal=-0.5,
        v_nominal=1,
        tau_nominal=-0.1,
        w_nominal=1,
        diameter=0.02) annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
      PlanarMechanics.Sensors.CutForce cutForce(forceDiameter=0.03) annotation (Placement(transformation(extent={{0,50},{20,70}})));
      PlanarMechanics.Sensors.CutTorque cutTorque(torqueDiameter=0.02) annotation (Placement(transformation(extent={{0,10},{20,30}})));
      PlanarMechanics.Sensors.CutForceAndTorque cutForceAndTorque(forceDiameter=0.02, torqueDiameter=0.03) annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
      inner PlanarMechanics.PlanarWorld planarWorld annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
      PlanarMechanics.Parts.Body body(
        m=5,
        I=0.5,
        r(fixed=true),
        v(fixed=true),
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(extent={{60,10},{80,30}})));
      PlanarMechanics.Parts.Fixed fixed annotation (Placement(transformation(extent={{-60,50},{-80,70}})));
      Modelica.Blocks.Sources.Constant const[3](each k=1) annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
    equation
      connect(relativeForce.frame_b, cutForce.frame_a) annotation (Line(
          points={{-20,60},{0,60}},
          color={95,95,95},
          thickness=0.5));
      connect(worldForce.frame_b, cutTorque.frame_a) annotation (Line(
          points={{-20,20},{0,20}},
          color={95,95,95},
          thickness=0.5));
      connect(quadraticSpeedDependentForce.frame_b, cutForceAndTorque.frame_a) annotation (Line(
          points={{-20,-20},{0,-20}},
          color={95,95,95},
          thickness=0.5));
      connect(cutForce.frame_b, body.frame_a) annotation (Line(
          points={{20,60},{40,60},{40,20},{60,20}},
          color={95,95,95},
          thickness=0.5));
      connect(cutTorque.frame_b, body.frame_a) annotation (Line(
          points={{20,20},{60,20}},
          color={95,95,95},
          thickness=0.5));
      connect(cutForceAndTorque.frame_b, body.frame_a) annotation (Line(
          points={{20,-20},{40,-20},{40,20},{60,20}},
          color={95,95,95},
          thickness=0.5));
      connect(fixed.frame, relativeForce.frame_a) annotation (Line(
          points={{-60,60},{-40,60}},
          color={95,95,95},
          thickness=0.5));
      connect(const.y, relativeForce.force) annotation (Line(points={{-59,20},{-50,20},{-50,40},{-36,40},{-36,48}}, color={0,0,127}));
      connect(const.y, worldForce.force) annotation (Line(points={{-59,20},{-42,20}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
    end Issue189;
  end Visualizers;
  annotation (uses(PlanarMechanics(version="1.6.0"), Modelica(version="4.0.0")));
end PlanarMechanicsTestConversion2;
