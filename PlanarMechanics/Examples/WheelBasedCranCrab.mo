within PlanarMechanics.Examples;
model WheelBasedCranCrab
  extends Modelica.Icons.Example;
  Joints.IdealRolling idealRolling(R=0.3, initialize=true,
    x_start=0,
    x(fixed=true),
    phi(fixed=true),
    w(fixed=true))                        annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,50})));
  Parts.Body body(
    m=1,
    I=0.1)
    annotation (Placement(transformation(extent={{10,20},{30,40}})));
  Joints.Revolute revolute(phi(fixed=true, start=1.3962634015955), w(fixed=true))
                           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,10})));
  Parts.FixedTranslation fixedTranslation(r={1,0}) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,-20})));
  Parts.Body body1(
    m=2,
    I=0.2)       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,-50})));
  inner PlanarWorld planarWorld(defaultWidthFraction=10, defaultZPosition=0)
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
equation
  connect(revolute.frame_a, idealRolling.frame_a) annotation (Line(
      points={{-20,20},{-20,40}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(body.frame_a, idealRolling.frame_a) annotation (Line(
      points={{10,30},{-20,30},{-20,40}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(body1.frame_a, fixedTranslation.frame_b) annotation (Line(
      points={{-20,-40},{-20,-35},{-20,-35},{-20,-30}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(fixedTranslation.frame_a, revolute.frame_b) annotation (Line(
      points={{-20,-10},{-20,1.22125e-015}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (experiment(StopTime=4.5),
    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p></html>",  info="<html>
<h4><font color=\"#008000\">A pendulum mounted on an ideal rolling wheel.</font></h4>
<p>This model contains non-holonomic constriants.</p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/WheelBasedCranCrab_1.png\"/></p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/WheelBasedCranCrab_2.png\"/></p>
<p><br/>SELECTED&nbsp;CONTINUOUS&nbsp;TIME&nbsp;STATES</p>
<p>&nbsp;&nbsp;body1.frame_a.phi</p>
<p>&nbsp;&nbsp;body1.r[1]</p>
<p>&nbsp;&nbsp;body1.w</p>
<p>&nbsp;&nbsp;revolute.phi</p>
<p>&nbsp;&nbsp;revolute.w</p>
</html>",
      revisions="<html>
<p>(c) Copyright by Dirk Zimmer</p>
<p>The library was created and is owned by Dr. Dirk Zimmer.</p>
<p>dirk.zimmer@dlr.de</p>
</html>"));
end WheelBasedCranCrab;
