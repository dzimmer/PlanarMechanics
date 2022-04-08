within PlanarMechanics.VehicleComponents.Examples;
model SingleTrackWithEngine "Single track model"
  extends Modelica.Icons.Example;

  Parts.Body bodyFront(
    I=0.1,
    m=2,
    enableGravity=false)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        origin={40,50})));
  VehicleComponents.Wheels.IdealWheelJoint idealWheelFront(
    r={0,1},
    radius=0.3,
    phi_roll(fixed=true))
          annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={0,50})));
  Parts.FixedTranslation chassis(r={0,1})             annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,-40})));
  Parts.Body bodyRear(
    I=0.1,
    m=10,
    phi(fixed=true),
    w(fixed=true),
    v(each fixed=false),
    r(each fixed=true),
    enableGravity=false)
          annotation (Placement(transformation(extent={{30,-90},{50,-70}})));
  VehicleComponents.Wheels.IdealWheelJoint idealWheelRear(
    r={0,1},
    radius=0.3,
    w_roll(fixed=true, start=0),
    phi_roll(fixed=true),
    stateSelect=StateSelect.default)
                annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={0,-80})));
  Joints.Revolute revolute(
    w(fixed=false, start=0),
    stateSelect=StateSelect.always,
    phi(fixed=true, start=0.69813170079773))
               annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,0})));
  Modelica.Mechanics.Rotational.Sources.ConstantTorque engineTorque(
      tau_constant=2)
    annotation (Placement(transformation(extent={{-40,-90},{-20,-70}})));
  Parts.FixedTranslation trail(r={0,-0.1}) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,30})));
  inner PlanarWorld planarWorld(defaultWidthFraction=10, defaultZPosition=0,
    constantGravity={0,0})
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
equation
  connect(idealWheelFront.frame_a, bodyFront.frame_a)
    annotation (Line(
      points={{3.8,50},{30,50}},
      color={95,95,95},
      thickness=0.5));
  connect(chassis.frame_a, idealWheelRear.frame_a) annotation (
      Line(
      points={{20,-50},{20,-80},{3.8,-80}},
      color={95,95,95},
      thickness=0.5));
  connect(bodyRear.frame_a, chassis.frame_a) annotation (Line(
      points={{30,-80},{20,-80},{20,-50}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute.frame_a, chassis.frame_b) annotation (Line(
      points={{20,-10},{20,-30}},
      color={95,95,95},
      thickness=0.5));
  connect(engineTorque.flange, idealWheelRear.flange_a) annotation (
      Line(
      points={{-20,-80},{-10,-80}}));
  connect(trail.frame_a, revolute.frame_b) annotation (Line(
      points={{20,20},{20,10}},
      color={95,95,95},
      thickness=0.5));
  connect(trail.frame_b, idealWheelFront.frame_a) annotation (Line(
      points={{20,40},{20,50},{3.8,50}},
      color={95,95,95},
      thickness=0.5));
  annotation (experiment(StopTime=6),
    Documentation(revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>",
      info="<html>
<p>An ideal rolling single track model of a car.
There is dynamic state selection applied. It might be avoided by picking Rear.v_long as state.</p>
<div>
<img src=\"modelica://PlanarMechanics/Resources/Images/VehicleComponents/Examples/SingleTrackWithEngine_1.png\" alt=\"Diagram SingleTrackWithEngine_1\">
</div>
<div>
<img src=\"modelica://PlanarMechanics/Resources/Images/VehicleComponents/Examples/SingleTrackWithEngine_2.png\" alt=\"Diagram SingleTrackWithEngine_2\">
</div>
</html>"));
end SingleTrackWithEngine;
