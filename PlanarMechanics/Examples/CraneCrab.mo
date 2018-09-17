within PlanarMechanics.Examples;
model CraneCrab "A damped crane crab"
  extends Modelica.Icons.Example;

  Parts.Body body(
    I=0.1,
    m=0.5) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,-60})));
  Parts.FixedTranslation fixedTranslation(r={0,-1}) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,-30})));
  Parts.Fixed fixed annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-70,30})));
  Parts.Body body1(
    m=1,
    I=0.1)
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  inner PlanarWorld planarWorld
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  Joints.Revolute revolute(w(fixed=true), phi(fixed=true, start=2.6179938779915))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,0})));
  Joints.Prismatic prismatic(
    r={1,0},
    v(fixed=true),
    useFlange=true,
    s(fixed=true, start=0),
    animate=true)
    annotation (Placement(transformation(extent={{-40,40},{-20,20}})));
  Modelica.Mechanics.Translational.Components.Damper damper1D(d=10)
    annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
equation
  connect(fixedTranslation.frame_b, body.frame_a) annotation (Line(
      points={{-10,-40},{-10,-50}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute.frame_a, body1.frame_a) annotation (Line(
      points={{-10,10},{-10,30},{0,30}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute.frame_b, fixedTranslation.frame_a) annotation (Line(
      points={{-10,-10},{-10,-20}},
      color={95,95,95},
      thickness=0.5));
  connect(fixed.frame, prismatic.frame_a) annotation (Line(
      points={{-60,30},{-40,30}},
      color={95,95,95},
      thickness=0.5));
  connect(prismatic.frame_b, body1.frame_a) annotation (Line(
      points={{-20,30},{0,30}},
      color={95,95,95},
      thickness=0.5));
  connect(damper1D.flange_b, prismatic.flange_a)
    annotation (Line(points={{-20,60},{-20,40},{-30,40}},
                                                 color={0,127,0}));
  connect(damper1D.flange_a, prismatic.support)
    annotation (Line(points={{-40,60},{-40,40},{-36,40}}, color={0,127,0}));
  annotation (experiment(StopTime=10),
    Documentation(revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<b>Developed 2010-2018 at the DLR Institute of System Dynamics and Control</b>
</p>
</html>",  info="<html>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/Examples/CraneCrab_1.png\" alt=\"Diagram CraneCrab_1\"></p>
<p>Selected continuous time states</p>
<ul>
<li>prismatic.s</li>
<li>prismatic.v</li>
<li>revolute.phi</li>
<li>revolute.w</li>
</ul>
</html>"));
end CraneCrab;
