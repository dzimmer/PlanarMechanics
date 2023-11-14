within PlanarMechanics.Utilities.Transformations;
function dRbyAngle "Return transformation matrix to rotate around an angle along one frame axis"
  extends Modelica.Icons.Function;
  import Modelica.Math.sin;
  import Modelica.Math.cos;

  input SI.Angle angle "Rotation angle to rotate frame 1 into frame 2";
  input SI.AngularVelocity w "Rotation angle to rotate frame 1 into frame 2";
  output Types.TransformationMatrix dR "First derivative of transformation matrix to rotate frame 1 into frame 2";

algorithm
  dR :=[-sin(angle),-cos(angle); cos(angle),-sin(angle)]*w;

//    smoothOrder=1000,
  annotation (
    derivative(order=2)=ddRbyAngle,
    Inline=true,
    Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
R = Transformations.<strong>RbyAngle</strong>(angle);
</pre></blockquote>

<h4>Description</h4>
<p>
The function call returns
<a href=\"modelica://PlanarMechanics.Types.TransformationMatrix\">transformation matrix</a>&nbsp;R
that describes the rotation from frame&nbsp;1 into frame&nbsp;2
by rotation <code>angle</code>.
</p>
</html>"));
end dRbyAngle;
