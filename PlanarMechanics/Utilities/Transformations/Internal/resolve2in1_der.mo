within PlanarMechanics.Utilities.Transformations.Internal;
function resolve2in1_der "Derivative of function resolve2in1(..)"
  extends Modelica.Icons.Function;

  input SI.Angle angle "Orientation angle to rotate frame 1 into frame 2";
  input Real v2[2] "Vector resolved in frame 2";
  input SI.AngularVelocity w "Angular velocity to rotate frame 1 into frame 2";
  input Real v2_der[2] "= der(v2)";
  output Real v1_der[2] "Derivative of vector v resolved in frame 1";

algorithm
  v1_der := Transformations.resolve2in1(angle, v2_der + w*v2);

  annotation(Inline=true, Documentation(info="<html>
<p>
This is a&nbsp;derivative of function
<a href=\"modelica://PlanarMechanics.Transformations.resolve2in1\">resolve2in1</a>.
</p>
</html>"));
end resolve2in1_der;
