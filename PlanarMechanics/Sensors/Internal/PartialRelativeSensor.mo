within PlanarMechanics.Sensors.Internal;
partial model PartialRelativeSensor
  "Partial relative sensor model for sensors defined by components"
  extends Modelica.Icons.RoundSensor;

  Interfaces.Frame_a frame_a "Coordinate system a" annotation (Placement(
        transformation(extent={{-116,-16},{-84,16}})),
      mustBeConnected="Connector frame_a should be connected");
  Interfaces.Frame_b frame_b "Coordinate system b" annotation (Placement(
        transformation(extent={{84,-16},{116,16}})),
      mustBeConnected="Connector frame_b should be connected");

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
          points={{60,36},{60,36},{60,80},{95,80}},
          pattern=LinePattern.Dot)}));
end PartialRelativeSensor;
