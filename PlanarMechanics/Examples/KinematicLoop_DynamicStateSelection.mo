within PlanarMechanics.Examples;
model KinematicLoop_DynamicStateSelection "An example of a kinematic loop"
  extends Modelica.Icons.Example;

  Joints.Revolute revolute                        annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,40})));
  Joints.Revolute revolute1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,40})));
  Joints.Revolute revolute2
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  Joints.Revolute revolute3(phi(fixed=true, start=-0.69813170079773), w(fixed=
          true, start=0))
                 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,-40})));
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
  Parts.Body body(
    m=1,
    I=0.1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={50,-60})));
  Parts.Fixed fixed annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-50,60})));
  Modelica.Mechanics.Translational.Components.SpringDamper springDamper(
    c=20,
    s_rel0=0.4,
    d=4) annotation (Placement(transformation(extent={{0,80},{20,100}})));
  Modelica.Mechanics.Translational.Components.Fixed fixed1 annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-46,90})));
  inner PlanarWorld planarWorld
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  Joints.Prismatic prismatic1(
    r={1,0},
    useFlange=true,
    s(fixed=true, start=0.4),
    v(fixed=true, start=0))
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
equation
  connect(fixedTranslation1.frame_a, revolute.frame_b) annotation (Line(
      points={{-20,20},{-20,30}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation2.frame_a, revolute1.frame_b) annotation (Line(
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
  connect(fixedTranslation3.frame_a, revolute3.frame_b) annotation (Line(
      points={{0,-60},{-20,-60},{-20,-50}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute.frame_a, fixed.frame_a) annotation (Line(
      points={{-20,50},{-20,60},{-40,60}},
      color={95,95,95},
      thickness=0.5));
  connect(fixed1.flange, springDamper.flange_a) annotation (Line(
      points={{-46,90},{0,90}},
      color={0,127,0}));
  connect(revolute3.frame_a, fixedTranslation1.frame_b) annotation (Line(
      points={{-20,-30},{-20,-15},{-20,0}},
      color={95,95,95},
      thickness=0.5));
  connect(body.frame_a, fixedTranslation3.frame_b) annotation (Line(
      points={{40,-60},{20,-60}},
      color={95,95,95},
      thickness=0.5));
  connect(fixed.frame_a, prismatic1.frame_a) annotation (Line(
      points={{-40,60},{20,60}},
      color={95,95,95},
      thickness=0.5));
  connect(prismatic1.frame_b, revolute1.frame_a) annotation (Line(
      points={{40,60},{80,60},{80,50}},
      color={95,95,95},
      thickness=0.5));
  connect(springDamper.flange_b, prismatic1.flange_a) annotation (Line(
      points={{20,90},{30,90},{30,69}},
      color={0,127,0}));
  annotation (experiment(StopTime=6),
    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p></html>",  info="<html>
<p>In this version, the states are not manually set but might be dynamically selected by the simulation environment.</p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/KinematicLoop_1.png\"></p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/KinematicLoop_2.png\"></p>
<p>Selected continuous time states</p>
<ul>
<li>revolute3.phi</li>
<li>revolute3.w</li>
<li>There are 2&nbsp;sets of dynamic state selection.</li>
<ul>
<li>From set&nbsp;1 there is 1&nbsp;state to be selected from:</li>
<ul>
<li>actuatedPrismatic.s</li>
<li>revolute.phi</li>
<li>revolute2.phi</li>
</ul>
<li>From set&nbsp;2 there is 1&nbsp;state to be selected from:</li>
<ul>
<li>actuatedPrismatic.v</li>
<li>revolute.w</li>
<li>revolute2.w</li>
</ul>
</ul>
</ul>
</html>",
      revisions="<html>
<p>(c) Copyright by Dirk Zimmer</p>
<p>The library was created and is owned by Dr. Dirk Zimmer.</p>
<p>dirk.zimmer@dlr.de</p>
</html>"));
end KinematicLoop_DynamicStateSelection;
