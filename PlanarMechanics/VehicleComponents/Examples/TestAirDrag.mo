within PlanarMechanics.VehicleComponents.Examples;
model TestAirDrag "Test air drag model"
  extends Modelica.Icons.Example;

  AirResistanceLongitudinal airDrag(
    c_W=0.5,
    area=1.2,
    rho(displayUnit="kg/m3") = 1.18,
    r={1,0}) annotation (Placement(transformation(extent={{-20,10},{-40,30}})));
  Sensors.AbsoluteVelocity sensorAbsoluteVelocity(
    resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a) annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Parts.Body body(m=10, I=1,
    animate=false)
    annotation (Placement(transformation(extent={{20,10},{40,30}})));
  Parts.FixedTranslation fixedTranslation(r={0,2})
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-10})));
  Joints.Revolute revolute(
    phi(fixed=true),
    w(fixed=false, start=-5),
    stateSelect=StateSelect.always)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-40})));
  Parts.Fixed fixed annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-70})));
  inner PlanarWorld planarWorld(enableAnimation=true, constantGravity={0,0})
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
equation
  connect(fixedTranslation.frame_a, revolute.frame_b) annotation (Line(
      points={{0,-20},{0,-20},{0,-30}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute.frame_a, fixed.frame) annotation (Line(
      points={{0,-50},{0,-50},{0,-60}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation.frame_b, airDrag.frame_a) annotation (Line(
      points={{0,0},{0,20},{-20,20}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation.frame_b, sensorAbsoluteVelocity.frame_a) annotation (Line(
      points={{0,0},{0,50},{20,50}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation.frame_b, body.frame_a) annotation (Line(
      points={{0,0},{0,20},{20,20}},
      color={95,95,95},
      thickness=0.5));
  annotation (
    experiment(
      StopTime=10),
    Documentation(
      revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>",
      info="<html>
<p>
Simple model to test air resistance. A&nbsp;<code>body</code> performs
circular movement around an origin of inertial frame (world).
The movement is decelerated due to air resistance of the body. 
</p>
<p>
The following diagrams show the translational velocity
of the body (above) and the drag force and its components (below). 
</p>
<div>
<img src=\"modelica://PlanarMechanics/Resources/Images/VehicleComponents/Examples/TestAirDrag_1.png\" alt=\"Diagram TestAirDrag_1\">
</div>
</html>",
      figures = {
        Figure(
          identifier = "test-air-drag",
          preferred = true,
          plots = {
            Plot(
              identifier = "velocity",
              curves = {
                Curve(y = sensorAbsoluteVelocity.v[1]),
                Curve(y = airDrag.vAir[1])}),
            Plot(
              identifier = "air-drag",
              y = Axis(unit = "rad"),
              curves = {
                Curve(y = airDrag.frame_a.fx),
                Curve(y = airDrag.frame_a.fy),
                Curve(y = airDrag.fDrag)})},
          caption = "%(plot:test-air-drag) Test air drag")}));
end TestAirDrag;
