within PlanarMechanics.GearComponents.Examples;
model SpurGear
  extends Modelica.Icons.Example;

  PlanarMechanics.Joints.Revolute         gearA_Bearing(   useFlange=true,
    w(fixed=false),
    phi(fixed=true))
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(w_fixed=1)
    annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
  PlanarMechanics.Parts.Body gearA(m=1, I=1e-3)
                                 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,50})));
  PlanarMechanics.Parts.FixedTranslation distance(r={2,0})
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  PlanarMechanics.Parts.FixedRotation angle(alpha=0)
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  PlanarMechanics.Parts.Fixed
              fixed  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-74,-32})));
  PlanarMechanics.Parts.Body gearB(m=1, I=1e-3)
                                 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,50})));
  PlanarMechanics.Joints.Revolute         gearB_Bearing(useFlange=true, phi(
        fixed=false))
    annotation (Placement(transformation(extent={{36,10},{56,30}})));
  Modelica.Mechanics.Rotational.Sources.ConstantTorque constantTorque(
      tau_constant=10)
    annotation (Placement(transformation(extent={{-100,58},{-80,78}})));
  inner PlanarMechanics.PlanarWorld planarWorld
    annotation (Placement(transformation(extent={{60,60},{80,80}})));
  RigidNoLossExternal                                                       gearwheelExternal
    annotation (Placement(transformation(extent={{-8,10},{12,30}})));
equation
  connect(angle.frame_b, distance.frame_a)             annotation (Line(
      points={{-20,-10},{0,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(gearA_Bearing.frame_b, gearA.frame_a)
                                            annotation (Line(
      points={{-40,20},{-20,20},{-20,40}},
      color={95,95,95},
      thickness=0.5));
  connect(constantSpeed.flange, gearA_Bearing.flange_a)
                                                 annotation (Line(
      points={{-80,40},{-50,40},{-50,30}}));
  connect(fixed.frame_a, gearA_Bearing.frame_a) annotation (Line(
      points={{-74,-22},{-74,20},{-60,20}},
      color={95,95,95},
      thickness=0.5));
  connect(fixed.frame_a, angle.frame_a) annotation (Line(
      points={{-74,-22},{-74,-10},{-40,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(gearB_Bearing.frame_b, distance.frame_b) annotation (Line(
      points={{56,20},{66,20},{66,-10},{20,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(constantTorque.flange, gearB_Bearing.flange_a) annotation (Line(
      points={{-80,68},{46,68},{46,30}}));
  connect(gearwheelExternal.frame_a, gearA_Bearing.frame_b) annotation (Line(
      points={{-8,20},{-40,20}},
      color={95,95,95},
      thickness=0.5));
  connect(gearwheelExternal.frame_b, gearB_Bearing.frame_a) annotation (Line(
      points={{12,20},{36,20}},
      color={95,95,95},
      thickness=0.5));
  connect(gearwheelExternal.frame_b, gearB.frame_a) annotation (Line(
      points={{12,20},{20,20},{20,40}},
      color={95,95,95},
      thickness=0.5));
  annotation (experiment(StopTime=10),Documentation(info="<html>
<p>Simple example of a spur gear in a planar environment.</p>
</html>", revisions=
          "<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p></html>"));
end SpurGear;
