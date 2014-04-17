within PlanarMechanics.Examples;
model KinematicLoop_DynamicStateSelection
  extends Modelica.Icons.Example;

  Joints.Revolute revolute                        annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,50})));
  Joints.Revolute revolute1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,50})));
  Joints.Revolute revolute2
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Joints.Revolute revolute3(phi(fixed=true, start=-0.69813170079773), w(fixed=
          true, start=0))
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
    I=0.1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={50,-50})));
  Parts.Fixed fixed annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-50,70})));
  Modelica.Mechanics.Translational.Components.SpringDamper springDamper(
    c=20,
    s_rel0=0.4,
    d=4) annotation (Placement(transformation(extent={{0,80},{20,100}})));
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
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
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
      points={{-20,-20},{-20,-5},{-20,-5},{-20,10}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(body.frame_a, fixedTranslation3.frame_b) annotation (Line(
      points={{40,-50},{20,-50}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(fixed.frame_a, prismatic1.frame_a) annotation (Line(
      points={{-40,70},{20,70}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(prismatic1.frame_b, revolute1.frame_a) annotation (Line(
      points={{40,70},{80,70},{80,60}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(springDamper.flange_b, prismatic1.flange_a) annotation (Line(
      points={{20,90},{30,90},{30,79}},
      color={0,127,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics),
    experiment(StopTime=6),
    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p></html>",  info="<html>
<p><h4><font color=\"#008000\">An example of a kinematic loop.</font></h4></p>
<p>In this version, the states are not manually set but might be dynamically selected by the simulation environment.</p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/KinematicLoop_1.png\"/></p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/KinematicLoop_2.png\"/></p>
<p><br/>SELECTED&nbsp;CONTINUOUS&nbsp;TIME&nbsp;STATES</p>
<p>&nbsp;&nbsp;revolute3.phi</p>
<p>&nbsp;&nbsp;revolute3.w</p>
<p>&nbsp;</p>
<p>There&nbsp;are&nbsp;2&nbsp;sets&nbsp;of&nbsp;dynamic&nbsp;state&nbsp;selection.</p>
<p>From&nbsp;set&nbsp;1&nbsp;there&nbsp;is&nbsp;1&nbsp;state&nbsp;to&nbsp;be&nbsp;selected&nbsp;from:</p>
<p>&nbsp;&nbsp;actuatedPrismatic.s</p>
<p>&nbsp;&nbsp;revolute.phi</p>
<p>&nbsp;&nbsp;revolute2.phi</p>
<p>&nbsp;</p>
<p>From&nbsp;set&nbsp;2&nbsp;there&nbsp;is&nbsp;1&nbsp;state&nbsp;to&nbsp;be&nbsp;selected&nbsp;from:</p>
<p>&nbsp;&nbsp;actuatedPrismatic.v</p>
<p>&nbsp;&nbsp;revolute.w</p>
<p>&nbsp;&nbsp;revolute2.w</p>
</html>",
      revisions="<html>
<p>(c) Copyright by Dirk Zimmer</p>
<p>The library was created and is owned by Dr. Dirk Zimmer.</p>
<p>dirk.zimmer@dlr.de</p>
</html>"));
end KinematicLoop_DynamicStateSelection;
