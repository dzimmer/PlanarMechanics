within PlanarMechanics.Examples;
model DoublePendulum
  extends Modelica.Icons.Example;

  Parts.Body body(
    m=1,
    I=0.1,
    g={0,-9.81})
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  Parts.FixedTranslation fixedTranslation(r={1,0})
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  Parts.Fixed fixed annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-90,70})));
  Parts.Body body1(
    g={0,-9.81},
    m=0.2,
    I=0.01)
    annotation (Placement(transformation(extent={{60,20},{80,40}})));
  Parts.FixedTranslation fixedTranslation1(r={0.4,0})
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  inner PlanarWorld planarWorld(enableAnimation=true,
    animateWorld=true,
    animateGravity=true)
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  Joints.Revolute revolute(phi(fixed=true, start=0), w(fixed=true, start=0))
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Joints.Revolute revolute1(phi(fixed=true, start=0), w(fixed=true, start=0))
    annotation (Placement(transformation(extent={{-18,20},{2,40}})));
equation
  connect(fixedTranslation.frame_b, body.frame_a) annotation (Line(
      points={{5.55112e-16,70},{20,70}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(fixedTranslation1.frame_b, body1.frame_a)
                                                  annotation (Line(
      points={{40,30},{60,30}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(fixed.frame_a, revolute.frame_a) annotation (Line(
      points={{-80,70},{-60,70}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(revolute.frame_b, fixedTranslation.frame_a) annotation (Line(
      points={{-40,70},{-20,70}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(revolute1.frame_b, fixedTranslation1.frame_a) annotation (Line(
      points={{2,30},{20,30}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(fixedTranslation.frame_b, revolute1.frame_a) annotation (Line(
      points={{5.55112e-16,70},{5.55112e-16,50},{-36,50},{-36,30},{-18,30}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(extent={{-100,-100},{100,100}},
          preserveAspectRatio=true),
                      graphics),
    experiment(StopTime=10),
    __Dymola_experimentSetupOutput,
    Documentation(revisions="<html><p><img src=\"./Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p></html>",  info="<html>
<p><h4><font color=\"#008000\">A double pendulum.</font></h4></p>
<p><br/>Beware this is a chaotic system. However, the chatoic part should start after 10s.</p>
<p><br/><img src=\"modelica://PlanarMechanics/Resources/Images/DoublePendulum_1.png\"/></p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/DoublePendulum_2.png\"/></p>
<p><br/><br/><br/>SELECTED&nbsp;CONTINUOUS&nbsp;TIME&nbsp;STATES</p>
<p>&nbsp;&nbsp;revolute.phi</p>
<p>&nbsp;&nbsp;revolute.w</p>
<p>&nbsp;&nbsp;revolute1.phi</p>
<p>&nbsp;&nbsp;revolute1.w</p>
</html>",
      revisions="<html>
<p>(c) Copyright by Dirk Zimmer</p>
<p>The library was creates and is owned by Dr. Dirk Zimmer. </p>
<p>dirk.zimmer@dlr.de</p>
</html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end DoublePendulum;
