within PlanarMechanics.Utilities;
block S_FuncBlock
  extends Modelica.Blocks.Interfaces.SISO;
  parameter Real x_min = 0;
  parameter Real x_max = 1;
  parameter Real y_min = 0;
  parameter Real y_max = 1;
equation
  y = S_Func(x_min,x_max,y_min,y_max,u);
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
      lineColor={192,192,192},
          textString="S"),
    Line(points={{-70,-70},{-62,-70},{-50,-66},{-40,-58},{-30,-40},{-18,-12},
              {-2,22},{10,40},{22,52},{32,60},{42,64},{56,68},{70,68}},
                                                      color={0,0,0})}),
      Documentation(revisions="<html>
<p><img src=\"./Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p>
</html>"));
end S_FuncBlock;
