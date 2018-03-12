within PlanarMechanics.Examples;
model CraneCrabTo3Dd "A planar damped crane crab in the 3D world - case d)"
  extends Modelica.Icons.Example;

  MB.Parts.Body body2(r_CM=zeros(3), m=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={90,20})));
  Parts.Body body1(m=1, I=0.001) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={10,-10})));
  Parts.Body body3(I=0.1, m=0.5) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={70,-82})));
  MB.Joints.Prismatic prismatic2(
    s(fixed=true, start=-0.2),
    v(fixed=true, start=0.2),
    n={1,0,0},
    stateSelect=StateSelect.always,
    useAxisFlange=true) annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={50,20})));
  Joints.Prismatic prismatic1(
    r={1,0},
    v(fixed=true),
    s(fixed=true, start=0),
    animate=true,
    stateSelect=StateSelect.always,
    useFlange=false) annotation (Placement(transformation(extent={{-20,30},{0,10}})));
  Joints.Revolute revolute(w(fixed=true),
    stateSelect=StateSelect.always,
    phi(fixed=true, start=2.6179938779915))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={70,-20})));
  Modelica.Mechanics.Translational.Components.Damper damper1D(d=10)
    annotation (Placement(transformation(extent={{40,40},{60,60}})));
  MB.Parts.FixedRotation fixedRotation3D(n={0,1,0}, angle=45) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-60,20})));
  Parts.FixedTranslation fixedTranslation(r={0,-1}) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={70,-50})));
  inner PlanarWorldIn3D planarWorld(
    inheritGravityFromMultiBody=true,
    constantGravity={0,0},
    animateGravity=false,
    enableAnimation=true,
    connectToMultiBody=true)
    annotation (Placement(transformation(extent={{-30,40},{-10,60}})));
  inner MB.World world(n={0,-1,0})
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  Interfaces.PlanarTo3D adaptor3DtoPlanar1 annotation (Placement(transformation(extent={{-34,18},{-26,22}})));
  Interfaces.PlanarTo3D adaptor3DtoPlanar2 annotation (Placement(transformation(extent={{28,18},{20,22}})));
  Interfaces.PlanarTo3D adaptor3DtoPlanar3 annotation (Placement(transformation(
        extent={{4,-2},{-4,2}},
        rotation=90,
        origin={70,0})));
equation
  connect(fixedTranslation.frame_b,body3. frame_a) annotation (Line(
      points={{70,-60},{70,-72}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute.frame_b, fixedTranslation.frame_a) annotation (Line(
      points={{70,-30},{70,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(body2.frame_a, prismatic2.frame_b) annotation (Line(
      points={{80,20},{60,20}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedRotation3D.frame_a, world.frame_b) annotation (Line(
      points={{-70,20},{-80,20}},
      color={95,95,95},
      thickness=0.5));
  connect(prismatic1.frame_a, adaptor3DtoPlanar1.framePlanar) annotation (Line(
      points={{-20,20},{-26,20}},
      color={95,95,95},
      thickness=0.5));
  connect(planarWorld.MBFrame_a, fixedRotation3D.frame_b) annotation (Line(
      points={{-30,50},{-40,50},{-40,20},{-50,20}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedRotation3D.frame_b, adaptor3DtoPlanar1.frameMultiBody) annotation (Line(
      points={{-50,20},{-34,20}},
      color={95,95,95},
      thickness=0.5));
  connect(prismatic1.frame_b, body1.frame_a) annotation (Line(
      points={{0,20},{10,20},{10,0}},
      color={95,95,95},
      thickness=0.5));
  connect(prismatic1.frame_b, adaptor3DtoPlanar2.framePlanar) annotation (Line(
      points={{0,20},{20,20}},
      color={95,95,95},
      thickness=0.5));
  connect(adaptor3DtoPlanar2.frameMultiBody, prismatic2.frame_a) annotation (Line(
      points={{28,20},{40,20}},
      color={95,95,95},
      thickness=0.5));
  connect(damper1D.flange_a, prismatic2.support) annotation (Line(points={{40,50},{40,26},{46,26}}, color={0,127,0}));
  connect(damper1D.flange_b, prismatic2.axis) annotation (Line(points={{60,50},{60,26},{58,26}}, color={0,127,0}));
  connect(revolute.frame_a, adaptor3DtoPlanar3.framePlanar) annotation (Line(
      points={{70,-10},{70,-4}},
      color={95,95,95},
      thickness=0.5));
  connect(prismatic2.frame_b, adaptor3DtoPlanar3.frameMultiBody) annotation (Line(
      points={{60,20},{70,20},{70,4}},
      color={95,95,95},
      thickness=0.5));
  annotation (experiment(StopTime=10),
    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p></html>",  info="<html>
<p>
This example demonstrates a possible connection of planar and 3-dimensional (3D) world.
Here, the planar damped crane crab is modelled of both planar and multibody parts as follows
</p>
<ul>
<li>3D:</li>
  <ul>
  <li>body2</li>
  <li>prismatic2</li>
  <li>fixedRotation3D</li>
  </ul>
<li>planar:</li>
  <ul>
  <li>body1</li>
  <li>body3</li>
  <li>prismatic1</li>
  <li>revolute</li>
  <li>fixedTranslation</li>
  </ul> 
</ul> 

<h4>Simulation results</h4> 
<p>
The simulation results of this example can be compared with those of examples
<a href=\"modelica://PlanarMechanics.Examples.CraneCrabTo3Da\">CraneCrabTo3Da</a>,
<a href=\"modelica://PlanarMechanics.Examples.CraneCrabTo3Db\">CraneCrabTo3Db</a>,
<a href=\"modelica://PlanarMechanics.Examples.CraneCrabTo3Dc\">CraneCrabTo3Dc</a>,
<a href=\"modelica://PlanarMechanics.Examples.CraneCrabMBS\">CraneCrabMBS</a>,
The last one is modelled purely in 3D and can thus be seen as a reference for the comparison.
Especially, the states of joints are to be compared, see below.
</p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/CraneCrabTo3Dc_1.png\"/></p>
</html>"),
    Diagram(graphics={Rectangle(
          extent={{42,0},{98,-94}},
          lineColor={28,108,200},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.Dash), Text(
          extent={{-34,4},{34,-4}},
          lineColor={238,46,47},
          pattern=LinePattern.Dash,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          fontSize=20,
          textString="Planar mechanics",
          origin={92,-50},
          rotation=90),
                      Rectangle(
          extent={{-30,32},{24,-58}},
          lineColor={28,108,200},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.Dash), Text(
          extent={{-34,4},{34,-4}},
          lineColor={238,46,47},
          pattern=LinePattern.Dash,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          fontSize=20,
          textString="Planar mechanics",
          origin={-22,-22},
          rotation=90)}));
end CraneCrabTo3Dd;
