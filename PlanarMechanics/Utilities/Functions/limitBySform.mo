within PlanarMechanics.Utilities.Functions;
function limitBySform "Returns a S-shaped transition"
  extends Modelica.Icons.Function;

  input Real x_min;
  input Real x_max;
  input Real y_min;
  input Real y_max;
  input Real x;
  output Real y;
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
  annotation(smoothOrder=1, Documentation(revisions="<html>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2018 at the DLR Institute of System Dynamics and Control</b></p>
</html>"));
end limitBySform;
