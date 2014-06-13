within PlanarMechanics.Utilities.AtanLib;
function atan3b
  "Four quadrant inverse tangent (select solution that is closest to given angle y0)"
  import Modelica.Math;
  extends Modelica.Math.baseIcon2;
  input Real u1;
  input Real u2;
  input Modelica.SIunits.Angle y0=0 "y shall be in the range: -pi < y-y0 < pi";
  output Modelica.SIunits.Angle y;
protected
  Real pi = Modelica.Constants.pi;
  Real w;
algorithm
  w :=Math.atan2(u1, u2);
  y := w + 2*pi*div(abs(w-y0)+pi,2*pi)*(if y0 > w then +1 else -1);
  annotation (derivative(noDerivative=y0) = atan3b_der,
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{0,-80},{8.93,-67.2},{17.1,-59.3},{27.3,-53.6},{42.1,-49.4},
              {69.9,-45.8},{80,-45.1}}),
        Line(points={{-80,-34.9},{-46.1,-31.4},{-29.4,-27.1},{-18.3,-21.5},{-10.3,
              -14.5},{-2.03,-3.17},{7.97,11.6},{15.5,19.4},{24.3,25},{39,30},{
              62.1,33.5},{80,34.9}}),
        Line(points={{-80,45.1},{-45.9,48.7},{-29.1,52.9},{-18.1,58.6},{-10.2,
              65.8},{-1.82,77.2},{0,80}}),
        Text(
          extent={{-90,-46},{-18,-94}},
          lineColor={192,192,192},
          textString="atan3")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-100,-86},{84,-86}}, color={95,95,95}),
        Polygon(
          points={{98,-86},{82,-80},{82,-92},{98,-86}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,-80},{8.93,-67.2},{17.1,-59.3},{27.3,-53.6},{42.1,-49.4},{
              69.9,-45.8},{80,-45.1}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{-80,-34.9},{-46.1,-31.4},{-29.4,-27.1},{-18.3,-21.5},{-10.3,
              -14.5},{-2.03,-3.17},{7.97,11.6},{15.5,19.4},{24.3,25},{39,30},{
              62.1,33.5},{80,34.9}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{-80,45.1},{-45.9,48.7},{-29.1,52.9},{-18.1,58.6},{-10.2,65.8},
              {-1.82,77.2},{0,80}},
          color={0,0,255},
          thickness=0.5),
        Text(
          extent={{-56,82},{-12,72}},
          textString="(2*N-1)*pi",
          lineColor={0,0,255}),
        Text(
          extent={{-52,-72},{-10,-88}},
          textString="(2*N-3)*pi",
          lineColor={0,0,255}),
        Line(points={{0,40},{-8,40}}, color={192,192,192}),
        Line(points={{0,-40},{-8,-40}}, color={192,192,192}),
        Text(
          extent={{38,-68},{78,-84}},
          lineColor={95,95,95},
          textString="u1, u2, y0"),
        Line(
          points={{-84,40},{88,40}},
          color={175,175,175}),
        Line(
          points={{-84,-40},{88,-40}},
          color={175,175,175})}),
    Documentation(revisions="<html>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/><b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p>
</html>",                                                                                                  info="<HTML>
<p>
This function returns y = <b>atan3</b>(u1,u2,y0) such that
<b>tan</b>(y) = u1/u2 and
y is in the range: -pi &lt; y-y0 &lt; pi.<br>
u2 may be zero, provided u1 is not zero. The difference to
Modelica.Math.atan2(..) is the optional third argument y0 that
allows to specify which of the infinite many solutions
shall be returned:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/atan3.png\">
</p>

</html>"));
end atan3b;
