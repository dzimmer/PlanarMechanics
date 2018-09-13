within PlanarMechanics.Examples.PlanarTo3D;
model PendulumLong "Rigid pendulum in the world"
  extends Modelica.Icons.Example;

  Modelica.Blocks.Interfaces.RealOutput angle3Din2D annotation (Placement(transformation(extent={{60,0},{80,20}}),  iconTransformation(extent={{90,60},{90,60}})));
  Modelica.Blocks.Interfaces.RealOutput angleMBS annotation (Placement(transformation(extent={{60,60},{80,80}}),iconTransformation(extent={{90,60},{90,60}})));
  Modelica.Blocks.Interfaces.RealOutput angle2Din3D annotation (Placement(transformation(extent={{60,-60},{80,-40}}), iconTransformation(extent={{90,60},{90,60}})));
  inner MB.World world annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  inner PlanarWorldIn3D planarWorld(
    inheritGravityFromMultiBody=true,
    enableAnimation=true,
    animateWorld=true,
    animateGravity=true,
    connectToMultiBody=true)
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  MB.Sensors.AbsoluteAngles sensorAbsAngles3Din2D(sequence={3,2,1}, guessAngle1=0) annotation (Placement(transformation(extent={{20,0},{40,20}})));
  MB.Sensors.AbsoluteAngles sensorAbsAnglesMBS(sequence={3,2,1}, guessAngle1=0) annotation (Placement(transformation(extent={{20,60},{40,80}})));
  MB.Sensors.AbsoluteAngles sensorAbsAngles2Din3D(sequence={3,2,1}, guessAngle1=0) annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  MB.Parts.BodyShape body3Din2D(
    r=zeros(3),
    r_CM=zeros(3),
    m=1,
    I_33=0.1) annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  MB.Parts.BodyShape bodyMBS(
    r=zeros(3),
    r_CM=zeros(3),
    m=1,
    I_33=0.1,
    sphereColor={0,128,0}) annotation (Placement(transformation(extent={{20,40},{40,60}})));
  MB.Parts.BodyShape body2Din3D(
    r=zeros(3),
    r_CM=zeros(3),
    m=1,
    I_33=0.1,
    sphereColor={0,128,0}) annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
  MB.Parts.Body bodyOuter3Din2D(
    r_CM=zeros(3),
    m=0.2,
    I_11=0.01,
    I_22=0.01,
    I_33=0.01) annotation (Placement(transformation(extent={{80,-20},{100,0}})));
  MB.Parts.Body bodyOuterMBS(
    r_CM=zeros(3),
    m=0.2,
    I_11=0.01,
    I_22=0.01,
    I_33=0.01) annotation (Placement(transformation(extent={{80,40},{100,60}})));
  Parts.Body bodyOuter2Din3D(
    m=0.2,
    I=0.01,
    sphereColor={155,0,0}) annotation (Placement(transformation(extent={{80,-80},{100,-60}})));
  Joints.Revolute revolute3Din2D(phi(fixed=true), w(fixed=true)) annotation (Placement(transformation(extent={{-70,-20},{-50,0}})));
  MB.Joints.Revolute revoluteMBS(
    n(each displayUnit="1") = {0,0,1},
    phi(fixed=true),
    w(fixed=true)) annotation (Placement(transformation(extent={{-70,40},{-50,60}})));
  MB.Joints.Revolute revolute2Din3D(
    n(each displayUnit="1") = {0,0,1},
    phi(fixed=true),
    w(fixed=true)) annotation (Placement(transformation(extent={{-70,-80},{-50,-60}})));
  Parts.Fixed fixed3Din2D annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-90,-10})));
  MB.Parts.Fixed fixedMBS annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-90,50})));
  MB.Parts.Fixed fixed2Din3D annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-90,-70})));
  MB.Parts.FixedTranslation fixTranslation3Din2D(r={1,0,0}) annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  MB.Parts.FixedTranslation fixTranslationMBS(r={1,0,0}) annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  MB.Parts.FixedTranslation fixTranslation2Din3D(r={1,0,0}) annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  MB.Parts.FixedTranslation fixTranslationOuter3Din2D(r={0.4,0,0}) annotation (Placement(transformation(extent={{50,-20},{70,0}})));
  MB.Parts.FixedTranslation fixTranslationOuterMBS(r={0.4,0,0}) annotation (Placement(transformation(extent={{50,40},{70,60}})));
  Parts.FixedTranslation fixTranslationOuter2Din3D(r={0.4,0}, color={155,0,0}) annotation (Placement(transformation(extent={{50,-80},{70,-60}})));
  Interfaces.PlanarTo3D adaptor3Din2D(rootMBS=true) annotation (Placement(transformation(extent={{-28,-16},{-40,-4}})));
  Interfaces.PlanarTo3D adaptor2Din3D annotation (Placement(transformation(extent={{28,-76},{40,-64}})));
equation
  connect(world.frame_b, planarWorld.MBFrame_a) annotation (Line(
      points={{-80,90},{-60,90}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedMBS.frame_b, revoluteMBS.frame_a) annotation (Line(
      points={{-80,50},{-70,50}},
      color={95,95,95},
      thickness=0.5));
  connect(adaptor3Din2D.framePlanar, revolute3Din2D.frame_b) annotation (Line(
      points={{-40,-10},{-50,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute3Din2D.frame_a, fixed3Din2D.frame) annotation (Line(
      points={{-70,-10},{-80,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(sensorAbsAnglesMBS.frame_a, bodyMBS.frame_a) annotation (Line(
      points={{20,70},{10,70},{10,50},{20,50}},
      color={95,95,95},
      thickness=0.5));
  connect(sensorAbsAngles3Din2D.frame_a, body3Din2D.frame_a) annotation (Line(
      points={{20,10},{10,10},{10,-10},{20,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(adaptor3Din2D.frameMultiBody, fixTranslation3Din2D.frame_a) annotation (Line(
      points={{-28,-10},{-20,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(fixTranslation3Din2D.frame_b, body3Din2D.frame_a) annotation (Line(
      points={{0,-10},{20,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(revoluteMBS.frame_b, fixTranslationMBS.frame_a) annotation (Line(
      points={{-50,50},{-20,50}},
      color={95,95,95},
      thickness=0.5));
  connect(fixTranslationMBS.frame_b, bodyMBS.frame_a) annotation (Line(
      points={{0,50},{20,50}},
      color={95,95,95},
      thickness=0.5));
  connect(fixTranslationOuter3Din2D.frame_b, bodyOuter3Din2D.frame_a) annotation (Line(
      points={{70,-10},{80,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(fixTranslationOuter3Din2D.frame_a, body3Din2D.frame_b) annotation (Line(
      points={{50,-10},{40,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(fixTranslationOuterMBS.frame_b, bodyOuterMBS.frame_a) annotation (Line(
      points={{70,50},{80,50}},
      color={95,95,95},
      thickness=0.5));
  connect(bodyMBS.frame_b, fixTranslationOuterMBS.frame_a) annotation (Line(
      points={{40,50},{50,50}},
      color={95,95,95},
      thickness=0.5));
  connect(fixed2Din3D.frame_b, revolute2Din3D.frame_a) annotation (Line(
      points={{-80,-70},{-70,-70}},
      color={95,95,95},
      thickness=0.5));
  connect(sensorAbsAngles2Din3D.frame_a, body2Din3D.frame_a) annotation (Line(
      points={{0,-50},{-10,-50},{-10,-70},{0,-70}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute2Din3D.frame_b, fixTranslation2Din3D.frame_a) annotation (Line(
      points={{-50,-70},{-40,-70}},
      color={95,95,95},
      thickness=0.5));
  connect(fixTranslation2Din3D.frame_b, body2Din3D.frame_a) annotation (Line(
      points={{-20,-70},{0,-70}},
      color={95,95,95},
      thickness=0.5));
  connect(bodyOuter2Din3D.frame_a, fixTranslationOuter2Din3D.frame_b) annotation (Line(
      points={{80,-70},{70,-70}},
      color={95,95,95},
      thickness=0.5));
  connect(body2Din3D.frame_b, adaptor2Din3D.frameMultiBody) annotation (Line(
      points={{20,-70},{28,-70}},
      color={95,95,95},
      thickness=0.5));
  connect(fixTranslationOuter2Din3D.frame_a, adaptor2Din3D.framePlanar) annotation (Line(
      points={{50,-70},{40,-70}},
      color={95,95,95},
      thickness=0.5));
  connect(sensorAbsAngles3Din2D.angles[1], angle3Din2D) annotation (Line(points={{41,9.66667},{52,9.66667},{52,10},{70,10}}, color={0,0,127}));
  connect(sensorAbsAnglesMBS.angles[1], angleMBS) annotation (Line(points={{41,69.6667},{52,69.6667},{52,70},{70,70}}, color={0,0,127}));
  connect(sensorAbsAngles2Din3D.angles[1], angle2Din3D) annotation (Line(points={{21,-49.6667},{42,-49.6667},{42,-50},{70,-50}}, color={0,0,127}));
  annotation (
    experiment(
      StopTime=5,
      Tolerance=1e-06),
    Documentation(
      revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<b>Developed 2026 at the DLR Institute of System Dynamics and Control</b>
</p>
</html>",
      info="<html>
<p>Beware this is a chaotic system. However, the chaotic part should start after 10s.</p>
</html>"),
    Diagram(graphics={
        Rectangle(
          extent={{-100,10},{-34,-36}},
          lineColor={28,108,200},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.Dash),
        Text(
          extent={{-100,-26},{-34,-34}},
          textString="Planar mechanics",
          textColor={238,46,47}),
        Rectangle(
          extent={{34,-54},{100,-98}},
          lineColor={28,108,200},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.Dash),
        Text(
          extent={{34,-88},{100,-96}},
          textString="Planar mechanics",
          textColor={238,46,47})}));
end PendulumLong;
