within PlanarMechanics.Examples;
model Pendulum "A free swinging pendulum"
  extends Modelica.Icons.Example;

  Parts.Body body(
    m=1,
    I=0.1)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Joints.Revolute revolute(
    useFlange=false,
    phi(fixed=true, start=0),
    w(fixed=true, start=0))
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Parts.FixedTranslation fixedTranslation(r= {1,0})
    annotation (Placement(transformation(extent={{-10,-10},{16,10}})));
  Parts.Fixed fixed(phi=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-60,0})));
  inner PlanarWorld planarWorld(defaultWidthFraction=10)
    annotation (Placement(transformation(extent={{44,-10},{64,10}})));
equation
  connect(fixed.frame_a, revolute.frame_a) annotation (Line(
      points={{-50,-7.80517e-16},{-50,6.66134e-16},{-40,6.66134e-16}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(revolute.frame_b, fixedTranslation.frame_a) annotation (Line(
      points={{-20,6.66134e-16},{-15,6.66134e-16},{-15,1.33227e-15},{-10,
          1.33227e-15},{-10,6.66134e-16}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(fixedTranslation.frame_b, body.frame_a) annotation (Line(
      points={{16,6.66134e-16},{15,6.66134e-16},{15,-6.66134e-16},{20,
          -6.66134e-16},{20,6.66134e-16}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (experiment(StopTime=3),
    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p></html>",  info="<html>
<h4><font color=\"#008000\">A free swinging pendulum</font></h4>
<p><br/><img src=\"modelica://PlanarMechanics/Resources/Images/Pendulum_1.png\"/></p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/Pendulum_2.png\"/></p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/Pendulum_3.png\"/></p>
<p><br/><br/>SELECTED&nbsp;CONTINUOUS&nbsp;TIME&nbsp;STATES</p>
<p>&nbsp;&nbsp;revolute.phi</p>
<p>&nbsp;&nbsp;revolute.w</p>
</html>",
      revisions="<html>
<p>(c) Copyright by Dirk Zimmer</p>
<p>The library was created and is owned by Dr. Dirk Zimmer.</p>
<p>dirk.zimmer@dlr.de</p>
</html>"));
end Pendulum;
