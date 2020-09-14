within PlanarMechanics.Sensors.Internal;
model PartialAbsoluteBaseSensor
  "Partial absolute sensor models for sensors defined by equations (frame_resolve must be connected exactly once)"
  extends Modelica.Icons.RoundSensor;

  Interfaces.Frame_a frame_a
    "Coordinate system from which kinematic quantities are measured" annotation (Placement(
        transformation(extent={{-116,-16},{-84,16}})));

  Interfaces.Frame_resolve frame_resolve
    "Coordinate system in which vector is optionally resolved"
    annotation (Placement(transformation(extent={{-16,-16},{16,16}},
        rotation=-90,
        origin={0,-100}),
        iconTransformation(extent={{-16,-16},{16,16}},
        rotation=-90,
        origin={0,-100})));

equation
  assert(cardinality(frame_a) > 0, "Connector frame_a must be connected at least once");
  assert(cardinality(frame_resolve) == 1, "Connector frame_resolve must be connected exactly once");
  frame_a.fx = 0;
  frame_a.fy = 0;
  frame_a.t = 0;
  frame_resolve.fx = 0;
  frame_resolve.fy = 0;
  frame_resolve.t = 0;

  annotation (Icon(coordinateSystem(preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Text(
          extent={{-108,43},{-72,18}},
          lineColor={95,95,95},
          textString="a"),
        Line(
          points={{-70,0},{-96,0},{-96,0}}),
        Line(
          points={{0,15},{0,-15}},
          color={0,0,127},
          origin={85,0},
          rotation=90),
        Line(
          points={{0,-95},{0,-95},{0,-70},{0,-70}},
          pattern=LinePattern.Dot),
        Text(
          extent={{0,-75},{131,-100}},
          lineColor={95,95,95},
          textString="resolve")}));
end PartialAbsoluteBaseSensor;
