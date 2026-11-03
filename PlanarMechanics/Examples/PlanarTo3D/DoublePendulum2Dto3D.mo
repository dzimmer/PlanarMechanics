within PlanarMechanics.Examples.PlanarTo3D;
model DoublePendulum2Dto3D "Double pendulum devided between the 2D and the 3D world"
  extends Modelica.Icons.Example;

  Joints.Revolute revolute(
    phi(fixed=true, start=0),
    w(fixed=true, start=0),
    stateSelect=StateSelect.always)
    annotation (Placement(transformation(extent={{-70,10},{-50,30}})));
  Joints.Revolute revolute1(
    useFlange=true,
    phi(fixed=true, start=0),
    w(fixed=true, start=0),
    stateSelect=StateSelect.always)
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  Parts.Body body(
    m=1,
    I=0.33)
    annotation (Placement(transformation(extent={{0,10},{20,30}})));
  MB.Parts.Body body1(
    r_CM=zeros(3),
    m=0.2,
    I_33=0.01)
    annotation (Placement(transformation(extent={{80,-20},{100,0}})));
  Parts.FixedTranslation translation(r={1,0}) annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  MB.Parts.FixedTranslation translation1(r={0.4,0,0}) annotation (Placement(transformation(extent={{50,-20},{70,0}})));
  Modelica.Mechanics.Rotational.Components.Damper damper(d=0.01) annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
  Interfaces.PlanarToMultiBody adaptor3D annotation (Placement(transformation(extent={{40,-16},{28,-4}})));
  Parts.Fixed fix annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-90,20})));
  inner MB.World world annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  inner PlanarWorldIn3D planarWorld(
    inheritGravityFromMultiBody=true,
    enableAnimation=true,
    animateWorld=true,
    animateGravity=true,
    connectToMultiBody=true)
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
equation
  connect(translation.frame_b, body.frame_a) annotation (Line(
      points={{-20,20},{0,20}},
      color={95,95,95},
      thickness=0.5));
  connect(translation1.frame_b, body1.frame_a) annotation (Line(
      points={{70,-10},{80,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute.frame_b, translation.frame_a) annotation (Line(
      points={{-50,20},{-40,20}},
      color={95,95,95},
      thickness=0.5));
  connect(translation.frame_b, revolute1.frame_a) annotation (Line(
      points={{-20,20},{-10,20},{-10,-10},{0,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(fix.frame, revolute.frame_a) annotation (Line(
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
  connect(translation1.frame_a, adaptor3D.frameMultiBody) annotation (Line(
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
<strong>Developed 2026 at the DLR Institute of Vehicle Concepts</strong>
</p>
</html>",
      info="<html>
<p>
A&nbsp;simple double pendulum with two revolute joints and two bodies. One of the bodies is modeled in
the 3D world, the remaninig is in the 2D world.
</p>
<div>
<img src=\"modelica://PlanarMechanics/Resources/Images/Examples/PlanarTo3D/DoublePendulum2Dto3D_1.png\" alt=\"Rotation of joints of double pendulum\">
</div>
</html>",
      figures = {
        Figure(
          identifier = "pendulum-motion",
          preferred = true,
          plots = {
            Plot(
              identifier = "pendulum_phi",
              curves = {
                Curve(y = revolute.phi),
                Curve(y = revolute1.phi)}),
            Plot(
              identifier = "pendulum_w",
              curves = {
                Curve(y = revolute.w),
                Curve(y = revolute1.w)})},
          caption = "%(plot:pendulum-motion) Motion of the pendulum")}),
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
