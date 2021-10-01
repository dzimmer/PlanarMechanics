within PlanarMechanics.Utilities.Blocks;
block SquaretimesSign
  "Output the squared input and retain the same sign of it"
  parameter Integer blockSize;
  extends Modelica.Blocks.Interfaces.MIMO(final nin=blockSize, final nout=blockSize);
equation
  for i in 1:size(u,1) loop
    y[i] = smooth(1,u[i]^2*sign(u[i]));
  end for;
  annotation (
    Documentation(info="<html>
<p>
This block outputs squared input real signal whereby the sign
of the output is the same as input.
The size of input&nbsp;u and output&nbsp;y are defined by
a parameter blockSize, thus
</p>

<blockquote><pre>
<strong>for</strong> i <strong>in</strong> 1:blockSize <strong>loop</strong>
  y[i] = sign(u[i]) * u[i]^2;
<strong>end for</strong>;
</pre></blockquote>
</html>"), Icon(coordinateSystem(
    preserveAspectRatio=true,
    extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-100,-98},{100,-68}},
          textColor={160,160,164},
          textString="sign(u) * u^2"),
        Polygon(
          points={{0,90},{-8,68},{8,68},{0,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{0,68},{0,-80}}, color={192,192,192}),
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-50},{80,50}}, color={95,95,95}),
        Line(
          points={{0,0},{-2,0},{-16,-2},{-34,-14},{-54,-42},{-64,-72}},
          color={0,0,127},
          smooth=Smooth.Bezier),
        Line(
          points={{0,0},{2,0},{16,2},{34,14},{56,46},{70,90}},
          color={0,0,127},
          smooth=Smooth.Bezier)}),
    Diagram(coordinateSystem(
    preserveAspectRatio=true,
    extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-90,-60},{90,60}},
          textColor={160,160,164},
          textString="sign(u) * u^2")}));
end SquaretimesSign;
