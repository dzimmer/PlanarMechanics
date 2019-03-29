within PlanarMechanics.Examples;
model PendulumExcited "A swinging pendulum excited by a world force"
  extends Modelica.Icons.Example;

  Parts.Body body(
    m=1,
    I=0.1)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Joints.Revolute revolute(
    useFlange=false,
    phi(fixed=true, start=0),
    w(fixed=true, start=0),
    stateSelect=StateSelect.always)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Parts.FixedTranslation fixedTranslation(r= {1,0})
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Parts.Fixed fixed(phi=0) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-60,0})));
  inner PlanarWorld planarWorld(defaultWidthFraction=10, defaultN_to_m=10)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Sensors.CutForce cutForce(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Sources.WorldForce worldForce(color={255,0,0}, resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_b)
    annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
  Modelica.Blocks.Sources.Sine signalVec3[3](
    each freqHz=1,
    amplitude={0,-5,0},
    each startTime=1.8) "Vector of three excitation signals"
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
equation
  connect(revolute.frame_b, fixedTranslation.frame_a) annotation (Line(
      points={{-20,0},{-15,0},{-10,0}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute.frame_a, fixed.frame) annotation (Line(
      points={{-40,0},{-46,0},{-46,-1.22125e-015},{-50,-1.22125e-015}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation.frame_b, cutForce.frame_a) annotation (Line(
      points={{10,0},{20,0}},
      color={95,95,95},
      thickness=0.5));
  connect(cutForce.frame_b, body.frame_a) annotation (Line(
      points={{40,0},{60,0}},
      color={95,95,95},
      thickness=0.5));
  connect(worldForce.frame_b, body.frame_a) annotation (Line(
      points={{40,-40},{50,-40},{50,0},{60,0}},
      color={95,95,95},
      thickness=0.5));
  connect(signalVec3.y, worldForce.force) annotation (Line(
      points={{1,-40},{18,-40}},
      color={0,0,127}));
  annotation (experiment(StopTime=3),
    Documentation(revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<b>Developed 2010-2019 at the DLR Institute of System Dynamics and Control</b>
</p>
</html>",  info="<html>
<p>
This example demonstrates simple pendulum excited by a world force.
The animation parameters of cut and excitation forces can be changed
at once using default parameters of planarWorld.
</p>
</html>"));
end PendulumExcited;
