within PlanarMechanics.Transformations;
function resolve1in2 "Transform vector from frame 1 to frame 2"
  extends Modelica.Icons.Function;
  input SI.Angle angle "Orientation angle to rotate frame 1 into frame 2";
  input Real v1[2] "Vector in frame 1";
  output Real v2[2] "Vector in frame 2";
protected
  Internal.TransformationMatrix R;
algorithm
  R := PlanarMechanics.Transformations.RbyAngle(angle);
  v2 := transpose(R)*v2;

  annotation (
    Inline=true,
    Documentation(
      info="<html>
<h4>Syntax</h4>
<blockquote><pre>
v2 = TransformationMatrices.<strong>resolve1in2</strong>(angle, v1);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns vector&nbsp;<var>v</var> resolved in frame&nbsp;2
(=&nbsp;<code>v2</code>) from vector&nbsp;<var>v</var> resolved in
frame&nbsp;1 (=&nbsp;<code>v1</code>) using <em>inverse</em> of the planar
transformation matrix&nbsp;R<sub>12</sub>. The matrix&nbsp;R<sub>12</sub>
describes the orientation to rotate frame&nbsp;1 into frame&nbsp;2 and is
given by rotation <code>angle</code>.
</p>
<p>
This function returns inverse operation to 
<a href=\"modelica://PlanarMechanics.TransformationMatrices.resolve2in1\">resolve2in1</a>,
i.e. when
</p>
<blockquote><pre>
v1 = R12(angle) * v2 = resolve2in1(angle, v2),
</pre></blockquote>
<p>
then
</p>
<blockquote><pre>
                          -1                 T 
v2 = R21(angle) * v1 = R12 (angle) * v1 = R12 (angle) * v1 = resolve1in2(angle, v1).
</pre></blockquote>

<p>
Especially for <em>planar rotation</em> it also applies
</p>
<blockquote><pre>
v2 = R21(angle) * v1 = R12(-angle) * v1
</pre></blockquote>
<p>
and hence
</p>
<blockquote><pre>
v2 = resolve1in2(angle, v1) = resolve2in1(-angle, v1).
</pre></blockquote>
</html>"));
end resolve1in2;
