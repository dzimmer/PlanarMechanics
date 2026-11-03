within PlanarMechanics.Examples.PlanarTo3D;
model Pendulum "Compare rigid pendulum in the 3D and the 2D world"
  extends Modelica.Icons.Example;

  Interfaces.PlanarToMultiBody adaptor3D(
    rootMBS=true) annotation (Placement(transformation(extent={{-8,-46},{-20,-34}})));
  MB.Sensors.AbsoluteAngles sensorAnglesMBS(sequence={3,2,1}, guessAngle1=0) annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  MB.Sensors.AbsoluteAngles sensorAngles3Din2D(sequence={3,2,1}, guessAngle1=0) annotation (Placement(transformation(extent={{60,-70},{80,-50}})));
  MB.Parts.Body bodyMBS(
    r_CM=zeros(3),
    m=1,
    I_33=0.1,
    sphereColor={0,128,0}) annotation (Placement(transformation(extent={{40,10},{60,30}})));
  MB.Parts.Body body3Din2D(
    r_CM=bodyMBS.r_CM,
    m=bodyMBS.m,
    I_33=bodyMBS.I_33) annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  MB.Joints.Revolute revoluteMBS(
    n(each displayUnit="1") = {0,0,1},
    phi(fixed=true),
    w(fixed=true)) annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
  Joints.Revolute revolute3Din2D(
    phi(fixed=true),
    w(fixed=true)) annotation (Placement(transformation(extent={{-50,-50},{-30,-30}})));
  MB.Parts.Fixed fixMBS annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-70,20})));
  Parts.Fixed fix3Din2D annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-70,-40})));
  MB.Parts.FixedTranslation translationMBS(r={1,0,0}) annotation (Placement(transformation(extent={{0,10},{20,30}})));
  MB.Parts.FixedTranslation translation3Din2D(r=translationMBS.r) annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
  inner MB.World world annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  inner PlanarWorldIn3D planarWorld(
    inheritGravityFromMultiBody=true,
    enableAnimation=true,
    animateWorld=true,
    animateGravity=true,
    connectToMultiBody=true)
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
equation
  connect(world.frame_b, planarWorld.MBFrame_a) annotation (Line(
      points={{-80,70},{-60,70}},
      color={95,95,95},
      thickness=0.5));
  connect(fixMBS.frame_b, revoluteMBS.frame_a) annotation (Line(
      points={{-60,20},{-50,20}},
      color={95,95,95},
      thickness=0.5));
  connect(adaptor3D.framePlanar, revolute3Din2D.frame_b) annotation (Line(
      points={{-20,-40},{-30,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute3Din2D.frame_a, fix3Din2D.frame) annotation (Line(
      points={{-50,-40},{-60,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(sensorAnglesMBS.frame_a, bodyMBS.frame_a) annotation (Line(
      points={{60,0},{30,0},{30,20},{40,20}},
      color={95,95,95},
      thickness=0.5));
  connect(sensorAngles3Din2D.frame_a, body3Din2D.frame_a) annotation (Line(
      points={{60,-60},{30,-60},{30,-40},{40,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(adaptor3D.frameMultiBody, translation3Din2D.frame_a) annotation (Line(
      points={{-8,-40},{0,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(translation3Din2D.frame_b, body3Din2D.frame_a) annotation (Line(
      points={{20,-40},{40,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(revoluteMBS.frame_b, translationMBS.frame_a) annotation (Line(
      points={{-30,20},{0,20}},
      color={95,95,95},
      thickness=0.5));
  connect(translationMBS.frame_b, bodyMBS.frame_a) annotation (Line(
      points={{20,20},{40,20}},
      color={95,95,95},
      thickness=0.5));
  annotation (
    experiment(
      StopTime=5,
      Tolerance=1e-05),
    Documentation(
      revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2026 at the DLR Institute of Vehicle Concepts</strong>
</p>
</html>",
      info="<html>
<p>
A&nbsp;simple rigid pendulum in the 3D world compared to a&nbsp;simple 3D pendulum
oscillating in the 2D world.
</p>
<div>
<img src=\"modelica://PlanarMechanics/Resources/Images/Examples/PlanarTo3D/Pendulum_1.png\" alt=\"Rotation of pendulum's joint\">
</div>
</html>",
      figures = {
        Figure(
          identifier = "pendulum-motion",
          preferred = true,
          plots = {
            Plot(
              identifier = "pendulum_angle",
              curves = {
                Curve(y = revoluteMBS.phi),
                Curve(y = revolute3Din2D.phi)}),
            Plot(
              identifier = "pendulum_w",
              curves = {
                Curve(y = revoluteMBS.w),
                Curve(y = revolute3Din2D.w)})},
          caption = "%(plot:pendulum-motion) Motion of the pendulum")}),
    Diagram(graphics={
        Rectangle(
          extent={{-84,-24},{-14,-70}},
          lineColor={28,108,200},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.Dash),
        Text(
          extent={{-84,-60},{-18,-68}},
          textString="Planar mechanics",
          textColor={238,46,47})}));
end Pendulum;
