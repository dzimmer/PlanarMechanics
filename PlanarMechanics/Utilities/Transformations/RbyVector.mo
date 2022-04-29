within PlanarMechanics.Utilities.Transformations;
function RbyVector "Return transformation matrix given by vector"
  extends Modelica.Icons.Function;

  input Real v[2] "Vector giving rotation angle from frame 1 into frame 2";
  output Types.TransformationMatrix R "Transformation matrix to rotate frame 1 into frame 2";
protected
  Real e[2](each final unit="1") = Modelica.Math.Vectors.normalizeWithAssert(v)
    "Unit vector in direction of v";

algorithm
  R :=[e[1], -e[2]; e[2], e[1]];

  annotation (
    smoothOrder=1000,
    Inline=true,
    Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
R = Transformations.<strong>RbyVector</strong>(v);
</pre></blockquote>

<h4>Description</h4>
<p>
The function call returns
<a href=\"modelica://PlanarMechanics.Types.TransformationMatrix\">transformation matrix</a>&nbsp;R
that describes the rotation from frame&nbsp;1 into frame&nbsp;2.
The rotation is given by input vector&nbsp;<code>v</code> resolved
in frame&nbsp;1, i.e. the vector defines the <var>x</var> axis of
frame&nbsp;2 with respect to frame&nbsp;1.
</p>
</html>"));
end RbyVector;
