within PlanarMechanics.GearComponents.Examples.Utilities;
model RigidNoLossPlanetary "planetary gearbox"
  extends
    PlanarMechanics.GearComponents.Examples.Utilities.Interfaces.PlanetaryGearInterface;

      parameter SI.Distance r_s(start=1) "radius of sun gear";
  parameter SI.Distance r_p(start=1) "radius of planet gear";
  parameter SI.Distance r_r(start=3) "radius of ring gear";

  parameter SI.Inertia J_s(start=1e-3) "inertia of the sun gear";
  parameter SI.Inertia J_p(start=1e-3) "inertia of the planet gear";
  parameter SI.Inertia J_c(start=1e-3) "inertia of the carrier";
  parameter SI.Inertia J_r(start=1e-3) "inertia of the ring gear";

  parameter Boolean animate = true "= true, if animation shall be enabled" annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));

  parameter Integer Tooth_a(min=1) = 20 "Number of Tooth" annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animate));
  parameter Real RGB_s[3]={195,0,0} "Color (RGB values)" annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animate));
  parameter Real RGB_p[3]={0,195,195} "Color (RGB values)" annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animate));
  parameter Real RGB_r[3]={0,0,195} "Color (RGB values)" annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animate));
  parameter SI.Distance z_offset=0 "z-distane offset for simulation" annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animate));

  PlanarMechanics.Parts.Body planet(
    m=1,
    I=1e-3,
    phi(fixed=false))            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={82,40})));
  PlanarMechanics.Parts.FixedTranslation carrierPart(r={r_s + r_p,0})
    annotation (Placement(transformation(extent={{-8,-50},{12,-30}})));
  PlanarMechanics.Parts.Fixed
              Fixed  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-90,30})));
  RigidNoLossExternal                                                       sunPlanet(
      useHeatPort=true,
      Tooth_a=40,
      StartAngle_b=0,
      StartAngle_a=-2*3.1415/40/4,
      r_a=r_s,
      r_b=r_p,
      RGB_a=RGB_s,
      RGB_b=RGB_p,
      animate=animate)
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  PlanarMechanics.Parts.FixedRotation carrierAngle(alpha=0)
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  PlanarMechanics.Joints.Revolute
                  bearing_Planet
    annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
  RigidNoLossInternal                                                       planetRing(
      useHeatPort=true,
      Tooth_a=40,
      z_offset=0.15,
      r_a=r_p,
      r_b=r_r,
      animate=animate,
      RGB_a=RGB_p,
      RGB_b=RGB_r) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={10,40})));
  inner PlanarMechanics.PlanarWorld planarWorld(animateGravity=false,
      enableAnimation=animate)
    annotation (Placement(transformation(extent={{34,70},{54,90}})));
  PlanarMechanics.Joints.Revolute bearing_Sun(useFlange=true)
    annotation (Placement(transformation(extent={{-70,-20},{-50,0}})));
  PlanarMechanics.Joints.Revolute bearing_Carrier(useFlange=true)
    annotation (Placement(transformation(extent={{-70,-50},{-50,-30}})));
  PlanarMechanics.Joints.Revolute bearing_Ring(useFlange=true)
    annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
  Modelica.Mechanics.Rotational.Components.Inertia sun(J=J_s)
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Mechanics.Rotational.Components.Inertia carrier(J=J_c, phi(
        start=0))
    annotation (Placement(transformation(extent={{70,-40},{90,-20}})));
  Modelica.Mechanics.Rotational.Components.Inertia ring(J=J_r)
    annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
equation
  connect(carrierAngle.frame_b, carrierPart.frame_a)   annotation (Line(
      points={{-20,-40},{-8,-40}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(bearing_Planet.frame_a, carrierPart.frame_b)  annotation (Line(
      points={{20,-40},{12,-40}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(planetRing.frame_a, bearing_Planet.frame_b) annotation (Line(
      points={{20,40},{48,40},{48,-40},{40,-40}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(sunPlanet.frame_b, planetRing.frame_a) annotation (Line(
      points={{20,-10},{48,-10},{48,40},{20,40}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(Fixed.frame_a, bearing_Sun.frame_a) annotation (Line(
      points={{-80,30},{-80,-10},{-70,-10}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(bearing_Sun.flange_a, flange_Sun) annotation (Line(
      points={{-60,0},{-100,0}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(bearing_Carrier.frame_b, carrierAngle.frame_a) annotation (Line(
      points={{-50,-40},{-40,-40}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(bearing_Carrier.frame_a, Fixed.frame_a) annotation (Line(
      points={{-70,-40},{-80,-40},{-80,30}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(bearing_Ring.frame_a, Fixed.frame_a) annotation (Line(
      points={{-70,40},{-80,40},{-80,30}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(bearing_Ring.flange_a, flange_Ring) annotation (Line(
      points={{-60,50},{-60,60},{-100,60}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(planet.frame_a, bearing_Planet.frame_b) annotation (Line(
      points={{72,40},{48,40},{48,-40},{40,-40}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(sun.flange_a, bearing_Sun.flange_a) annotation (Line(
      points={{-40,10},{-60,10},{-60,0}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(bearing_Sun.frame_b, sunPlanet.frame_a) annotation (Line(
      points={{-50,-10},{0,-10}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(carrier.flange_b, flange_Carrier) annotation (Line(
      points={{90,-30},{100,-30},{100,0}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(bearing_Ring.frame_b, planetRing.frame_b) annotation (Line(
      points={{-50,40},{0,40}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(ring.flange_a, bearing_Ring.flange_a) annotation (Line(
      points={{-40,60},{-60,60},{-60,50}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(sunPlanet.heatPort, internalHeatPort) annotation (Line(
      points={{0,-20},{60,-20},{60,-60},{-90,-60},{-90,-80},{-100,-80}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(planetRing.heatPort, internalHeatPort) annotation (Line(
      points={{20,50},{60,50},{60,-60},{-90,-60},{-90,-80},{-100,-80}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(bearing_Carrier.flange_a, carrier.flange_a) annotation (Line(
      points={{-60,-30},{70,-30}},
      color={0,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics), Documentation(info="<html>
<p>This model is a model of a standard planetary gearbox. The inertia of all gear models, as well as the mass of the planetary gear can be entered to get the behaviour of a complete planetary gear. In this example only one planet is used as the gearbox models are rigid.</p>
</html>", revisions=
          "<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p></html>"));
end RigidNoLossPlanetary;
