within PlanarMechanics.Visualizers.Internal;
model Arrow
  "Visualizing an arrow with variable size; all data have to be set as modifiers (see info layer)"

  import T = Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
  import Modelica.Units.Conversions.to_unit1;

  input MB.Frames.Orientation R=MB.Frames.nullRotation()
    "Orientation object to rotate the planarWorld frame into the arrow frame" annotation(Dialog(enable=true));
  input SI.Position r[3]={0,0,0}
    "Position vector from origin of planarWorld frame to origin of arrow frame, resolved in planarWorld frame"
    annotation(Dialog(enable=true));
  input SI.Position r_tail[3]={0,0,0}
    "Position vector from origin of arrow frame to arrow tail, resolved in arrow frame"
    annotation(Dialog(enable=true));
  input SI.Position r_head[3]={0,0,0}
    "Position vector from arrow tail to the head of the arrow, resolved in arrow frame"
    annotation(Dialog(enable=true));
  input SI.Diameter diameter=1/40 "Diameter of arrow line"
    annotation(Dialog(enable=true));
  input SI.Diameter headDiameter=3*diameter "Diameter of arrow head"
    annotation(Dialog(enable=true));
  input SI.Length headLength=5*diameter "Length of arrow head"
    annotation(Dialog(enable=true));
  input MB.Types.Color color=PlanarMechanics.Types.Defaults.ArrowColor
    "Color of arrow"
    annotation(HideResult=true, Dialog(colorSelector=true));
  input MB.Types.SpecularCoefficient specularCoefficient = 0.7
    "Material property describing the reflecting of ambient light (= 0 means, that light is completely absorbed)"
    annotation(HideResult=true, Dialog(enable=true));

protected
  SI.Length length=Modelica.Math.Vectors.length(r_head) "Length of arrow";

  SI.Length headLengthMax=noEvent(min(length, headLength));
  SI.Length lineLength = length - headLengthMax;
  SI.Position r_shape_cone[3]=r_tail + r_head*noEvent(if length < 1.e-7 then 0 else lineLength/length)
    "Position vector from origin of arrow frame to origin of head's cone shape, resolved in arrow frame";


  MB.Visualizers.Advanced.Shape arrowLine(
    length=lineLength,
    width=diameter,
    height=diameter,
    lengthDirection=to_unit1(r_head),
    widthDirection={0,1,0},
    shapeType="cylinder",
    color=color,
    specularCoefficient=specularCoefficient,
    r_shape=r_tail,
    r=r,
    R=R);
  MB.Visualizers.Advanced.Shape arrowHead(
    length=headLengthMax,
    width=headDiameter,
    height=headDiameter,
    lengthDirection=to_unit1(r_head),
    widthDirection={0,1,0},
    shapeType="cone",
    color=color,
    specularCoefficient=specularCoefficient,
    r_shape=r_shape_cone,
    r=r,
    R=R);

  annotation (
    Documentation(info="<html>
<p>
<strong>Note</strong>: This element is intended to be used in
<a href=\"modelica://PlanarMechanics.Visualizers.Internal.CoordinateSystem\">CoordinateSystem</a> only!
To visualize an arrow in your model, the best solution is usually to use
the visualizer <a href=\"modelica://PlanarMechanics.Visualizers.Advanced.Arrow\">Advanced.Arrow</a>.
The only difference between this two visualizers is that the current one does
not utilizes <strong>outer planarWorld</strong>, whereas the other does.
</p>
<p>
Model <strong>Arrow</strong> defines an arrow that is dynamically
visualized at the defined location (see variables below).
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Arrow.png\" ALT=\"model Visualizers.Advanced.Arrow\">
</div>

<p>
The variables under heading <strong>Parameters</strong> below
are declared as (time varying) <strong>input</strong> variables.
If the default equation is not appropriate, a corresponding
modifier equation has to be provided in the
model where an <strong>Arrow</strong> instance is used, e.g., in the form
</p>
<blockquote><pre>
Visualizers.Advanced.Arrow arrow(diameter = sin(time));
</pre></blockquote>

<p>
Variable <strong>color</strong> is a&nbsp;RGB color space given in the range
0&nbsp;..&nbsp;255.
Predefined colors from
<a href=\"modelica://PlanarMechanics.Types.Defaults\">Types.Defaults</a>
are used throughout the library to get a&nbsp;coherent visualization.
</p>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{-100,28},{20,-30}},
          lineColor={128,128,128},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{20,60},{100,0},{20,-60},{20,60}},
          lineColor={128,128,128},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,100},{150,60}},
          textString="%name",
          textColor={0,0,255})}));
end Arrow;
