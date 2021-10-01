within PlanarMechanics.Sensors.Internal;
model PartialRelativeBaseSensor
  "Partial relative sensor models for sensors defined by equations (frame_resolve must be connected exactly once)"
  extends Modelica.Icons.RoundSensor;

  Interfaces.Frame_a frame_a
    "Coordinate system a (measurement is between frame_a and frame_b)" annotation (Placement(
        transformation(extent={{-116,-16},{-84,16}})));
  Interfaces.Frame_b frame_b
    "Coordinate system b (measurement is between frame_a and frame_b)" annotation (Placement(
        transformation(extent={{84,-16},{116,16}})));

  Interfaces.Frame_resolve frame_resolve
    "Coordinate system in which vector is optionally resolved"
    annotation (Placement(transformation(extent={{84,64},{116,96}}),
        iconTransformation(extent={{84,65},{116,97}})));

equation
   assert(cardinality(frame_a) > 0, "Connector frame_a must be connected at least once");
   assert(cardinality(frame_b) > 0, "Connector frame_b must be connected at least once");
   assert(cardinality(frame_resolve) == 1, "Connector frame_resolve must be connected exactly once");
   frame_a.fx = 0;
   frame_a.fy = 0;
   frame_a.t = 0;
   frame_b.fx = 0;
   frame_b.fy = 0;
   frame_b.t = 0;
   frame_resolve.fx = 0;
   frame_resolve.fy = 0;
   frame_resolve.t = 0;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-108,43},{-72,18}},
          textColor={128,128,128},
          textString="a"),
        Text(
          extent={{72,41},{108,16}},
          textColor={128,128,128},
          textString="b"),
        Line(
          points={{-70,0},{-96,0},{-96,0}}),
        Line(
          points={{96,0},{70,0},{70,0}}),
        Line(
          points={{0,-70},{0,-100}},
          color={0,0,127}),
        Line(
          points={{60,36},{60,36},{60,80},{95,80}},
          pattern=LinePattern.Dot)}));
end PartialRelativeBaseSensor;
