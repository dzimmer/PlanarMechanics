within PlanarMechanics.VehicleComponents.Examples;
model TwoTrackWithDifferentialGear "Double track model"
  extends Modelica.Icons.Example;

  Parts.Body body(
    g={0,0},
    m=100,
    I=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,90})));
  VehicleComponents.Wheels.DryFrictionWheelJoint WheelJoint1(
    vAdhesion=0.1,
    r = {0,1},
    vSlide=0.3,
    mu_A=1,
    mu_S=0.7,
    radius=0.25,
    N=1000,
    phi_roll(fixed=false))
          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-64,70})));
  Parts.FixedTranslation fixedTranslation1(r={0,2})   annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-10})));
  Parts.Body body1(
    I=0.1,
    g={0,0},
    m=300,
    r(each fixed=true),
    v(each fixed=true),
    phi(fixed=true),
    w(fixed=true))
          annotation (Placement(transformation(extent={{12,-40},{32,-20}})));
  VehicleComponents.Wheels.DryFrictionWheelJoint WheelJoint2(
    r= {0,1},
    vAdhesion=0.1,
    vSlide=0.3,
    mu_A=1,
    mu_S=0.7,
    radius=0.25,
    N=1500,
    phi_roll(fixed=false))
           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-64,-50})));
  Modelica.Mechanics.Rotational.Sources.ConstantTorque constantTorque1(
      tau_constant=25)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        origin={-50,-90})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(
    phi(fixed=true, start=0),
    w(fixed=true, start=0),
    J=1)                    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-90,70})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia1(
    phi(fixed=true, start=0),
    w(fixed=true, start=0),
    J=1)                    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-92,-50})));
  Parts.FixedTranslation fixedTranslation2(r={0.75,0})   annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-20,-50})));
  Parts.FixedTranslation fixedTranslation3(r={-0.75,0})  annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={20,-50})));
  VehicleComponents.Wheels.DryFrictionWheelJoint WheelJoint3(
    r = {0,1},
    vAdhesion=0.1,
    vSlide=0.3,
    mu_A=1,
    mu_S=0.7,
    radius=0.25,
    N=1500)
           annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        origin={64,-50})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia2(
    J=1,
    phi(fixed=true, start=0),
    w(fixed=true, start=0)) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={90,-50})));
  Parts.FixedTranslation fixedTranslation4(r={0.75,0})   annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-20,12})));
  Parts.FixedTranslation fixedTranslation5(r={-0.75,0})  annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={20,12})));
  VehicleComponents.Wheels.DryFrictionWheelJoint WheelJoint4(
    vAdhesion=0.1,
    r={0,1},
    vSlide=0.3,
    mu_A=1,
    mu_S=0.7,
    radius=0.25,
    N=1000)
          annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        origin={64,70})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia3(
    phi(fixed=true, start=0),
    w(fixed=true, start=0),
    J=1)                    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={90,70})));
  Parts.Body body2(
    g={0,0},
    m=100,
    I=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,90})));
  Modelica.Mechanics.Rotational.Sources.Torque torque
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-10,50})));
  Modelica.Blocks.Sources.Pulse pulse(
    period=2,
    offset=0,
    startTime=1,
    width=30,
    amplitude=-2)
    annotation (Placement(transformation(extent={{20,70},{0,90}})));
  VehicleComponents.DifferentialGear differentialGear
    annotation (Placement(transformation(extent={{-10,-82},{10,-62}})));
  Parts.FixedTranslation leftTrail(r={0.,-0.05})         annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,60})));
  Parts.FixedTranslation rightTrail(r={0.,-0.05})        annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,60})));
  inner PlanarWorld planarWorld(defaultWidthFraction=10)
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  Joints.Revolute revolute2(
    useFlange=true,
    phi(fixed=true, start=-0.43633231299858),
    w(fixed=true))  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,30})));
  Joints.Revolute revolute(useFlange=true) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={40,30})));
equation
  connect(WheelJoint2.flange_a, inertia1.flange_b) annotation (Line(
      points={{-74,-50},{-82,-50}}));
  connect(inertia.flange_b, WheelJoint1.flange_a) annotation (Line(
      points={{-80,70},{-74,70}}));
  connect(fixedTranslation2.frame_b, fixedTranslation1.frame_a) annotation (
     Line(
      points={{-10,-50},{0,-50},{0,-20}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation2.frame_a, WheelJoint2.frame_a) annotation (Line(
      points={{-30,-50},{-59.2,-50}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation3.frame_b, fixedTranslation1.frame_a) annotation (
     Line(
      points={{10,-50},{0,-50},{0,-20}},
      color={95,95,95},
      thickness=0.5));
  connect(WheelJoint3.frame_a, fixedTranslation3.frame_a) annotation (Line(
      points={{59.2,-50},{30,-50}},
      color={95,95,95},
      thickness=0.5));
  connect(inertia2.flange_b, WheelJoint3.flange_a) annotation (Line(
      points={{80,-50},{74,-50}}));
  connect(body1.frame_a, fixedTranslation1.frame_a) annotation (Line(
      points={{12,-30},{0,-30},{0,-20}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation1.frame_b, fixedTranslation4.frame_b) annotation (
     Line(
      points={{0,0},{0,0},{0,12},{-10,12}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation1.frame_b, fixedTranslation5.frame_b) annotation (
     Line(
      points={{0,0},{0,0},{0,12},{10,12}},
      color={95,95,95},
      thickness=0.5));
  connect(inertia3.flange_b, WheelJoint4.flange_a) annotation (Line(
      points={{80,70},{74,70}}));
  connect(pulse.y, torque.tau) annotation (Line(
      points={{-1,80},{-10,80},{-10,62}},
      color={0,0,127}));
  connect(differentialGear.flange_right, WheelJoint3.flange_a) annotation (
      Line(
      points={{10,-72},{74,-72},{74,-50}}));
  connect(differentialGear.flange_left, WheelJoint2.flange_a) annotation (
      Line(
      points={{-10,-72},{-74,-72},{-74,-50}}));
  connect(constantTorque1.flange, differentialGear.flange_b) annotation (
      Line(
      points={{-40,-90},{0,-90},{0,-82}}));
  connect(body.frame_a, leftTrail.frame_b) annotation (Line(
      points={{-40,80},{-40,70}},
      color={95,95,95},
      thickness=0.5));
  connect(leftTrail.frame_b, WheelJoint1.frame_a) annotation (Line(
      points={{-40,70},{-59.2,70}},
      color={95,95,95},
      thickness=0.5));
  connect(body2.frame_a, rightTrail.frame_b) annotation (Line(
      points={{40,80},{40,70}},
      color={95,95,95},
      thickness=0.5));
  connect(WheelJoint4.frame_a, rightTrail.frame_b) annotation (Line(
      points={{59.2,70},{40,70}},
      color={95,95,95},
      thickness=0.5));
  connect(leftTrail.frame_a, revolute2.frame_a) annotation (Line(
      points={{-40,50},{-40,40}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute2.frame_b, fixedTranslation4.frame_a) annotation (Line(
      points={{-40,20},{-40,12},{-30,12}},
      color={95,95,95},
      thickness=0.5));
  connect(torque.flange, revolute2.flange_a) annotation (Line(
      points={{-10,40},{-10,30},{-30,30}}));
  connect(revolute.flange_a, revolute2.flange_a) annotation (Line(
      points={{30,30},{30,30},{-30,30}}));
  connect(revolute.frame_a, rightTrail.frame_a) annotation (Line(
      points={{40,40},{40,50}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute.frame_b, fixedTranslation5.frame_a) annotation (Line(
      points={{40,20},{40,12},{30,12}},
      color={95,95,95},
      thickness=0.5));
  annotation (experiment(StopTime=10),
    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p></html>",  info="<html>
<p>Two track model of a car.</p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/SimpleCarWithDifferentialGear_1.png\"/></p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/SimpleCarWithDifferentialGear_2.png\"/></p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/SimpleCarWithDifferentialGear_3.png\"/></p>
<p>&nbsp;&nbsp;</p>
<p>SELECTED&nbsp;CONTINUOUS&nbsp;TIME&nbsp;STATES</p>
<p>&nbsp;&nbsp;actuatedRevolute.phi</p>
<p>&nbsp;&nbsp;actuatedRevolute.w</p>
<p>&nbsp;&nbsp;body.v[1]</p>
<p>&nbsp;&nbsp;body1.frame_a.phi</p>
<p>&nbsp;&nbsp;body1.r[1]</p>
<p>&nbsp;&nbsp;body1.r[2]</p>
<p>&nbsp;&nbsp;body1.w</p>
<p>&nbsp;&nbsp;body2.v[2]</p>
<p>&nbsp;&nbsp;inertia.phi</p>
<p>&nbsp;&nbsp;inertia.w</p>
<p>&nbsp;&nbsp;inertia1.phi</p>
<p>&nbsp;&nbsp;inertia1.w</p>
<p>&nbsp;&nbsp;inertia2.phi</p>
<p>&nbsp;&nbsp;inertia2.w</p>
<p>&nbsp;&nbsp;inertia3.phi</p>
<p>&nbsp;&nbsp;inertia3.w</p>
</html>",
      revisions="<html>
<p>(c) Copyright by Dirk Zimmer</p>
<p>The library was created and is owned by Dr. Dirk Zimmer.</p>
<p>dirk.zimmer@dlr.de</p>
</html>"));
end TwoTrackWithDifferentialGear;
