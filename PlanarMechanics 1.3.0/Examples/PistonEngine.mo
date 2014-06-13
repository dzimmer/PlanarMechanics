within PlanarMechanics.Examples;
model PistonEngine "A Piston Engine"
  extends Modelica.Icons.Example;

  Parts.Body bodyDrive(
    m=1,
    I=0.1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-62,20})));
  Joints.Revolute revoluteDrive(
    phi(fixed=true, start=0),
    w(fixed=true, start=-2.5),
    stateSelect=StateSelect.always)
    annotation (Placement(transformation(extent={{-70,40},{-50,60}})));
  Parts.FixedTranslation fixedTranslationDisc(r={0.3,0})
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Parts.Fixed fixed annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-90,50})));
  Joints.Prismatic prismatic(r={1,0}, s(fixed=false, start=0))
    annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
  Parts.Fixed fixed1   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={70,-50})));
  Joints.Revolute revoluteDisc(phi(fixed=false, start=0))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,30})));
  Parts.FixedTranslation pistonRod(r={0.8,0})
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270)));
  Parts.Body bodyPiston(
    I=0.1,
    m=3)
    annotation (Placement(transformation(extent={{30,-30},{50,-10}})));
  Joints.Revolute revolutePiston
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-30})));
  inner PlanarWorld planarWorld(defaultWidthFraction=10)
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
equation
  connect(fixed.frame_a, revoluteDrive.frame_a)
                                           annotation (Line(
      points={{-80,50},{-70,50}},
      color={95,95,95},
      thickness=0.5));
  connect(revoluteDrive.frame_b, fixedTranslationDisc.frame_a)
                                                      annotation (Line(
      points={{-50,50},{-40,50}},
      color={95,95,95},
      thickness=0.5));
  connect(fixed1.frame_a, prismatic.frame_b) annotation (Line(
      points={{60,-50},{40,-50}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslationDisc.frame_b, revoluteDisc.frame_a) annotation (
      Line(
      points={{-20,50},{0,50},{0,40},{0,40}},
      color={95,95,95},
      thickness=0.5));
  connect(bodyDrive.frame_a, revoluteDrive.frame_b) annotation (Line(
      points={{-52,20},{-44,20},{-44,50},{-50,50}},
      color={95,95,95},
      thickness=0.5));
  connect(revoluteDisc.frame_b, pistonRod.frame_a) annotation (Line(
      points={{0,20},{0,20},{0,10}},
      color={95,95,95},
      thickness=0.5));
  connect(revolutePiston.frame_b, pistonRod.frame_b) annotation (Line(
      points={{0,-20},{0,-12},{0,-12},{
          0,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(prismatic.frame_a, revolutePiston.frame_a) annotation (Line(
      points={{20,-50},{0,-50},{0,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(prismatic.frame_a, bodyPiston.frame_a) annotation (Line(
      points={{20,-50},{14,-50},{14,-20},{30,-20}},
      color={95,95,95},
      thickness=0.5));
  annotation (Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p></html>",  info="<html>
<h4><font color=\"#008000\">A Piston Engine</font></h4>
<p>This example contains an algebraic loop. A non-linear system must be solved for initialization and at simulation.</p>
<p>In this version, the state are manually selected.</p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/PistonEngine_1.png\"/></p>
<p><br/><img src=\"modelica://PlanarMechanics/Resources/Images/PistonEngine_2.png\"/></p>
<p>SELECTED&nbsp;CONTINUOUS&nbsp;TIME&nbsp;STATES</p>
<p>&nbsp;&nbsp;revoluteDrive.phi</p>
<p>&nbsp;&nbsp;revoluteDrive.w</p>
<p>&nbsp;</p>
</html>",
      revisions="<html>
<p>(c) Copyright by Dirk Zimmer</p>
<p>The library was created and is owned by Dr. Dirk Zimmer.</p>
<p>dirk.zimmer@dlr.de</p>
</html>"),
    experiment(StopTime=10));
end PistonEngine;
