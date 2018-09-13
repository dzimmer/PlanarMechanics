within PlanarMechanics.Examples.PlanarTo3D;
model Pendulum "Rigid pendulum in the world"
  extends Modelica.Icons.Example;

  inner MB.World world annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  inner PlanarWorldIn3D planarWorld(
    inheritGravityFromMultiBody=true,
    enableAnimation=true,
    animateWorld=true,
    animateGravity=true,
    connectToMultiBody=true)
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Interfaces.PlanarTo3D adaptor3D annotation (Placement(transformation(extent={{-8,-46},{-20,-34}})));
  MB.Sensors.AbsoluteAngles absoluteAnglesMBS(sequence={3,2,1}, guessAngle1=0) annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  MB.Sensors.AbsoluteAngles absoluteAngles3Din2D(sequence={3,2,1}, guessAngle1=0) annotation (Placement(transformation(extent={{60,-70},{80,-50}})));
  MB.Parts.Body bodyMBS(
    r_CM=zeros(3),
    m=1,
    I_33=0.1,
    sphereColor={0,128,0}) annotation (Placement(transformation(extent={{40,10},{60,30}})));
  MB.Parts.Body body3Din2D(
    r_CM=zeros(3),
    m=1,
    I_33=0.1) annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  MB.Joints.Revolute revoluteMBS(
    n(each displayUnit="1") = {0,0,1},
    phi(fixed=true),
    w(fixed=true)) annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
  Joints.Revolute revolute3Din2D(phi(fixed=true), w(fixed=true)) annotation (Placement(transformation(extent={{-50,-50},{-30,-30}})));
  MB.Parts.Fixed fixedMBS annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-70,20})));
  Parts.Fixed fixed3Din2D annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-70,-40})));
  MB.Parts.FixedTranslation fixTranslationMBS(r={1,0,0}) annotation (Placement(transformation(extent={{0,10},{20,30}})));
  MB.Parts.FixedTranslation fixTranslation3Din2D(r={1,0,0}) annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
equation
  connect(world.frame_b, planarWorld.MBFrame_a) annotation (Line(
      points={{-80,70},{-60,70}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedMBS.frame_b, revoluteMBS.frame_a) annotation (Line(
      points={{-60,20},{-50,20}},
      color={95,95,95},
      thickness=0.5));
  connect(adaptor3D.framePlanar, revolute3Din2D.frame_b) annotation (Line(
      points={{-20,-40},{-30,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute3Din2D.frame_a, fixed3Din2D.frame) annotation (Line(
      points={{-50,-40},{-60,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(absoluteAnglesMBS.frame_a, bodyMBS.frame_a) annotation (Line(
      points={{60,0},{30,0},{30,20},{40,20}},
      color={95,95,95},
      thickness=0.5));
  connect(absoluteAngles3Din2D.frame_a, body3Din2D.frame_a) annotation (Line(
      points={{60,-60},{30,-60},{30,-40},{40,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(adaptor3D.frameMultiBody, fixTranslation3Din2D.frame_a) annotation (Line(
      points={{-8,-40},{0,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(fixTranslation3Din2D.frame_b, body3Din2D.frame_a) annotation (Line(
      points={{20,-40},{40,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(revoluteMBS.frame_b, fixTranslationMBS.frame_a) annotation (Line(
      points={{-30,20},{0,20}},
      color={95,95,95},
      thickness=0.5));
  connect(fixTranslationMBS.frame_b, bodyMBS.frame_a) annotation (Line(
      points={{20,20},{40,20}},
      color={95,95,95},
      thickness=0.5));
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
          extent={{-14,-26},{86,-72}},
          lineColor={28,108,200},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.Dash),
        Text(
          extent={{-14,-62},{52,-70}},
          textString="Planar mechanics",
          textColor={238,46,47})}));
end Pendulum;
