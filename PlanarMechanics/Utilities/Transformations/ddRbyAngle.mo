within PlanarMechanics.Utilities.Transformations;
function ddRbyAngle "Return transformation matrix to rotate around an angle along one frame axis"
  extends Modelica.Icons.Function;
  import Modelica.Math.sin;
  import Modelica.Math.cos;

  input SI.Angle angle "Rotation angle to rotate frame 1 into frame 2";
  input SI.AngularVelocity w "Rotational velocity of frame 2 to frame 1";
  input SI.AngularAcceleration a "Rotational acceleration of frame 2 to frame 1";
  output Types.TransformationMatrix ddR "Second derivative of transformation matrix to rotate frame 1 into frame 2";

algorithm
  ddR :=[-cos(angle),sin(angle); -sin(angle),-cos(angle)]*w*w +
        [-sin(angle),-cos(angle); cos(angle),-sin(angle)]*a;

  annotation (
    smoothOrder=1000,
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
end ddRbyAngle;
