within PlanarMechanics.Examples;
model CraneCrabTo3Da "A planar damped crane crab in the multi-body world - case a)"
  extends Modelica.Icons.Example;

  MB.Parts.Body body3D(r_CM=zeros(3), m=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,-20})));
  Parts.Body body1(
    m=1,
    I=0.1)
    annotation (Placement(transformation(extent={{70,0},{90,20}})));
  Parts.Body body2(I=0.1, m=0.5) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-82})));
  MB.Joints.Prismatic prismatic3D(
    s(fixed=true, start=-0.2),
    useAxisFlange=false,
    v(fixed=true, start=0.2),
    n={1,0,0},
    stateSelect=StateSelect.always)
               annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-20,10})));
  Joints.Prismatic prismatic(
    r={1,0},
    v(fixed=true),
    useFlange=true,
    s(fixed=true, start=0),
    animate=true,
    stateSelect=StateSelect.always)
    annotation (Placement(transformation(extent={{20,20},{40,0}})));
  Joints.Revolute revolute(w(fixed=true),
    stateSelect=StateSelect.always,
    phi(fixed=true, start=2.6179938779915))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-20})));
  Modelica.Mechanics.Translational.Components.Damper damper1D(d=10)
    annotation (Placement(transformation(extent={{20,30},{40,50}})));
  MB.Parts.FixedRotation fixedRotation3D(n={0,1,0}, angle=45) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-60,10})));
  Parts.FixedTranslation fixedTranslation(r={0,-1}) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-50})));
  inner PlanarWorldIn3D planarWorld(
    inheritGravityFromMultiBody=true,
    constantGravity={0,0},
    animateGravity=false,
    enableAnimation=true,
    connectToMultiBody=true)
    annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
  inner MB.World world(n={0,-1,0})
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Interfaces.PlanarTo3D adaptor3DtoPlanar annotation (Placement(transformation(extent={{6,8},{14,12}})));
equation
  connect(fixedTranslation.frame_b, body2.frame_a) annotation (Line(
      points={{60,-60},{60,-72}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute.frame_a, body1.frame_a) annotation (Line(
      points={{60,-10},{60,10},{70,10}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute.frame_b, fixedTranslation.frame_a) annotation (Line(
      points={{60,-30},{60,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(prismatic.frame_b, body1.frame_a) annotation (Line(
      points={{40,10},{70,10}},
      color={95,95,95},
      thickness=0.5));
  connect(damper1D.flange_b, prismatic.flange_a)
    annotation (Line(points={{40,40},{40,20},{30,20}},
                                                 color={0,127,0}));
  connect(body3D.frame_a, prismatic3D.frame_b) annotation (Line(
      points={{0,-10},{0,10},{-10,10}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedRotation3D.frame_a, world.frame_b) annotation (Line(
      points={{-70,10},{-80,10}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedRotation3D.frame_b, prismatic3D.frame_a) annotation (Line(
      points={{-50,10},{-30,10}},
      color={95,95,95},
      thickness=0.5));
  connect(damper1D.flange_a, prismatic.support) annotation (Line(points={{20,40},{20,20},{24,20}},
                                    color={0,127,0}));
  connect(prismatic.frame_a, adaptor3DtoPlanar.framePlanar) annotation (Line(
      points={{20,10},{14,10}},
      color={95,95,95},
      thickness=0.5));
  connect(planarWorld.MBFrame_a, fixedRotation3D.frame_b) annotation (Line(
      points={{-30,40},{-40,40},{-40,10},{-50,10}},
      color={95,95,95},
      thickness=0.5));
  connect(adaptor3DtoPlanar.frameMultiBody, prismatic3D.frame_b) annotation (Line(
      points={{6,10},{-10,10}},
      color={95,95,95},
      thickness=0.5));
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
    Diagram(graphics={Rectangle(
          extent={{10,64},{98,-94}},
          lineColor={28,108,200},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.Dash), Text(
          extent={{-34,4},{34,-4}},
          lineColor={238,46,47},
          pattern=LinePattern.Dash,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          fontSize=20,
          textString="Planar mechanics",
          origin={86,-50},
          rotation=90)}));
end CraneCrabTo3Da;
