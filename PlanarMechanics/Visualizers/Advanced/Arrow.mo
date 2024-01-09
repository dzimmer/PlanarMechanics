within PlanarMechanics.Visualizers.Advanced;
model Arrow
  "Visualizing an arrow with variable size; all data have to be set as modifiers (see info layer)"

  input MB.Frames.Orientation R=MB.Frames.nullRotation()
    "Orientation object to rotate the planarWorld frame into the arrow frame" annotation(Dialog);
  input SI.Position r[3]={0,0,0}
    "Position vector from origin of planarWorld frame to origin of arrow frame, resolved in planarWorld frame"
    annotation(Dialog);
  input SI.Position r_tail[3]={0,0,0}
    "Position vector from origin of arrow frame to arrow tail, resolved in arrow frame"
    annotation(Dialog);
  input SI.Position r_head[3]={0,0,0}
    "Position vector from arrow tail to the head of the arrow, resolved in arrow frame"
    annotation(Dialog);
  input SI.Diameter diameter=planarWorld.defaultArrowDiameter
    "Diameter of arrow line" annotation(Dialog);
  input SI.Length headDiameter=3*diameter "Diameter of arrow head"
    annotation(Dialog(enable=true));
  input SI.Length headLength=5*diameter "Length of arrow head"
    annotation(Dialog(enable=true));
  input MB.Types.Color color=PlanarMechanics.Types.Defaults.ArrowColor "Color of arrow"
    annotation(HideResult=true, Dialog(colorSelector=true));
  input MB.Types.SpecularCoefficient specularCoefficient = planarWorld.defaultSpecularCoefficient
    "Material property describing the reflecting of ambient light (= 0 means, that light is completely absorbed)"
    annotation(HideResult=true, Dialog);

protected
  outer PlanarWorld planarWorld;
  Internal.Arrow arrow(
    R=R,
    r=r,
    r_tail=r_tail,
    r_head=r_head,
    diameter=diameter,
    headDiameter=headDiameter,
    headLength=headLength,
    color=color,
    specularCoefficient=specularCoefficient) if planarWorld.enableAnimation;
  annotation (
    Documentation(info="<html>
<p>
Model <strong>Arrow</strong> defines an arrow that is dynamically
visualized at the defined location (see variables below).
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Arrow.png\" ALT=\"model Visualizers.Advanced.Arrow\">
</div>

<p>
The dialog variables <code>R</code>, <code>r</code>, <code>r_tail</code>,
<code>r_head</code>, <code>diameter</code>, <code>color</code>
and <code>specularCoefficient</code>
are declared as (time varying) <strong>input</strong> variables.
If the default equation is not appropriate, a&nbsp;corresponding
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
          extent={{-100,30},{20,-30}},
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
