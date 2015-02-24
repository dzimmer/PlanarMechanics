within PlanarMechanics.GearComponents.Examples;
model PlanetaryGear "Rigid planetary gearbox"
  extends Modelica.Icons.Example;

  Utilities.RigidNoLossPlanetary planetary(
      useHeatPort=true,
    r_s=1,
    r_p=1,
    r_r=3,
    J_s=1e-3,
    J_p=1e-3,
    J_c=1e-3,
    J_r=1e-3)
    annotation (Placement(transformation(extent={{0,0},{40,40}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,-30})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed SunSpeed(w_fixed=1)
    annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
  Modelica.Mechanics.Rotational.Sources.ConstantTorque RingTorque(tau_constant=
        1) annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
  inner PlanarWorld planarWorld
    annotation (Placement(transformation(extent={{-80,-54},{-60,-34}})));
  inner MB.World world
    annotation (Placement(transformation(extent={{-80,-92},{-60,-72}})));
equation
  connect(heatCapacitor.port, planetary.heatPort) annotation (Line(
      points={{-10,-30},{0,-30},{0,0}},
      color={191,0,0}));
  connect(planetary.flange_Sun,SunSpeed. flange) annotation (Line(
      points={{0,20},{-10,20},{-10,10},{-30,10}}));
  connect(RingTorque.flange, planetary.flange_Ring) annotation (Line(
      points={{-30,40},{-10,40},{-10,32},{0,32}}));
  annotation (Documentation(info="<html>
<p>The model shows the possibilities of the gear connection models.
In this example only one of 3 planets is modelled. This reduction can be done because of the symmetry of the gears. For more advanced topics like load sharing between gears, more advanced models should be used.</p>
<p>
The ring gear is driven using a 1&nbsp;Nm load, the velocity of the sun is fixed to 1&nbsp;rad/s.
</p>
</html>", revisions=
          "<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p></html>"),
    experiment(StopTime=10));
end PlanetaryGear;
