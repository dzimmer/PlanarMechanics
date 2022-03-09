within PlanarMechanics.VehicleComponents.Wheels.BaseClasses;
partial model WheelBase
  "Enhanced partial base class containing wheel interfaces and icon"
  extends WheelInterfaces;

  parameter SI.Length radius "Wheel radius";

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false),
      graphics={
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
        Line(
          visible=useHeatPort,
          points={{-100,-100},{-30,-100}},
          color={191,0,0},
          smooth=Smooth.None),
        Text(
          extent={{-150,-58},{150,-88}},
          textColor={0,0,0},
          textString="radius=%radius"),
        Text(
          extent={{-150,140},{150,100}},
          textString="%name",
          textColor={0,0,255})}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
This partial class contains common connectors needed for wheel models,
a&nbsp;simple icon and some parameters. This class should be extended to create
a&nbsp;proper model, see e.g.
<a href=\"modelica://PlanarMechanics.VehicleComponents.Wheels.IdealWheelJoint\">IdealWheelJoint</a> model.
</p>
<p>
Note: If this model is used, the loss power has to be provided by an equation
in the model which inherits from the
</p>
<blockquote><pre>
WheelInterfaces model(<strong>lossPower = ...</strong>).
</pre></blockquote>
</html>"));
end WheelBase;
