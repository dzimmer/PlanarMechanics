within PlanarMechanics.Examples;
model CraneCrabTo3D "A damped crane crab"
  extends Modelica.Icons.Example;

  Parts.Body body(
    I=0.1,
    m=0.5) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,-60})));
  Parts.FixedTranslation fixedTranslation(r={0,-1}) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,-30})));
  Parts.Fixed fixed annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-10,30})));
  Parts.Body body1(
    m=1,
    I=0.1)
    annotation (Placement(transformation(extent={{60,20},{80,40}})));
  inner PlanarWorldIn3D planarWorld(
    connectToMultiBody=true,
    inheritGravityFromMultiBody=true,
    constantGravity={0,0})
    annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
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
  Modelica.Mechanics.Translational.Components.Fixed fixed1D annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-6,60})));
  Modelica.Mechanics.Translational.Components.Damper damper1D(d=10)
    annotation (Placement(transformation(extent={{10,50},{30,70}})));
  inner MB.World world(n={0,-1,0})
    annotation (Placement(transformation(extent={{-90,-80},{-70,-60}})));
  MB.Joints.Prismatic prismatic1(
    n={0,0,1},
    s(fixed=true, start=-0.2),
    useAxisFlange=false,
    v(fixed=true, start=0.2)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-52,-26})));
  MB.Parts.Body body2 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-52,20})));
  MB.Parts.FixedRotation fixedRotation(n={0,1,0}, angle=45)
    annotation (Placement(transformation(extent={{-52,-78},{-32,-58}})));
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
  connect(damper1D.flange_a, fixed1D.flange)
    annotation (Line(points={{10,60},{-6,60}},   color={0,127,0}));
  connect(damper1D.flange_b, prismatic.flange_a)
    annotation (Line(points={{30,60},{30,39}},   color={0,127,0}));
  connect(body2.frame_a, prismatic1.frame_b) annotation (Line(
      points={{-52,10},{-52,-16}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(planarWorld.MBFrame_a, prismatic1.frame_b) annotation (Line(
      points={{-20.2,-10},{-52,-10},{-52,-16}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(fixedRotation.frame_a, world.frame_b) annotation (Line(
      points={{-52,-68},{-60,-68},{-60,-70},{-70,-70}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(fixedRotation.frame_b, prismatic1.frame_a) annotation (Line(
      points={{-32,-68},{-18,-68},{-18,-36},{-52,-36}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (experiment(StopTime=10),
    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p></html>",  info="<html>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/CraneCrab_1.png\"/></p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/CraneCrab_2.png\"/></p>
<p>Selected continuous time states</p>
<ul>
<li>prismatic.s</li>
<li>prismatic.v</li>
<li>revolute.phi</li>
<li>revolute.w</li>
</ul>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics));
end CraneCrabTo3D;
