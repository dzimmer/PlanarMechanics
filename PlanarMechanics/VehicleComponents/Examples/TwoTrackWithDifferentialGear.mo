within PlanarMechanics.VehicleComponents.Examples;
model TwoTrackWithDifferentialGear "AcceleratingBody"
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
        origin={-62,70})));
  Parts.FixedTranslation fixedTranslation1(r={0,2})   annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-2})));
  Parts.Body body1(
    I=0.1,
    g={0,0},
    m=300,
    r(fixed=true),
    v(fixed=true),
    phi(fixed=true),
    w(fixed=true))
          annotation (Placement(transformation(extent={{12,-30},{32,-10}})));
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
        origin={-60,-40})));
  Modelica.Mechanics.Rotational.Sources.ConstantTorque constantTorque1(
      tau_constant=25)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-50,-80})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(
    phi(fixed=true, start=0),
    w(fixed=true, start=0),
    J=1)                    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-90,70})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia1(
    phi(fixed=true, start=0),
    w(fixed=true, start=0),
    J=1)                    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-92,-40})));
  Parts.FixedTranslation fixedTranslation2(r={0.75,0})   annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-20,-40})));
  Parts.FixedTranslation fixedTranslation3(r={-0.75,0})  annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={20,-40})));
  VehicleComponents.Wheels.DryFrictionWheelJoint WheelJoint3(
    r = {0,1},
    vAdhesion=0.1,
    vSlide=0.3,
    mu_A=1,
    mu_S=0.7,
    radius=0.25,
    N=1500)
           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={62,-40})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia2(
    J=1,
    phi(fixed=true, start=0),
    w(fixed=true, start=0)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,-40})));
  Parts.FixedTranslation fixedTranslation4(r={0.75,0})   annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-20,20})));
  Parts.FixedTranslation fixedTranslation5(r={-0.75,0})  annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={20,20})));
  VehicleComponents.Wheels.DryFrictionWheelJoint WheelJoint4(
    vAdhesion=0.1,
    r={0,1},
    vSlide=0.3,
    mu_A=1,
    mu_S=0.7,
    radius=0.25,
    N=1000)
          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={60,70})));
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
    annotation (Placement(transformation(extent={{-10,70},{-30,90}})));
  Modelica.Blocks.Sources.Pulse pulse(
    period=2,
    offset=0,
    startTime=1,
    width=30,
    amplitude=-2)
    annotation (Placement(transformation(extent={{20,70},{0,90}})));
  VehicleComponents.DifferentialGear differentialGear
    annotation (Placement(transformation(extent={{-10,-72},{10,-52}})));
  Parts.FixedTranslation leftTrail(r={0.,-0.05})         annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,64})));
  Parts.FixedTranslation rightTrail(r={0.,-0.05})        annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,64})));
  inner PlanarWorld planarWorld(defaultWidthFraction=10)
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  Joints.Revolute revolute2(
    useFlange=true,
    phi(fixed=true, start=-0.43633231299858),
    w(fixed=true))  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,40})));
  Joints.Revolute revolute(useFlange=true) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={40,40})));
equation
  connect(WheelJoint2.flange_a, inertia1.flange_b) annotation (Line(
      points={{-70,-40},{-82,-40}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(inertia.flange_b, WheelJoint1.flange_a) annotation (Line(
      points={{-80,70},{-72,70}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(fixedTranslation2.frame_b, fixedTranslation1.frame_a) annotation (
     Line(
      points={{-10,-40},{0,-40},{0,-12},{-1.68214e-16,-12}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(fixedTranslation2.frame_a, WheelJoint2.frame_a) annotation (Line(
      points={{-30,-40},{-55.2,-40}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(fixedTranslation3.frame_b, fixedTranslation1.frame_a) annotation (
     Line(
      points={{10,-40},{-1.68214e-16,-40},{-1.68214e-16,-12}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(WheelJoint3.frame_a, fixedTranslation3.frame_a) annotation (Line(
      points={{57.2,-40},{30,-40}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(inertia2.flange_b, WheelJoint3.flange_a) annotation (Line(
      points={{80,-40},{72,-40}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(body1.frame_a, fixedTranslation1.frame_a) annotation (Line(
      points={{12,-20},{-1.68214e-16,-20},{-1.68214e-16,-12}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(fixedTranslation1.frame_b, fixedTranslation4.frame_b) annotation (
     Line(
      points={{1.05639e-15,8},{0,8},{0,20},{-10,20}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(fixedTranslation1.frame_b, fixedTranslation5.frame_b) annotation (
     Line(
      points={{1.05639e-15,8},{0,8},{0,20},{10,20}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(inertia3.flange_b, WheelJoint4.flange_a) annotation (Line(
      points={{80,70},{70,70}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(pulse.y, torque.tau) annotation (Line(
      points={{-1,80},{-8,80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(differentialGear.flange_right, WheelJoint3.flange_a) annotation (
      Line(
      points={{10,-62},{78,-62},{78,-40},{72,-40}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(differentialGear.flange_left, WheelJoint2.flange_a) annotation (
      Line(
      points={{-10,-62},{-70,-62},{-70,-40}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(constantTorque1.flange, differentialGear.flange_b) annotation (
      Line(
      points={{-40,-80},{6.10623e-16,-72}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(body.frame_a, leftTrail.frame_b) annotation (Line(
      points={{-40,80},{-40,74}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(leftTrail.frame_b, WheelJoint1.frame_a) annotation (Line(
      points={{-40,74},{-52,74},{-52,70},{-57.2,70}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(body2.frame_a, rightTrail.frame_b) annotation (Line(
      points={{40,80},{40,74}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(WheelJoint4.frame_a, rightTrail.frame_b) annotation (Line(
      points={{55.2,70},{44,70},{44,74},{40,74}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(leftTrail.frame_a, revolute2.frame_a) annotation (Line(
      points={{-40,54},{-40,50}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(revolute2.frame_b, fixedTranslation4.frame_a) annotation (Line(
      points={{-40,30},{-40,20},{-30,20}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(torque.flange, revolute2.flange_a) annotation (Line(
      points={{-30,80},{-30,40}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(revolute.flange_a, revolute2.flange_a) annotation (Line(
      points={{30,40},{-30,40}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(revolute.frame_a, rightTrail.frame_a) annotation (Line(
      points={{40,50},{40,54}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(revolute.frame_b, fixedTranslation5.frame_a) annotation (Line(
      points={{40,30},{40,20},{30,20}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics),
    experiment(StopTime=10),
    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p></html>",  info="<html>
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
<p>The library was creates and is owned by Dr. Dirk Zimmer. </p>
<p>dirk.zimmer@dlr.de</p>
</html>"));
end TwoTrackWithDifferentialGear;
