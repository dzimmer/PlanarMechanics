within PlanarMechanics.Visualizers.Internal;
model Arrow
  "Visualizing an arrow with variable size; all data have to be set as modifiers (see info layer)"

  import T = Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
  import Modelica.SIunits.Conversions.to_unit1;

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
  input PlanarMechanics.Types.Color color=PlanarMechanics.Types.Defaults.ArrowColor
    "Color of arrow"
    annotation(HideResult=true, Dialog(colorSelector=true));
  input PlanarMechanics.Types.SpecularCoefficient specularCoefficient = 0.7
    "Material property describing the reflecting of ambient light (= 0 means, that light is completely absorbed)"
    annotation(HideResult=true, Dialog(enable=true));

protected
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
  SI.Length headWidth=noEvent(max(0, diameter*PlanarMechanics.Types.Defaults.ArrowHeadWidthFraction))
    annotation(HideResult=true);
  SI.Length arrowLength = noEvent(max(0, length - diameter*PlanarMechanics.Types.Defaults.ArrowHeadLengthFraction))
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
    R=R);
  MB.Visualizers.Advanced.Shape arrowHead(
    length=headLength,
    width=headWidth,
    height=headWidth,
    lengthDirection=to_unit1(r_head),
    widthDirection={0,1,0},
    shapeType="cone",
    color=color,
    specularCoefficient=specularCoefficient,
    r=rvisobj + rxvisobj*arrowLength,
    R=R);

  annotation (
    Documentation(info="<html>
<p>
<b>Note</b>: This element is intended to be used in <a href=\"PlanarMechanics.Visualizers.Internal.CoordinateSystem\">CoordinateSystem</a> only!
To visualize an arrow in your model, the best solution is usually to use the visualizer <a href=\"PlanarMechanics.Visualizers.Advanced.Arrow\">Advanced.Arrow</a>.
The only difference between this two visualizers is that the current one does not utilizes <b>outer planarWorld</b>, 
whereas the other does.
</p>
<p>
Model <b>Arrow</b> defines an arrow that is dynamically
visualized at the defined location (see variables below).
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Arrow.png\" ALT=\"model Visualizers.Advanced.Arrow\">
</p>

<p>
The variables under heading <b>Parameters</b> below
are declared as (time varying) <b>input</b> variables.
If the default equation is not appropriate, a corresponding
modifier equation has to be provided in the
model where an <b>Arrow</b> instance is used, e.g., in the form
</p>
<blockquote><pre>
Visualizers.Advanced.Arrow arrow(diameter = sin(time));
</pre></blockquote>

<p>
Variable <b>color</b> is a RGB color space given in the range 0 .. 255.
The predefined type <a href=\"modelica://PlanarMechanics.Types.Color\">Types.Color</a>
contains a menu definition of the colors used in the library</a>
(will be replaced by a color editor).
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
          lineColor={0,0,255})}));
end Arrow;
