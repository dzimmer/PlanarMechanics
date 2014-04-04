within PlanarMechanics.GearComponents.Examples;
model PlanetaryGear
  extends Modelica.Icons.Example;

  Utilities.RigidNoLossPlanetary                            planetary(
      useHeatPort=true,
    r_s=1,
    r_p=1,
    r_r=3,
    J_s=1e-3,
    J_p=1e-3,
    J_c=1e-3,
    J_r=1e-3)
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=1)
    annotation (Placement(transformation(extent={{-28,-56},{-8,-36}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed
                                              SunSpeed(w_fixed=1)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Mechanics.Rotational.Sources.ConstantTorque RingTorque(tau_constant=
        1) annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
equation
  connect(heatCapacitor.port, planetary.heatPort) annotation (Line(
      points={{-18,-56},{0,-56},{0,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(planetary.flange_Sun,SunSpeed. flange) annotation (Line(
      points={{0,10},{-12,10},{-12,0},{-30,0}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(RingTorque.flange, planetary.flange_Ring) annotation (Line(
      points={{-30,30},{-10,30},{-10,16},{0,16}},
      color={0,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics), Documentation(info="<html>
<p>Example of a rigid planetary gearbox. </p>
<p>The ring gear is driven using a 1Nm load, the velocity of the sun is fixed to 1 rad/s. The model shows the possibilities of the gear connection models.</p>
<p><br>In this example only one of 3 planets is modelled. This reduction can be done because of the symmetry of the gears. For more advanced topics like load sharing between gears, more advanced models should be used.</p>
</html>", revisions=
          "<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p></html>"),
    experiment(StopTime=10),
    __Dymola_experimentSetupOutput);
end PlanetaryGear;
