within PlanarMechanics.Utilities.Transformations;
function resolve2in1 "Transform vector from frame 2 to frame 1"
  extends Modelica.Icons.Function;
  input SI.Angle angle "Orientation angle to rotate frame 1 into frame 2";
  input Real v2[2] "Vector resolved in frame 2";
  output Real v1[2] "Vector resolved in frame 1";
protected
  Types.TransformationMatrix R;

algorithm
  R := PlanarMechanics.Utilities.Transformations.RbyAngle(angle);
  v1 := R*v2;

  annotation (
    derivative = Internal.resolve2in1_der,
    Inline=true,
    Documentation(
      info="<html>
<h4>Syntax</h4>
<blockquote><pre>
v1 = TransformationMatrices.<strong>resolve2in1</strong>(angle, v2);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns vector&nbsp;<var>v</var> resolved in frame&nbsp;1
(=&nbsp;<code>v1</code>) from vector&nbsp;<var>v</var> resolved in
frame&nbsp;2 (=&nbsp;<code>v2</code>) using the planar transformation
matrix&nbsp;R<sub>12</sub>. This matrix describes the orientation to rotate
frame&nbsp;1 into frame&nbsp;2 by rotation <code>angle</code>, i.e
</p>

<blockquote><pre>
             | cos(angle)  -sin(angle) |
R12(angle) = |                         | ,
             | sin(angle)   cos(angle) |
</pre></blockquote>

<p>
and thus
</p>

<blockquote><pre>
v1 = R12 * v2 = resolve2in1(angle, v2).
</pre></blockquote>

<h4>See also</h4>
<p>
Inverse transformation:
<a href=\"modelica://PlanarMechanics.TransformationMatrices.resolve1in2\">resolve1in2</a>.
</p>
</html>"));
end resolve2in1;
