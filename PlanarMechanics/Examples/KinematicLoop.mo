within PlanarMechanics.Examples;
model KinematicLoop "An example of a kinematic loop (manual state selection)"
  extends Modelica.Icons.Example;

  Joints.Revolute revolute1(
    extraLine=true,
    phi(start=Modelica.Math.asin(0.4/0.5/2)),
    stateSelect=StateSelect.always) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,40})));
  Joints.Revolute revolute3(
    phi(start=-Modelica.Math.asin(0.4/0.5/2)))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,40})));
  Joints.Revolute revolute2
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  Joints.Revolute revolute4(
    w(fixed=true, start=0),
    cylinderLength=planarWorld.defaultJointLength*1.5,
    cylinderDiameter=planarWorld.defaultJointWidth/2,
    cylinderColor={155,0,0},
    extraLine=true,
    stateSelect=StateSelect.always,
    phi(fixed=true, start=-0.69813170079773))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,-40})));
  Joints.Prismatic prismatic1(
    r={1,0},
    useFlange=true,
    s(start=0.4, fixed=true),
    v(start=0, fixed=true))
    annotation (Placement(transformation(extent={{20,70},{40,50}})));
  Modelica.Mechanics.Translational.Components.SpringDamper springDamper1D(
    c=20,
    d=4,
    s_rel0=0.4) annotation (Placement(transformation(extent={{0,80},{20,100}})));
  Parts.Body body(
    m=1,
    I=0.1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={50,-60})));
  Parts.FixedTranslation fixedTranslation1(r={0, -0.5}) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,10})));
  Parts.FixedTranslation fixedTranslation2(r={0, -0.5}) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,10})));
  Parts.FixedTranslation fixedTranslation3(r={0, -0.6}) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={10,-60})));
  Parts.Fixed fixed annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-50,60})));
  Modelica.Mechanics.Translational.Components.Fixed fixed1D annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-46,90})));
  inner PlanarWorld planarWorld
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
equation
  connect(fixedTranslation1.frame_a, revolute1.frame_b) annotation (Line(
      points={{-20,20},{-20,30}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation2.frame_a,revolute3. frame_b) annotation (Line(
      points={{80,20},{80,30}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute2.frame_a, fixedTranslation1.frame_b) annotation (Line(
      points={{20,-10},{-20,-10},{-20,0}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute2.frame_b, fixedTranslation2.frame_b) annotation (Line(
      points={{40,-10},{80,-10},{80,0}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation3.frame_a,revolute4. frame_b) annotation (Line(
      points={{0,-60},{-20,-60},{-20,-50}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute1.frame_a, fixed.frame) annotation (Line(
      points={{-20,50},{-20,60},{-40,60}},
      color={95,95,95},
      thickness=0.5));
  connect(fixed1D.flange, springDamper1D.flange_a)
    annotation (Line(points={{-46,90},{0,90}}, color={0,127,0}));
  connect(revolute4.frame_a, fixedTranslation1.frame_b) annotation (Line(
      points={{-20,-30},{-20,-16},{-20,0}},
      color={95,95,95},
      thickness=0.5));
  connect(body.frame_a, fixedTranslation3.frame_b) annotation (Line(
      points={{40,-60},{30,-60},{20,-60}},
      color={95,95,95},
      thickness=0.5));
  connect(prismatic1.frame_a, fixed.frame) annotation (Line(
      points={{20,60},{-40,60}},
      color={95,95,95},
      thickness=0.5));
  connect(springDamper1D.flange_b, prismatic1.flange_a)
    annotation (Line(points={{20,90},{30,90},{30,70}}, color={0,127,0}));
  connect(prismatic1.frame_b,revolute3. frame_a) annotation (Line(
      points={{40,60},{80,60},{80,50}},
      color={95,95,95},
      thickness=0.5));
  annotation (experiment(StopTime=6),
    Documentation(revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>",  info="<html>
<p>In this version, the states are manually selected.</p>
<div>
<img src=\"modelica://PlanarMechanics/Resources/Images/Examples/KinematicLoop_1.png\" alt=\"Diagram KinematicLoop_1\">
</div>
<div>
<img src=\"modelica://PlanarMechanics/Resources/Images/Examples/KinematicLoop_2.png\" alt=\"Diagram KinematicLoop_2\">
</div>
<p>Selected continuous time states</p>
<ul>
  <li>revolute1.phi</li>
  <li>revolute1.w</li>
  <li>revolute4.phi</li>
  <li>revolute4.w</li>
</ul>
</html>"));
end KinematicLoop;
