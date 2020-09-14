within PlanarMechanics.Examples;
model SpringDamperDemo "Spring damper demo"
    extends Modelica.Icons.Example;
  Parts.SpringDamper springDamper(
    s_relx0=0,
    d_y=1,
    s_rely0=0,
    d_phi=0,
    c_y=5,
    c_x=5,
    d_x=1,
    c_phi=0)
           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Parts.Body body(
    I=0.1,
    m=0.5,
    v(each fixed=true),
    phi(fixed=true),
    w(fixed=true),
    r(each fixed=true, start={1,1}))
           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-40})));
  Parts.Fixed fixed annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-70,40})));
  inner PlanarWorld planarWorld
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Parts.FixedTranslation fixedTranslation(r={-1,0})
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
equation
  connect(fixed.frame, fixedTranslation.frame_a) annotation (Line(
      points={{-60,40},{-40,40}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation.frame_b, springDamper.frame_a) annotation (Line(
      points={{-20,40},{0,40},{0,10}},
      color={95,95,95},
      thickness=0.5));
  connect(springDamper.frame_b, body.frame_a) annotation (Line(
      points={{0,-10},{0,-18},{0,-30}},
      color={95,95,95},
      thickness=0.5));
  annotation (experiment(
      StopTime=5),
    Documentation(info="<html>
<p>This example shows how to use a spring and a damper in combination. The motion of the body is not constrained.</p>
</html>",
        revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<b>Developed 2010-2020 at the DLR Institute of System Dynamics and Control</b>
</p>
</html>
"));
end SpringDamperDemo;
