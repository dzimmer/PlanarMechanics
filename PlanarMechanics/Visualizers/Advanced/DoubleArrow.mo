within PlanarMechanics.Visualizers.Advanced;
model DoubleArrow
  "Visualizing a double arrow with variable size; all data have to be set as modifiers (see info layer)"

  import Modelica.Mechanics.MultiBody.Types;
  import Modelica.Mechanics.MultiBody.Frames;
  import T = Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
  import Modelica.Units.Conversions.to_unit1;

  input Frames.Orientation R=Frames.nullRotation()
    "Orientation object to rotate the planarWorld frame into the arrow frame" annotation(Dialog);
  input SI.Position r[3]={0,0,0}
    "Position vector from origin of planarWorld frame to origin of arrow frame, resolved in planarWorld frame"
    annotation(Dialog);
  input SI.Position r_tail[3]={0,0,0}
    "Position vector from origin of arrow frame to double arrow tail, resolved in arrow frame"
    annotation(Dialog);
  input SI.Position r_head[3]={0,0,0}
    "Position vector from double arrow tail to the head of the double arrow, resolved in arrow frame"
    annotation(Dialog);
  input SI.Diameter diameter=planarWorld.defaultArrowDiameter
    "Diameter of arrow line" annotation(Dialog);
  input PlanarMechanics.Types.Color color=PlanarMechanics.Types.Defaults.ArrowColor
    "Color of double arrow" annotation(HideResult=true, Dialog(colorSelector=true));
  input PlanarMechanics.Types.SpecularCoefficient specularCoefficient = planarWorld.defaultSpecularCoefficient
    "Material property describing the reflecting of ambient light (= 0 means, that light is completely absorbed)"
    annotation(HideResult=true, Dialog);

protected
  outer PlanarWorld planarWorld;
  SI.Length length=Modelica.Math.Vectors.length(r_head) "Length of arrow";
  Real e_x[3](each final unit="1", start={1,0,0}) = noEvent(if length < 1.e-10 then {1,0,0} else r_head/length);
  Real rxvisobj[3](each final unit="1") = transpose(R.T)*e_x
    "X-axis unit vector of shape, resolved in planarWorld frame"
      annotation (HideResult=true);
  SI.Position rvisobj[3] = r + T.resolve1(R.T, r_tail)
    "Position vector from planarWorld frame to shape frame, resolved in planarWorld frame"
      annotation (HideResult=true);

  SI.Length headLength=noEvent(max(0, length - arrowLength))
    annotation(HideResult=true);
  SI.Length headWidth=noEvent(max(0, diameter*Types.Defaults.ArrowHeadWidthFraction))
    annotation(HideResult=true);
  SI.Length arrowLength = noEvent(max(0, length - 1.5*diameter*Types.Defaults.ArrowHeadLengthFraction))
    annotation(HideResult=true);

  MB.Visualizers.Advanced.Shape arrowLine(
    length=arrowLength,
    width=diameter,
    height=diameter,
    lengthDirection=to_unit1(r_head),
    widthDirection={0,1,0},
    shapeType="cylinder",
    color=color,
    specularCoefficient=specularCoefficient,
    r_shape=r_tail,
    r=r,
    R=R) if planarWorld.enableAnimation;
  MB.Visualizers.Advanced.Shape arrowHead1(
    length=2/3*headLength,
    width=headWidth,
    height=headWidth,
    lengthDirection=to_unit1(r_head),
    widthDirection={0,1,0},
    shapeType="cone",
    color=color,
    specularCoefficient=specularCoefficient,
    r=rvisobj + rxvisobj*arrowLength,
    R=R) if planarWorld.enableAnimation;
  MB.Visualizers.Advanced.Shape arrowHead2(
    length=2/3*headLength,
    width=headWidth,
    height=headWidth,
    lengthDirection=to_unit1(r_head),
    widthDirection={0,1,0},
    shapeType="cone",
    color=color,
    specularCoefficient=specularCoefficient,
    r=rvisobj + rxvisobj*(arrowLength + headLength/3),
    R=R) if planarWorld.enableAnimation;

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{-100,30},{0,-30}},
          lineColor={128,128,128},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{40,60},{100,0},{40,-60},{40,60}},
          lineColor={128,128,128},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,60},{60,0},{0,-60},{0,60}},
          lineColor={128,128,128},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,100},{150,60}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(info="<html>
<p>
Model <strong>DoubleArrow</strong> defines a&nbsp;double arrow that is dynamically
visualized at the defined location (see variables below).
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Advanced/DoubleArrow.png\" alt=\"model Visualizers.Advanced.DoubleArrow\">
</div>

<p>
The variables under heading <strong>Parameters</strong> below
are declared as (time varying) <strong>input</strong> variables.
If the default equation is not appropriate, a&nbsp;corresponding
modifier equation has to be provided in the
model where an <strong>Arrow</strong> instance is used, e.g., in the form
</p>

<blockquote><pre>
Visualizers.Advanced.DoubleArrow doubleArrow(diameter = sin(time));
</pre></blockquote>

<p>
Variable <strong>color</strong> is a&nbsp;RGB color space given in the range
0&nbsp;..&nbsp;255.
The predefined type <a href=\"modelica://PlanarMechanics.Types.Color\">Types.Color</a>
contains a&nbsp;menu definition of the colors used in the library together with
a&nbsp;color editor.
</p>
</html>"));
end DoubleArrow;
