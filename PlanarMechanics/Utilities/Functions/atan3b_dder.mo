within PlanarMechanics.Utilities.Functions;
function atan3b_dder "Second deviation of atan3"
  extends Modelica.Icons.Function;

  import Modelica.Math;
  input Real u1;
  input Real u2;
  input Modelica.SIunits.Angle y_d=0 "y shall be in the range: -pi < y-y0 < pi";
  input Real u1_der;
  input Real u2_der;
  input Real u1_dder;
  input Real u2_dder;
  output Modelica.SIunits.AngularAcceleration y_dder;
algorithm
  y_dder := (2*u1*u2/((u1*u1+u2*u2)*(u1*u1+u2*u2)))*u2_der - (2*u1*u2/((u1*u1+u2*u2)*(u1*u1+u2*u2)))*u1_der;

  annotation (
    Documentation(
      info="<html>
<p>
The first derivative of function
<a href=\"modelica://PlanarMechanics.Utilities.Functions.atan3b_der\">atan3b_der</a>,
i.e. the second derivative of the function
<a href=\"modelica://PlanarMechanics.Utilities.Functions.atan3b\">atan3b</a>.
</p>
</html>",
      revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<b>Developed 2010-2019 at the DLR Institute of System Dynamics and Control</b>
</p>
</html>"));
end atan3b_dder;
