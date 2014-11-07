within PlanarMechanics.GearComponents.Examples;
model SpurGear "Rigid spur gear"
  extends Modelica.Icons.Example;

  PlanarMechanics.Joints.Revolute         gearA_Bearing(   useFlange=true,
    w(fixed=false),
    phi(fixed=true))
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(w_fixed=1)
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  PlanarMechanics.Parts.Body gearA(m=1, I=1e-3)
                                 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,30})));
  PlanarMechanics.Parts.FixedTranslation distance(r={2,0})
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  PlanarMechanics.Parts.FixedRotation angle(alpha=0)
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  PlanarMechanics.Parts.Fixed
              fixed  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,-52})));
  PlanarMechanics.Parts.Body gearB(m=1, I=1e-3)
                                 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,30})));
  PlanarMechanics.Joints.Revolute         gearB_Bearing(useFlange=true, phi(
        fixed=false))
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Mechanics.Rotational.Sources.ConstantTorque constantTorque(
      tau_constant=10)
    annotation (Placement(transformation(extent={{-100,38},{-80,58}})));
  inner PlanarMechanics.PlanarWorld planarWorld
    annotation (Placement(transformation(extent={{60,60},{80,80}})));
  RigidNoLossExternal                                                       gearwheelExternal
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(angle.frame_b, distance.frame_a)             annotation (Line(
      points={{-20,-30},{-6,-30},{20,-30}},
      color={95,95,95},
      thickness=0.5));
  connect(gearA_Bearing.frame_b, gearA.frame_a)
                                            annotation (Line(
      points={{-40,0},{-20,0},{-20,20}},
      color={95,95,95},
      thickness=0.5));
  connect(constantSpeed.flange, gearA_Bearing.flange_a)
                                                 annotation (Line(
      points={{-80,20},{-50,20},{-50,10}}));
  connect(fixed.frame_a, gearA_Bearing.frame_a) annotation (Line(
      points={{-70,-42},{-70,0},{-60,0}},
      color={95,95,95},
      thickness=0.5));
  connect(fixed.frame_a, angle.frame_a) annotation (Line(
      points={{-70,-42},{-70,-30},{-40,-30}},
      color={95,95,95},
      thickness=0.5));
  connect(gearB_Bearing.frame_b, distance.frame_b) annotation (Line(
      points={{60,0},{66,0},{66,-30},{40,-30}},
      color={95,95,95},
      thickness=0.5));
  connect(constantTorque.flange, gearB_Bearing.flange_a) annotation (Line(
      points={{-80,48},{50,48},{50,10}}));
  connect(gearwheelExternal.frame_a, gearA_Bearing.frame_b) annotation (Line(
      points={{-10,0},{-40,0}},
      color={95,95,95},
      thickness=0.5));
  connect(gearwheelExternal.frame_b, gearB_Bearing.frame_a) annotation (Line(
      points={{10,0},{40,0}},
      color={95,95,95},
      thickness=0.5));
  connect(gearwheelExternal.frame_b, gearB.frame_a) annotation (Line(
      points={{10,0},{20,0},{20,20}},
      color={95,95,95},
      thickness=0.5));
  annotation (experiment(StopTime=10),Documentation(info="<html>
<p>Simple example of a spur gear in a planar environment.
The gear A is driven using a constant velocity of 1&nbsp;rad/s, the gear B is loaded by constant torque of 10&nbsp;Nm.
</p>
</html>", revisions=
          "<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p></html>"));
end SpurGear;
