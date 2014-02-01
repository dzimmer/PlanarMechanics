within PlanarMechanics.Utilities.AtanLib;
function atan3b_der "First deviation of atan3"
  import Modelica.Math;
  input Real u1;
  input Real u2;
  input Modelica.SIunits.Angle y=0 "y shall be in the range: -pi < y-y0 < pi";
  input Real u1_der;
  input Real u2_der;
  output Modelica.SIunits.AngularVelocity y_der;
algorithm
  y_der := u2/(u1*u1+u2*u2)*u1_der - u1/(u1*u1+u2*u2)*u2_der;
  annotation (derivative = atan3b_dder, Documentation(revisions="<html>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/><b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p>
</html>"));
end atan3b_der;
