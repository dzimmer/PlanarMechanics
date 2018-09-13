within PlanarMechanics.Examples.PlanarTo3D;
model DoublePendulum2Dto3D "Simple double pendulum with two revolute joints and two bodies in the 3D world"
  extends Modelica.Icons.Example;

  Parts.Body body(
    m=1,
    I=0.33)
    annotation (Placement(transformation(extent={{0,10},{20,30}})));
  Parts.FixedTranslation fixedTranslation(r={1,0})
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  Parts.Fixed fixed annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-90,20})));
  MB.Parts.Body body1(
    r_CM=zeros(3),
    m=0.2,
    I_33=0.01)
    annotation (Placement(transformation(extent={{80,-20},{100,0}})));
  MB.Parts.FixedTranslation fixedTranslation1(r={0.4,0,0})
    annotation (Placement(transformation(extent={{50,-20},{70,0}})));
  inner PlanarWorldIn3D planarWorld(
    inheritGravityFromMultiBody=true,
    enableAnimation=true,
    animateWorld=true,
    animateGravity=true,
    connectToMultiBody=true)
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Joints.Revolute revolute(phi(fixed=true, start=0), w(fixed=true, start=0),
    stateSelect=StateSelect.always)
    annotation (Placement(transformation(extent={{-70,10},{-50,30}})));
  Joints.Revolute revolute1(
    useFlange=true,
    phi(fixed=true, start=0),
    w(fixed=true, start=0),
    stateSelect=StateSelect.always)
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  inner MB.World world annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Interfaces.PlanarTo3D adaptor3D annotation (Placement(transformation(extent={{40,-16},{28,-4}})));
  Modelica.Mechanics.Rotational.Components.Damper damper(d=0.1) annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
equation
  connect(fixedTranslation.frame_b, body.frame_a) annotation (Line(
      points={{-20,20},{0,20}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation1.frame_b, body1.frame_a) annotation (Line(
      points={{70,-10},{80,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute.frame_b, fixedTranslation.frame_a) annotation (Line(
      points={{-50,20},{-40,20}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation.frame_b, revolute1.frame_a) annotation (Line(
      points={{-20,20},{-10,20},{-10,-10},{0,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(fixed.frame, revolute.frame_a) annotation (Line(
      points={{-80,20},{-70,20}},
      color={95,95,95},
      thickness=0.5));
  connect(world.frame_b, planarWorld.MBFrame_a) annotation (Line(
      points={{-80,70},{-60,70}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute1.frame_b, adaptor3D.framePlanar) annotation (Line(
      points={{20,-10},{28,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation1.frame_a, adaptor3D.frameMultiBody) annotation (Line(
      points={{50,-10},{40,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(damper.flange_a, revolute1.support) annotation (Line(points={{0,-40},{0,-20},{4,-20}}, color={0,0,0}));
  connect(damper.flange_b, revolute1.flange_a) annotation (Line(points={{20,-40},{20,-20},{10,-20}}, color={0,0,0}));
  annotation (
    experiment(
      StopTime=8),
    Documentation(
      revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<b>Developed 2026 at the DLR Institute of System Dynamics and Control</b>
</p>
</html>",
      info="<html>
<p>Beware this is a chaotic system. However, the chaotic part should start after 10s.</p>
<blockquote>
<img src=\"modelica://PlanarMechanics/Resources/Images/Examples/PlanarTo3D/DoublePendulum_1.png\" alt=\"Diagram DoublePendulum_1\">
</blockquote>
</html>"),
    Diagram(
      graphics={
        Rectangle(
          extent={{-100,36},{30,-30}},
          lineColor={28,108,200},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.Dash),
        Text(
          extent={{-96,-18},{-28,-26}},
          textString="Planar mechanics",
          textColor={238,46,47})}));
end DoublePendulum2Dto3D;
