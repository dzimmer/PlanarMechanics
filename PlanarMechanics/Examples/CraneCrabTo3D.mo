within PlanarMechanics.Examples;
model CraneCrabTo3D "A damped crane crab"
  extends Modelica.Icons.Example;

  Parts.Body body(
    I=0.1,
    m=0.5) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,-60})));
  Parts.Body body1(
    m=1,
    I=0.1)
    annotation (Placement(transformation(extent={{60,20},{80,40}})));
  Parts.FixedTranslation fixedTranslation(r={0,-1}) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,-30})));
  Parts.Fixed fixed annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-10,30})));
  inner PlanarWorldIn3D planarWorld(
    inheritGravityFromMultiBody=true,
    constantGravity={0,0},
    animateGravity=false,
    enableAnimation=true,
    connectToMultiBody=true)
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Joints.Revolute revolute(w(fixed=true), phi(fixed=true, start=2.6179938779915))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,0})));
  Joints.Prismatic prismatic(
    r={1,0},
    v(fixed=true),
    useFlange=true,
    s(fixed=true, start=0),
    animate=true)
    annotation (Placement(transformation(extent={{20,40},{40,20}})));
  Modelica.Mechanics.Translational.Components.Damper damper1D(d=10)
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
  inner MB.World world(n={0,-1,0})
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  MB.Joints.Prismatic prismatic3D(
    s(fixed=true, start=-0.2),
    useAxisFlange=false,
    v(fixed=true, start=0.2),
    n={1,0,0}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-30,-50})));
  MB.Parts.Body body3D(r_CM=zeros(3), m=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-10,-20})));
  MB.Parts.FixedRotation fixedRotation3D(n={0,1,0}, angle=45) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-60,-50})));
equation
  connect(fixedTranslation.frame_b, body.frame_a) annotation (Line(
      points={{50,-40},{50,-50}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute.frame_a, body1.frame_a) annotation (Line(
      points={{50,10},{50,30},{60,30}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute.frame_b, fixedTranslation.frame_a) annotation (Line(
      points={{50,-10},{50,-20}},
      color={95,95,95},
      thickness=0.5));
  connect(fixed.frame, prismatic.frame_a) annotation (Line(
      points={{0,30},{20,30}},
      color={95,95,95},
      thickness=0.5));
  connect(prismatic.frame_b, body1.frame_a) annotation (Line(
      points={{40,30},{60,30}},
      color={95,95,95},
      thickness=0.5));
  connect(damper1D.flange_b, prismatic.flange_a)
    annotation (Line(points={{40,60},{40,40},{30,40}},
                                                 color={0,127,0}));
  connect(body3D.frame_a, prismatic3D.frame_b) annotation (Line(
      points={{-10,-30},{-10,-50},{-20,-50}},
      color={95,95,95},
      thickness=0.5));
  connect(planarWorld.MBFrame_a, prismatic3D.frame_b) annotation (Line(
      points={{0,-50},{-20,-50}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedRotation3D.frame_a, world.frame_b) annotation (Line(
      points={{-70,-50},{-80,-50}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedRotation3D.frame_b, prismatic3D.frame_a) annotation (Line(
      points={{-50,-50},{-40,-50}},
      color={95,95,95},
      thickness=0.5));
  connect(damper1D.flange_a, prismatic.support) annotation (Line(points={{20,60},
          {20,60},{20,40},{24,40}}, color={0,127,0}));
  annotation (experiment(StopTime=10),
    Documentation(revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010-2020 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>",  info="<html>
<div>
<img src=\"modelica://PlanarMechanics/Resources/Images/Examples/CraneCrab_1.png\" alt=\"Diagram CraneCrab_1\">
</div>
<p>Selected continuous time states</p>
<ul>
<li>prismatic.s</li>
<li>prismatic.v</li>
<li>revolute.phi</li>
<li>revolute.w</li>
</ul>
</html>"));
end CraneCrabTo3D;
