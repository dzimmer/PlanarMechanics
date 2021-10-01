within PlanarMechanics.Utilities.Blocks;
block LimiterS "Limit the range of output y using S-form transition"
  extends Modelica.Blocks.Interfaces.SISO;
  parameter Real x_min = 0;
  parameter Real x_max = 1;
  parameter Real y_min = 0;
  parameter Real y_max = 1;
equation
  y =Functions.limitBySform(
    x_min,
    x_max,
    y_min,
    y_max,
    u);
  annotation (Icon(graphics={
    Line(points={{-70,-78},{-70,78}}, color={192,192,192}),
    Polygon(
      points={{-70,100},{-78,78},{-62,78},{-70,100}},
      lineColor={192,192,192},
      fillColor={192,192,192},
      fillPattern=FillPattern.Solid),
    Polygon(
      points={{100,-70},{78,-62},{78,-78},{100,-70}},
      lineColor={192,192,192},
      fillColor={192,192,192},
      fillPattern=FillPattern.Solid),
    Line(points={{-80,-70},{78,-70}}, color={192,192,192}),
    Text(
      extent={{2,6},{74,-42}},
      textColor={192,192,192},
      textString="S"),
    Line(points={{-70,-70},{-62,-70},{-50,-66},{-40,-58},{-30,-40},{-18,-12},
              {-2,22},{10,40},{22,52},{32,60},{42,64},{56,68},{70,68}})}),
    Documentation(
      revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010-2020 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>"));
end LimiterS;
