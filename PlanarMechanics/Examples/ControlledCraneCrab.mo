within PlanarMechanics.Examples;
model ControlledCraneCrab
  extends Modelica.Icons.Example;

  Parts.Body body(
    m=70,
    I=0)   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,-70})));
  Parts.FixedTranslation fixedTranslation(r={0,2.5})
                                                    annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,-30})));
  Parts.Fixed fixed annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-70,30})));
  Parts.Body body1(
    m=250,
    I=0,
    a(start={1,0}))
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Mechanics.Translational.Sources.Force force annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,60})));
  Modelica.Blocks.Continuous.PID PID(
    Td=0.2,
    k=-320*9.81*5,
    initType=Modelica.Blocks.Types.InitPID.InitialState,
    xi_start=0,
    Ti=1e9) annotation (Placement(transformation(extent={{40,70},{20,90}})));
  inner PlanarWorld planarWorld
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  Joints.Prismatic prismatic(r={1,0}, useFlange=true,
    s(fixed=true),
    v(fixed=true))
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Joints.Revolute revolute(useFlange=true,
    w(fixed=true),
    phi(fixed=true, start=-0.34906585039887))
                                           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,0})));
equation
  connect(fixedTranslation.frame_b, body.frame_a) annotation (Line(
      points={{-10,-40},{-10,-45},{-10,-45},{-10,-50},{-10,-60},{-10,-60}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(force.f, PID.y) annotation (Line(
      points={{-30,72},{-30,80},{19,80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(angleSensor.phi, PID.u) annotation (Line(
      points={{41,6.10623e-16},{70,6.10623e-16},{70,80},{42,80}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(fixed.frame_a, prismatic.frame_a) annotation (Line(
      points={{-60,30},{-40,30}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(prismatic.frame_b, body1.frame_a) annotation (Line(
      points={{-20,30},{-5.55112e-16,30}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(prismatic.flange_a, force.flange) annotation (Line(
      points={{-30,39},{-30,50}},
      color={0,127,0},
      smooth=Smooth.None));
  connect(prismatic.frame_b, revolute.frame_a) annotation (Line(
      points={{-20,30},{-10,30},{-10,10}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(revolute.frame_b, fixedTranslation.frame_a) annotation (Line(
      points={{-10,-10},{-10,-20}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(revolute.flange_a, angleSensor.flange) annotation (Line(
      points={{5.55112e-16,-1.33731e-15},{10,-1.33731e-15},{10,6.10623e-16},{20,
          6.10623e-16}},
      color={0,0,0},
      smooth=Smooth.None));
  annotation (experiment(StopTime=3),
    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p></html>",  info="<html>
<h4><font color=\"#008000\">A controlled crane crab.</font></h4>
<p>A simple PID (actually PD) controlles the pendulum into upright position.</p>
<p><br/><img src=\"modelica://PlanarMechanics/Resources/Images/ControlledCraneCrab_1.png\"/></p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/ControlledCraneCrab_2.png\"/></p>
<p><br/>SELECTED&nbsp;CONTINUOUS&nbsp;TIME&nbsp;STATES</p>
<p>&nbsp;&nbsp;actuatedPrismatic.s</p>
<p>&nbsp;&nbsp;actuatedPrismatic.v</p>
<p>&nbsp;&nbsp;actuatedRevolute.phi</p>
<p>&nbsp;&nbsp;actuatedRevolute.w</p>
<p>&nbsp;&nbsp;PID.D.x</p>
<p>&nbsp;&nbsp;PID.I.y</p>
<p>&nbsp;</p>
</html>",
      revisions="<html>
<p>(c) Copyright by Dirk Zimmer</p>
<p>The library was created and is owned by Dr. Dirk Zimmer.</p>
<p>dirk.zimmer@dlr.de</p>
</html>"));
end ControlledCraneCrab;
