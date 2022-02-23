within PlanarMechanics.VehicleComponents.Wheels.BaseClasses;
partial model WheelBase
  Interfaces.Frame_a frame_a annotation (Placement(transformation(extent={{-54,-16},
            {-22,16}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a annotation (
      Placement(transformation(extent={{90,-10},{110,10}}),iconTransformation(
          extent={{90,-10},{110,10}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-40,100},{40,-100}},
          lineColor={95,95,95},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={231,231,231}),
        Line(
          points={{-40,30},{40,30}},
          color={95,95,95}),
        Line(
          points={{-40,-30},{40,-30}},
          color={95,95,95}),
        Line(
          points={{-40,60},{40,60}},
          color={95,95,95}),
        Line(
          points={{-40,80},{40,80}},
          color={95,95,95}),
        Line(
          points={{-40,90},{40,90}},
          color={95,95,95}),
        Line(
          points={{-40,100},{40,100}},
          color={95,95,95}),
        Line(
          points={{-40,-80},{40,-80}},
          color={95,95,95}),
        Line(
          points={{-40,-90},{40,-90}},
          color={95,95,95}),
        Line(
          points={{-40,-100},{40,-100}},
          color={95,95,95}),
        Line(
          points={{-40,-60},{40,-60}},
          color={95,95,95}),
        Rectangle(
          extent={{100,10},{40,-10}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={231,231,231}),
        Text(
          extent={{-150,-58},{150,-88}},
          lineColor={0,0,0},
          textString="radius=%radius"),
        Text(
          extent={{-150,140},{150,100}},
          textString="%name",
          lineColor={0,0,255})}), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end WheelBase;
