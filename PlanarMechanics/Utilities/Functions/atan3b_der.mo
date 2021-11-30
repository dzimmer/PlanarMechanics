within PlanarMechanics.Utilities.Functions;
function atan3b_der "Obsolete function: First deviation of atan3"
  extends Modelica.Icons.Function;
  extends Modelica.Icons.ObsoleteModel;

  import Modelica.Math;
  input Real u1;
  input Real u2;
  input SI.Angle y0=0 "y shall be in the range: -pi < y-y0 < pi";
  input Real u1_der;
  input Real u2_der;
  output SI.AngularVelocity y_der;
algorithm
  y_der := u2/(u1*u1+u2*u2)*u1_der - u1/(u1*u1+u2*u2)*u2_der;
  annotation (
    obsolete = "Obsolete function",
    derivative(order=2) = atan3b_dder,
    Documentation(
      info="<html>
<p>
The first derivative of the function
<a href=\"modelica://PlanarMechanics.Utilities.Functions.atan3b\">atan3b</a>.
</p>
</html>",
      revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>"));
end atan3b_der;
