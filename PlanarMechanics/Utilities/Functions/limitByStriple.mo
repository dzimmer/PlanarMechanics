within PlanarMechanics.Utilities.Functions;
function limitByStriple "Returns a point-symmetric Triple S-Function"
  extends Modelica.Icons.Function;

  input Real x_max "Abscissa for y_max";
  input Real x_sat "Abscissa for y_sat";
  input Real y_max "Peak ordinate";
  input Real y_sat "Saturated ordinate";
  input Real x "Current abscissa value";
  output Real y "Current ordinate";
algorithm
  if x > x_max then
    y :=Functions.limitBySform(
      x_max,
      x_sat,
      y_max,
      y_sat,
      x);
  elseif x < -x_max then
    y :=Functions.limitBySform(
      -x_max,
      -x_sat,
      -y_max,
      -y_sat,
      x);
  else
    y :=Functions.limitBySform(
      -x_max,
      x_max,
      -y_max,
      y_max,
      x);
  end if;

  annotation (
    smoothOrder=1,
    Documentation(
      info="<html>
<h4>Syntax</h4>
<blockquote><pre>
y = Functions.<strong>limitByStriple</strong>(x_max, x_sat, y_max, y_sat, x);
</pre></blockquote>

<h4>Description</h4>
<p>
A point symmetric interpolation between points (0,&nbsp;0), (x_max,&nbsp;y_max)
and (x_sat,&nbsp;y_sat), provided x_max&nbsp;&lt;&nbsp;x_sat. The approximation
is done in such a way that the 1st function&#039;s derivative is zero at points
points (x_max,&nbsp;y_max) and (x_sat,&nbsp;y_sat).
Thus, the 1st function&#039;s derivative is continuous for all&nbsp;<em>x</em>.
The higher derivatives are, in contrast, discontinuous at these points.
</p>

<p>
The figure below shows the function&nbsp;<em>y</em> and its 1st derivative&nbsp;<em>dy/dx</em>
for the following input:
x_max&nbsp;=&nbsp;0.2,
x_sat&nbsp;=&nbsp;0.5,
y_max&nbsp;=&nbsp;1.4,
y_sat&nbsp;=&nbsp;1.2.
</p>

<blockquote>
<img src=\"modelica://PlanarMechanics/Resources/Images/Utilities/Functions/limitByStriple.png\">
</blockquote>
</html>",
      revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<b>Developed 2010-2019 at the DLR Institute of System Dynamics and Control</b>
</p>
</html>"));
end limitByStriple;
