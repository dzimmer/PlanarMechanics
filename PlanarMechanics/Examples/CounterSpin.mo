within PlanarMechanics.Examples;
model CounterSpin
  extends Modelica.Icons.Example;

  Parts.Body body(
    m=0.01,
    I=0.0005,
    animate=false,
    r(fixed=false),
    v(fixed=false))
              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-10,0})));
  inner PlanarWorld planarWorld
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Joints.DryFrictionBasedRolling slipBasedRolling1(
    R=0.1,
    vAdhesion=0.01,
    mu_S=0.15,
    initialize=true,
    phi(fixed=true),
    w(fixed=true, start=15),
    vx(fixed=true, start=2),
    x(fixed=true),
    vSlide=0.03,
    mu_A=0.5) annotation (Placement(transformation(extent={{20,-10},{40,10}})));
equation
  connect(body.frame_a, slipBasedRolling1.frame_a) annotation (Line(
      points={{0,0},{20,0}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (Diagram(graphics),
    experiment(StopTime=3),
    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p></html>",  info="<html>
<p><h4><font color=\"#008000\">Wheel with counter-spin and dry-friction law.</font></h4></p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/CounterSpin_1.png\"/></p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/CounterSpin_2.png\"/></p>
<p><br/><br/>The model contains a large local stiffness before 2s</p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/CounterSpin_3.png\"/></p>
<p><br/>SELECTED&nbsp;CONTINUOUS&nbsp;TIME&nbsp;STATES</p>
<p>&nbsp;&nbsp;body.r[1]</p>
<p>&nbsp;&nbsp;body.v[1]</p>
<p>&nbsp;&nbsp;slipBasedRolling.phi</p>
<p>&nbsp;&nbsp;slipBasedRolling.w</p>
<p>&nbsp;</p>
</html>",
      revisions="<html>
<p>(c) Copyright by Dirk Zimmer</p>
<p>The library was created and is owned by Dr. Dirk Zimmer.</p>
<p>dirk.zimmer@dlr.de</p>
</html>"));
end CounterSpin;
