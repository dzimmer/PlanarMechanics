within PlanarMechanics.GearComponents.Examples.Utilities;
model RigidNoLossPlanetary "Planetary gearbox"
  extends
    PlanarMechanics.GearComponents.Examples.Utilities.Interfaces.PlanetaryGearInterface;

  parameter SI.Distance r_s(start=1) "Radius of sun gear";
  parameter SI.Distance r_p(start=1) "Radius of planet gear";
  parameter SI.Distance r_r(start=3) "Radius of ring gear";

  parameter SI.Inertia J_s(start=1e-3) "Inertia of the sun gear";
  parameter SI.Inertia J_p(start=1e-3) "Inertia of the planet gear";
  parameter SI.Inertia J_c(start=1e-3) "Inertia of the carrier";
  parameter SI.Inertia J_r(start=1e-3) "Inertia of the ring gear";

  parameter Boolean animate = true "= true, if animation shall be enabled" annotation(Evaluate=true, HideResult=true, choices(checkBox=true));

  parameter Integer Tooth_a(min=1) = 20 "Number of teeth" annotation (Dialog(
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
  parameter SI.Distance z_offset=0 "Offset of z-distance for simulation" annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animate));

  parameter Boolean connectToMultiBody = false annotation (
    Evaluate=true,
    HideResult=true,
    choices(checkBox=true));

  PlanarMechanics.Parts.Body planet(
    m=1,
    I=1e-3,
    phi(fixed=false))            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
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
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
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
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={10,40})));
  PlanarMechanics.Joints.Revolute bearing_Sun(useFlange=true)
    annotation (Placement(transformation(extent={{-70,0},{-50,20}})));
  PlanarMechanics.Joints.Revolute bearing_Carrier(useFlange=true)
    annotation (Placement(transformation(extent={{-70,-30},{-50,-50}})));
  PlanarMechanics.Joints.Revolute bearing_Ring(useFlange=true)
    annotation (Placement(transformation(extent={{-70,50},{-50,30}})));
  Modelica.Mechanics.Rotational.Components.Inertia sun(J=J_s)
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  Modelica.Mechanics.Rotational.Components.Inertia carrier(J=J_c, phi(
        start=0))
    annotation (Placement(transformation(extent={{70,-36},{90,-16}})));
  Modelica.Mechanics.Rotational.Components.Inertia ring(J=J_r)
    annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
public
  inner PlanarWorldIn3D planarWorld(
    connectToMultiBody=true,
    nominalLength=0.1,
    animateGravity=false)
    annotation (Placement(transformation(extent={{40,-78},{60,-58}})));
  MB.Parts.Body body3D(r_CM=zeros(3),
    m=1e-5,
    animation=false)                       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-48})));
  MB.Interfaces.Frame_a                           VisualisationFrame if connectToMultiBody
    annotation (Placement(transformation(extent={{-16,-16},{16,16}},
        rotation=90,
        origin={0,-98})));
equation
  connect(carrierAngle.frame_b, carrierPart.frame_a)   annotation (Line(
      points={{-20,-40},{-8,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(bearing_Planet.frame_a, carrierPart.frame_b)  annotation (Line(
      points={{20,-40},{12,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(planetRing.frame_a, bearing_Planet.frame_b) annotation (Line(
      points={{20,40},{48,40},{48,-40},{40,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(sunPlanet.frame_b, planetRing.frame_a) annotation (Line(
      points={{20,10},{48,10},{48,40},{20,40}},
      color={95,95,95},
      thickness=0.5));
  connect(Fixed.frame, bearing_Sun.frame_a) annotation (Line(
      points={{-80,30},{-80,10},{-70,10}},
      color={95,95,95},
      thickness=0.5));
  connect(bearing_Sun.flange_a, flange_Sun) annotation (Line(
      points={{-60,0},{-60,0},{-60,-10},{-100,-10},{-100,0}}));
  connect(bearing_Carrier.frame_b, carrierAngle.frame_a) annotation (Line(
      points={{-50,-40},{-40,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(bearing_Carrier.frame_a, Fixed.frame) annotation (Line(
      points={{-70,-40},{-80,-40},{-80,30}},
      color={95,95,95},
      thickness=0.5));
  connect(bearing_Ring.frame_a, Fixed.frame) annotation (Line(
      points={{-70,40},{-80,40},{-80,30}},
      color={95,95,95},
      thickness=0.5));
  connect(bearing_Ring.flange_a, flange_Ring) annotation (Line(
      points={{-60,50},{-60,60},{-100,60}}));
  connect(planet.frame_a, bearing_Planet.frame_b) annotation (Line(
      points={{72,40},{48,40},{48,-40},{40,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(sun.flange_a, bearing_Sun.flange_a) annotation (Line(
      points={{-40,-10},{-60,-10},{-60,0}}));
  connect(bearing_Sun.frame_b, sunPlanet.frame_a) annotation (Line(
      points={{-50,10},{0,10}},
      color={95,95,95},
      thickness=0.5));
  connect(carrier.flange_b, flange_Carrier) annotation (Line(
      points={{90,-26},{100,-26},{100,0}}));
  connect(bearing_Ring.frame_b, planetRing.frame_b) annotation (Line(
      points={{-50,40},{0,40}},
      color={95,95,95},
      thickness=0.5));
  connect(ring.flange_a, bearing_Ring.flange_a) annotation (Line(
      points={{-40,60},{-60,60},{-60,50}}));
  connect(sunPlanet.heatPort, internalHeatPort) annotation (Line(
      points={{0,0},{60,0},{60,-60},{-90,-60},{-90,-80},{-100,-80}},
      color={191,0,0}));
  connect(planetRing.heatPort, internalHeatPort) annotation (Line(
      points={{20,30},{60,30},{60,-60},{-90,-60},{-90,-80},{-100,-80}},
      color={191,0,0}));
  connect(bearing_Carrier.flange_a, carrier.flange_a) annotation (Line(
      points={{-60,-30},{-60,-26},{70,-26}}));
  connect(planarWorld.MBFrame_a, VisualisationFrame) annotation (Line(
      points={{39.8,-68},{0,-68},{0,-98}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(body3D.frame_a, planarWorld.MBFrame_a) annotation (Line(
      points={{0,-58},{0,-68},{39.8,-68}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (Documentation(info="<html>
<p>This model is a model of a standard planetary gearbox. The inertia of all gear models, as well as the mass of the planetary gear can be entered to get the behaviour of a complete planetary gear. In this example only one planet is used as the gearbox models are rigid.</p>
</html>", revisions=
          "<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p></html>"));
end RigidNoLossPlanetary;
