within PlanarMechanics.Examples;
model KinematicLoop
  extends Modelica.Icons.Example;

  Joints.Revolute revolute(  phi(start=0,fixed=false), stateSelect=StateSelect.always)
                                                              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,50})));
  Joints.Revolute revolute1(phi(start=0, fixed=false))
                            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,50})));
  Joints.Revolute revolute2
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Joints.Revolute revolute3(                                          w(fixed=
          true, start=0), phi(fixed=true, start=-0.69813170079773))
                 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,-30})));
  Parts.FixedTranslation fixedTranslation1(r={0, -0.5}) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,20})));
  Parts.FixedTranslation fixedTranslation2(r={0, -0.5}) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,20})));
  Parts.FixedTranslation fixedTranslation3(r={0, -0.6}) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={10,-50})));
  Parts.Body body(
    m=1,
    I=0.1,
    g={0,-9.81}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={50,-50})));
  Parts.Fixed fixed annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-50,70})));
  Modelica.Mechanics.Translational.Components.SpringDamper springDamper(
    c=20,
    d=4,
    s_rel0=0.4)
         annotation (Placement(transformation(extent={{0,80},{20,100}})));
  Modelica.Mechanics.Translational.Components.Fixed fixed1 annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-46,90})));
  inner PlanarWorld planarWorld
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  Joints.Prismatic prismatic1(
    r={1,0},
    useFlange=true,
    s(fixed=true, start=0.4),
    v(fixed=true, start=0))
    annotation (Placement(transformation(extent={{18,60},{38,80}})));
equation
  connect(fixedTranslation1.frame_a, revolute.frame_b) annotation (Line(
      points={{-20,30},{-20,40}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(fixedTranslation2.frame_a, revolute1.frame_b) annotation (Line(
      points={{80,30},{80,40}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(revolute2.frame_a, fixedTranslation1.frame_b) annotation (Line(
      points={{10,6.66134e-16},{-20,6.66134e-16},{-20,10}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(revolute2.frame_b, fixedTranslation2.frame_b) annotation (Line(
      points={{30,6.66134e-16},{80,6.66134e-16},{80,10}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(fixedTranslation3.frame_a, revolute3.frame_b) annotation (Line(
      points={{-5.55112e-16,-50},{-20,-50},{-20,-40}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(revolute.frame_a, fixed.frame_a) annotation (Line(
      points={{-20,60},{-20,70},{-40,70}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(fixed1.flange, springDamper.flange_a) annotation (Line(
      points={{-46,90},{-5.55112e-16,90}},
      color={0,127,0},
      smooth=Smooth.None));
  connect(revolute3.frame_a, fixedTranslation1.frame_b) annotation (Line(
      points={{-20,-20},{-20,10}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(body.frame_a, fixedTranslation3.frame_b) annotation (Line(
      points={{40,-50},{20,-50}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(prismatic1.frame_a, fixed.frame_a) annotation (Line(
      points={{18,70},{-40,70}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(springDamper.flange_b, prismatic1.flange_a) annotation (Line(
      points={{20,90},{28,90},{28,79}},
      color={0,127,0},
      smooth=Smooth.None));
  connect(prismatic1.frame_b, revolute1.frame_a) annotation (Line(
      points={{38,70},{80,70},{80,60}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (Diagram(graphics),
    experiment(StopTime=6),
    __Dymola_experimentSetupOutput,
    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p></html>",  info="<html>
<p><h4><font color=\"#008000\">An example of a kinematic loop.</font></h4></p>
<p>In this version, the states are manually selected.</p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/KinematicLoop_1.png\"/></p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/KinematicLoop_2.png\"/></p>
<p><br/>SELECTED&nbsp;CONTINUOUS&nbsp;TIME&nbsp;STATES</p>
<p>&nbsp;&nbsp;revolute.phi</p>
<p>&nbsp;&nbsp;revolute.w</p>
<p>&nbsp;&nbsp;revolute3.phi</p>
<p>&nbsp;&nbsp;revolute3.w</p>
<p>&nbsp;</p>
</html>",
      revisions="<html>
<p>(c) Copyright by Dirk Zimmer</p>
<p>The library was created and is owned by Dr. Dirk Zimmer.</p>
<p>dirk.zimmer@dlr.de</p>
</html>"));
end KinematicLoop;
