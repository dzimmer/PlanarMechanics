within PlanarMechanics.Examples;
model SpringDemo "Spring demo"
    extends Modelica.Icons.Example;

  Parts.Body body(
    I=0.1,
    m=0.5) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-40})));
  Parts.Fixed fixed annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-70,40})));
  inner PlanarWorld planarWorld
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Parts.FixedTranslation fixedTranslation
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Parts.Spring spring1(c_y=10, s_rely0=-0.5,
    c_x=1,
    c_phi=1e5,
    enableAssert=false)
                       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Parts.Damper damper(d=1)  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,0})));
  Joints.Prismatic prismatic(
    animate=false,
    r={0,1},
    s(start=0.2, fixed=true),
    v(fixed=true))
             annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,0})));
equation
  connect(fixed.frame, fixedTranslation.frame_a) annotation (Line(
      points={{-60,40},{-40,40}},
      color={95,95,95},
      thickness=0.5));
  connect(spring1.frame_a, fixedTranslation.frame_b) annotation (Line(
      points={{0,10},{0,10},{0,40},{-20,40}},
      color={95,95,95},
      thickness=0.5));
  connect(spring1.frame_b, body.frame_a) annotation (Line(
      points={{0,-10},{0,-10},{0,-30}},
      color={95,95,95},
      thickness=0.5));
  connect(damper.frame_a, spring1.frame_a) annotation (Line(
      points={{-30,10},{0,10}},
      color={95,95,95},
      thickness=0.5));
  connect(damper.frame_b, spring1.frame_b) annotation (Line(
      points={{-30,-10},{0,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(spring1.frame_a, prismatic.frame_a) annotation (Line(
      points={{0,10},{30,10}},
      color={95,95,95},
      thickness=0.5));
  connect(prismatic.frame_b, spring1.frame_b) annotation (Line(
      points={{30,-10},{0,-10}},
      color={95,95,95},
      thickness=0.5));
  annotation (experiment(StopTime=5),
    Documentation(info="<html>
<p>This example shows how to use a spring and a damper separately. The motion is constrained by a prismatic joint. The spring passes a point of zero length.</p>
</html>",
        revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>"));
end SpringDemo;
