within PlanarMechanics.Utilities.Functions;
function limitBySform "Returns a S-shaped transition"
  extends Modelica.Icons.Function;

  input Real x_min "Abscissa for y_min";
  input Real x_max "Abscissa for y_max";
  input Real y_min "First value of y";
  input Real y_max "Second value of y";
  input Real x "Current abscissa value";
  output Real y "Current ordinate";
protected
  Real x2;
algorithm
  x2 := x - x_max/2 - x_min/2;
  x2 := x2*2/(x_max-x_min);
  if x2 > 1 then
    y := 1;
  elseif x2 < -1 then
    y := -1;
  else
    y := -0.5*x2^3 + 1.5*x2;
  end if;
  y := y*(y_max-y_min)/2;
  y := y + y_max/2 + y_min/2;

  annotation (
    smoothOrder=1,
    Documentation(
      info="<html>
<h4>Syntax</h4>
<blockquote><pre>
y = Functions.<strong>limitBySform</strong>(x_min, x_max, y_min, y_max, x);
</pre></blockquote>

<h4>Description</h4>
<p>
A smooth transition between points (x_min,&nbsp;y_min) and (x_max,&nbsp;y_max).
The transition is done in such a way that the 1st function&#039;s derivative
is continuous for all&nbsp;<em>x</em>.
The higher derivatives are, in contrast, discontinuous at input points.
</p>

<p>
The figure below shows the function&nbsp;<em>y</em> and its 1st derivative&nbsp;<em>dy/dx</em>
for the following input:
x_max&nbsp;=&nbsp;-0.4,
x_sat&nbsp;=&nbsp;0.6,
y_max&nbsp;=&nbsp;1.4,
y_sat&nbsp;=&nbsp;1.2.
</p>

<div>
<img src=\"modelica://PlanarMechanics/Resources/Images/Utilities/Functions/limitBySform.png\">
</div>
</html>",
      revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010-2020 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>"));
end limitBySform;
