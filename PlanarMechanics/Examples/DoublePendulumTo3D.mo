within PlanarMechanics.Examples;
model DoublePendulumTo3D "Simple double pendulum with two revolute joints and two bodies in the 3D world"
  extends Modelica.Icons.Example;

  MB.Parts.Body body(
    m=1,
    I_33=0.1,
    r_CM=zeros(3))
    annotation (Placement(transformation(extent={{0,10},{20,30}})));
  MB.Parts.FixedTranslation fixedTranslation(r={1,0,0})
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  MB.Parts.Fixed fixed annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-90,20})));
  Parts.Body body1(
    m=0.2,
    I=0.01)
    annotation (Placement(transformation(extent={{80,-30},{100,-10}})));
  Parts.FixedTranslation fixedTranslation1(r={0.4,0})
    annotation (Placement(transformation(extent={{50,-30},{70,-10}})));
  inner PlanarWorldIn3D planarWorld(enableAnimation=true,
    animateWorld=true,
    animateGravity=true,
    connectToMultiBody=true)
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  MB.Joints.Revolute revolute(phi(fixed=true, start=0), w(fixed=true, start=0),
    stateSelect=StateSelect.always)
    annotation (Placement(transformation(extent={{-70,10},{-50,30}})));
  MB.Joints.Revolute revolute1(phi(fixed=true, start=0), w(fixed=true, start=0),
    stateSelect=StateSelect.always)
    annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
  Interfaces.PlanarTo3D adaptor3D annotation (Placement(transformation(extent={{32,-22},{40,-18}})));
equation
  connect(fixedTranslation.frame_b, body.frame_a) annotation (Line(
      points={{-20,20},{0,20}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation1.frame_b, body1.frame_a)
                                                  annotation (Line(
      points={{70,-20},{80,-20}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute.frame_b, fixedTranslation.frame_a) annotation (Line(
      points={{-50,20},{-40,20}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation.frame_b, revolute1.frame_a) annotation (Line(
      points={{-20,20},{-10,20},{-10,-20},{0,-20}},
      color={95,95,95},
      thickness=0.5));
  connect(fixed.frame_b, revolute.frame_a) annotation (Line(
      points={{-80,20},{-70,20}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute1.frame_b, adaptor3D.frameMultiBody) annotation (Line(
      points={{20,-20},{32,-20}},
      color={95,95,95},
      thickness=0.5));
  connect(adaptor3D.framePlanar, fixedTranslation1.frame_a) annotation (Line(
      points={{40,-20},{50,-20}},
      color={95,95,95},
      thickness=0.5));
  connect(planarWorld.MBFrame_a, fixed.frame_b) annotation (Line(
      points={{-60,50},{-74,50},{-74,20},{-80,20}},
      color={95,95,95},
      thickness=0.5));
  annotation (experiment(StopTime=10),
    Documentation(revisions="<html>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p>
</html>",                                                                                                  info="<html>
<p>Beware this is a chaotic system. However, the chaotic part should start after 10s.</p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/DoublePendulum_1.png\"/></p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/DoublePendulum_2.png\"/></p>
</html>"));
end DoublePendulumTo3D;
