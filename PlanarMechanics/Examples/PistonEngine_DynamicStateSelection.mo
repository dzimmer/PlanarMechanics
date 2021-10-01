within PlanarMechanics.Examples;
model PistonEngine_DynamicStateSelection "A piston engine"
  extends Modelica.Icons.Example;

  Parts.Body bodyDrive(
    m=1,
    I=0.1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-62,20})));
  Joints.Revolute revoluteDrive(phi(fixed=true, start=0), w(fixed=true, start=-2.5))
    annotation (Placement(transformation(extent={{-70,40},{-50,60}})));
  Parts.FixedTranslation fixedTranslationDisc(r={0.3,0})
    annotation (Placement(transformation(extent={{-30,40},{-10,60}})));
  Parts.Fixed fixed annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-90,50})));
  Joints.Prismatic prismatic(r={1,0}, s(start=0, fixed=false))
    annotation (Placement(transformation(extent={{30,-60},{50,-40}})));
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
  connect(fixed.frame, revoluteDrive.frame_a) annotation (Line(
      points={{-80,50},{-70,50}},
      color={95,95,95},
      thickness=0.5));
  connect(revoluteDrive.frame_b, fixedTranslationDisc.frame_a)
                                                      annotation (Line(
      points={{-50,50},{-42,50},{-30,50}},
      color={95,95,95},
      thickness=0.5));
  connect(fixed1.frame, prismatic.frame_b) annotation (Line(
      points={{60,-50},{50,-50}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslationDisc.frame_b, revoluteDisc.frame_a) annotation (
      Line(
      points={{-10,50},{0,50},{0,40}},
      color={95,95,95},
      thickness=0.5));
  connect(bodyDrive.frame_a, revoluteDrive.frame_b) annotation (Line(
      points={{-52,20},{-40,20},{-40,50},{-50,50}},
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
      points={{30,-50},{0,-50},{0,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(prismatic.frame_a, bodyPiston.frame_a) annotation (Line(
      points={{30,-50},{20,-50},{20,-20},{30,-20}},
      color={95,95,95},
      thickness=0.5));
  annotation (Documentation(revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<b>Developed 2010-2020 at the DLR Institute of System Dynamics and Control</b>
</p>
</html>",  info="<html>
<p>This example contains an algebraic loop. A non-linear system must be solved for initialization and at simulation.</p>
<p>This version does not stipulate the state selection</p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/Examples/PistonEngine_1.png\" alt=\"Diagram PistonEngine_1\"></p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/Examples/PistonEngine_2.png\" alt=\"Diagram PistonEngine_2\"></p>
<p>Selected continuous time states</p>
<ul>
  <li>There are 2&nbsp;sets of dynamic state selection.
      <ul>
        <li>From set&nbsp;1 there is 1&nbsp;state to be selected from:
            <ul>
              <li>prismatic.s</li>
              <li>revoluteDisc.phi</li>
              <li>revolutePiston.phi</li>
            </ul>
        </li>
        <li>From set&nbsp;2 there is 1&nbsp;state to be selected from:
            <ul>
              <li>prismatic.v</li>
              <li>revoluteDisc.w</li>
              <li>revoluteDrive.w</li>
            </ul>
        </li>
      </ul>
  </li>
</ul>
</html>"),
    experiment(StopTime=10));
end PistonEngine_DynamicStateSelection;
