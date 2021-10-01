within PlanarMechanics.Sensors.Internal;
partial model PartialAbsoluteSensor
  "Partial absolute sensor model for sensors defined by components"
  extends Modelica.Icons.RoundSensor;

  Interfaces.Frame_a frame_a
    "Coordinate system at which the kinematic quantities are measured"
    annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));

equation
   assert(cardinality(frame_a) > 0, "Connector frame_a must be connected at least once");
  annotation (Icon(coordinateSystem(preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-108,43},{-72,18}},
          textColor={128,128,128},
          textString="a"),
        Line(points={{-70,0},{-96,0},{-96,0}})}));
end PartialAbsoluteSensor;
