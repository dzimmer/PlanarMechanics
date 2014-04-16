within PlanarMechanics.Examples;
model PistonEngine_DynamicStateSelection "A Piston Engine"
  extends Modelica.Icons.Example;

  Parts.Body bodyDrive(
    m=1,
    I=0.1,
    g={0,-9.81})
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-62,20})));
  Joints.Revolute revoluteDrive(phi(fixed=true, start=0), w(fixed=true, start=-2.5))
    annotation (Placement(transformation(extent={{-70,40},{-50,60}})));
  Parts.FixedTranslation fixedTranslationDisc(r={0.3,0})
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Parts.Fixed fixed annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-90,50})));
  Joints.Prismatic prismatic(r={1,0}, s(start=0, fixed=false))
    annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
  Parts.Fixed fixed1   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={70,-50})));
  Joints.Revolute revoluteDisc(phi(fixed=false, start=0))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,30})));
  Parts.FixedTranslation pistonRod(r={0.8,0})
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,0})));
  Parts.Body bodyPiston(
    I=0.1,
    g={0,-9.81},
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
      thickness=0.5,
      smooth=Smooth.None));
  connect(revoluteDrive.frame_b, fixedTranslationDisc.frame_a)
                                                      annotation (Line(
      points={{-50,50},{-40,50}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(fixed1.frame_a, prismatic.frame_b) annotation (Line(
      points={{60,-50},{40,-50}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(fixedTranslationDisc.frame_b, revoluteDisc.frame_a) annotation (
      Line(
      points={{-20,50},{0,50},{0,40},{2.50304e-15,40}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(bodyDrive.frame_a, revoluteDrive.frame_b) annotation (Line(
      points={{-52,20},{-44,20},{-44,50},{-50,50}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(revoluteDisc.frame_b, pistonRod.frame_a) annotation (Line(
      points={{-1.17078e-15,20},{2.50304e-15,20},{2.50304e-15,10}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(revolutePiston.frame_b, pistonRod.frame_b) annotation (Line(
      points={{1.05639e-15,-20},{1.05639e-15,-12},{-1.17078e-15,-12},{
          -1.17078e-15,-10}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(prismatic.frame_a, revolutePiston.frame_a) annotation (Line(
      points={{20,-50},{-1.68214e-16,-50},{-1.68214e-16,-40}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(prismatic.frame_a, bodyPiston.frame_a) annotation (Line(
      points={{20,-50},{14,-50},{14,-20},{30,-20}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (Diagram(graphics),
    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p></html>",  info="<html>
<p><h4><font color=\"#008000\">A PistonEngine</font></h4></p>
<p>This example contains an algebraic loop. A non-linear system must be solved for initialization and at simulation.</p>
<p>This version does not stipulate the state selection</p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/PistonEngine_1.png\"/></p>
<p><br/><img src=\"modelica://PlanarMechanics/Resources/Images/PistonEngine_2.png\"/></p>
<p><br/>SELECTED&nbsp;CONTINUOUS&nbsp;TIME&nbsp;STATES</p>
<p><br/>There&nbsp;are&nbsp;2&nbsp;sets&nbsp;of&nbsp;dynamic&nbsp;state&nbsp;selection.</p>
<p>From&nbsp;set&nbsp;1&nbsp;there&nbsp;is&nbsp;1&nbsp;state&nbsp;to&nbsp;be&nbsp;selected&nbsp;from:</p>
<p>&nbsp;&nbsp;prismatic.s</p>
<p>&nbsp;&nbsp;revoluteDisc.phi</p>
<p>&nbsp;&nbsp;revolutePiston.phi</p>
<p>&nbsp;</p>
<p>From&nbsp;set&nbsp;2&nbsp;there&nbsp;is&nbsp;1&nbsp;state&nbsp;to&nbsp;be&nbsp;selected&nbsp;from:</p>
<p>&nbsp;&nbsp;prismatic.v</p>
<p>&nbsp;&nbsp;revoluteDisc.w</p>
<p>&nbsp;&nbsp;revoluteDrive.w</p>
<p>&nbsp;</p>
</html>",
      revisions="<html>
<p>(c) Copyright by Dirk Zimmer</p>
<p>The library was created and is owned by Dr. Dirk Zimmer.</p>
<p>dirk.zimmer@dlr.de</p>
</html>"),
    experiment(StopTime=10),
    __Dymola_experimentSetupOutput);
end PistonEngine_DynamicStateSelection;
