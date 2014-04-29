within PlanarMechanics.Examples;
model SpringDemo
    extends Modelica.Icons.Example;

  Parts.Body body(
    I=0.1,
    m=0.5) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-40})));
  Parts.Fixed fixed annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-50,40})));
  inner PlanarWorld planarWorld
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Parts.FixedTranslation fixedTranslation
    annotation (Placement(transformation(extent={{-32,30},{-10,50}})));
  Parts.Spring spring1(c_y=10, s_rely0=-0.5,
    c_x=1,
    c_phi=1e5,
    enableAssert=false)
                       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,0})));
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
  connect(fixed.frame_a, fixedTranslation.frame_a) annotation (Line(
      points={{-40,40},{-32,40}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(spring1.frame_a, fixedTranslation.frame_b) annotation (Line(
      points={{2.50304e-015,10},{0,10},{0,40},{-10,40}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(spring1.frame_b, body.frame_a) annotation (Line(
      points={{-1.17078e-015,-10},{2.50304e-015,-10},{2.50304e-015,-30}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(damper.frame_a, spring1.frame_a) annotation (Line(
      points={{-30,10},{2.50304e-015,10}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(damper.frame_b, spring1.frame_b) annotation (Line(
      points={{-30,-10},{-1.17078e-015,-10}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(spring1.frame_a, prismatic.frame_a) annotation (Line(
      points={{2.50304e-015,10},{30,10}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(prismatic.frame_b, spring1.frame_b) annotation (Line(
      points={{30,-10},{-1.17078e-015,-10}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (experiment(StopTime=5),
    Documentation(info="<html>
<h4><font color=\"#008000\">Spring Demo</font></h4>
<p>This example shows how to use a spring and a damper separately. The motion is constrained by a prismatic joint. The spring passes a point of zero lenght.</p>
</html>"));
end SpringDemo;
