within PlanarMechanics.Transformations;
function RbyAngle "Return transformation matrix to rotate around an angle along one frame axis"
  extends Modelica.Icons.Function;
  import Modelica.Math.sin;
  import Modelica.Math.cos;

  input SI.Angle angle "Rotation angle to rotate frame 1 into frame 2";
  output Internal.TransformationMatrix R "Transformation matrix to rotate frame 1 into frame 2";
algorithm
  R :=[cos(angle),-sin(angle); sin(angle),cos(angle)];

  annotation (
    Inline=true,
    Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
R = TransformationMatrices.<strong>RbyAngle</strong>(angle);
</pre></blockquote>

<h4>Description</h4>
<p>
The function call returns
<a href=\"modelica://PlanarMechanics.TransformationMatrices.Internal.TransformationMatrix\">transformation matrix</a>&nbsp;R
that describes the rotation from frame&nbsp;1 into frame&nbsp;2
by rotation <code>angle</code>.
</p>
</html>"));
end RbyAngle;