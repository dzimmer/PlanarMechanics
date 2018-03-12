within PlanarMechanics.Examples;
model CraneCrabMBS "A damped crane crab - fully 3-dimensional model"
  extends Modelica.Icons.Example;

  MB.Parts.Body body1(r_CM=zeros(3), m=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,-20})));
  MB.Parts.Body body2(
    m=1,
    r_CM=zeros(3),
    I_33=0.1)
    annotation (Placement(transformation(extent={{70,10},{90,30}})));
  MB.Parts.Body body3(
    m=0.5,
    r_CM=zeros(3),
    I_33=0.1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-80})));
  MB.Joints.Prismatic prismatic1(
    s(fixed=true, start=-0.2),
    useAxisFlange=false,
    v(fixed=true, start=0.2),
    n={1,0,0},
    stateSelect=StateSelect.always) annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-20,20})));
  MB.Joints.Prismatic prismatic2(
    v(fixed=true),
    s(fixed=true, start=0),
    useAxisFlange=true,
    stateSelect=StateSelect.always) annotation (Placement(transformation(extent={{20,10},{40,30}})));
  MB.Joints.Revolute revolute(w(fixed=true),
    n={0,0,1},
    stateSelect=StateSelect.always,
    phi(fixed=true, start=2.6179938779915))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-20})));
  Modelica.Mechanics.Translational.Components.Damper damper1D(d=10)
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  MB.Parts.FixedRotation fixedRotation3D(n={0,1,0}, angle=45) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-60,20})));
  MB.Parts.FixedTranslation fixedTranslation(r={0,-1,0}) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-50})));
  inner MB.World world(n={0,-1,0})
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
equation
  connect(fixedTranslation.frame_b,body3. frame_a) annotation (Line(
      points={{60,-60},{60,-70}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute.frame_a,body2. frame_a) annotation (Line(
      points={{60,-10},{60,20},{70,20}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute.frame_b, fixedTranslation.frame_a) annotation (Line(
      points={{60,-30},{60,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(prismatic2.frame_b, body2.frame_a) annotation (Line(
      points={{40,20},{70,20}},
      color={95,95,95},
      thickness=0.5));
  connect(body1.frame_a, prismatic1.frame_b) annotation (Line(
      points={{6.66134e-016,-10},{6.66134e-016,20},{-10,20}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedRotation3D.frame_a, world.frame_b) annotation (Line(
      points={{-70,20},{-80,20}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedRotation3D.frame_b, prismatic1.frame_a) annotation (Line(
      points={{-50,20},{-30,20}},
      color={95,95,95},
      thickness=0.5));
  connect(damper1D.flange_a, prismatic2.support) annotation (Line(points={{20,50},{20,26},{26,26}}, color={0,127,0}));
  connect(prismatic2.axis, damper1D.flange_b) annotation (Line(points={{38,26},{40,26},{40,50}}, color={0,127,0}));
  connect(prismatic2.frame_a, prismatic1.frame_b) annotation (Line(
      points={{20,20},{-10,20}},
      color={95,95,95},
      thickness=0.5));
  annotation (experiment(StopTime=10),
    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p></html>",  info="<html>
<p>
This example of the planar damped crane crab is modelled purely in 3D and
is aimed as a reference model for comparison to the crane crab model in the planar world.
</p>

<h4>Simulation results</h4> 
<p>
The simulation results of this example can be compared with those of examples
<a href=\"modelica://PlanarMechanics.Examples.CraneCrabTo3Da\">CraneCrabTo3Da</a>,
<a href=\"modelica://PlanarMechanics.Examples.CraneCrabTo3Db\">CraneCrabTo3Db</a>,
<a href=\"modelica://PlanarMechanics.Examples.CraneCrabTo3Dc\">CraneCrabTo3Dc</a>,
<a href=\"modelica://PlanarMechanics.Examples.CraneCrabTo3Dd\">CraneCrabTo3Dd</a>.
</p>
<!--Especially, the states of joints are to be compared, see below.
</p>

<h4>The comparison of planar and 3-dimensional model simulation</h4>
<p>
The following information can be gained from Dymola.
</p>

<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\">
<tr><td><b>TRANSLATION</b>                              </td><td><b>CraneCrabTo3Da</b></td><td><b>CraneCrabMBS</b> </td></tr>
</table>
-->
</html>"));
end CraneCrabMBS;
