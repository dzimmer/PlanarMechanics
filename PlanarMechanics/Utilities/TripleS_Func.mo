within PlanarMechanics.Utilities;
function TripleS_Func "Models a point-symmetric Triple S-Function"
  input Real x_max;
  input Real x_sat;
  input Real y_max;
  input Real y_sat;
  input Real x;
  output Real y;
algorithm
  if x > x_max then
    y := S_Func(x_max,x_sat,y_max,y_sat,x);
  elseif x < -x_max then
    y := S_Func(-x_max,-x_sat,-y_max,-y_sat,x);
  else
    y := S_Func(-x_max,x_max,-y_max,y_max,x);
  end if;
  annotation(smoothOrder=1, Documentation(revisions="<html>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p>
</html>"));
end TripleS_Func;
