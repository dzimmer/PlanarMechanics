within PlanarMechanics.Utilities.AtanLib;
function atan3b_dder "second deviation of atan3"
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
  annotation (Documentation(revisions="<html>
<p><img src=\"modelica://PlanarMechanicmodelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/><b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p>
</html>"));
end atan3b_dder;
