within PlanarMechanics.Visualizers.Internal;
model CoordinateSystem
  "Visualizing an orthogonal coordinate system of three axes"

  input SI.Position r[3]={0,0,0}
    "Position vector from origin of world frame to origin of object frame, resolved in world frame"
    annotation(Dialog);
  input MB.Frames.Orientation R=MB.Frames.nullRotation()
    "Orientation object to rotate the world frame into the object frame"  annotation(Dialog);
  input SI.Position r_shape[3]={0,0,0}
    "Position vector from origin of object frame to shape origin, resolved in object frame"
    annotation(Dialog);

  parameter SI.Length axisLength=0.5 "Length of world axes arrows";
  parameter SI.Diameter axisDiameter=axisLength/40
    "Diameter of world axes arrows";

  parameter MB.Types.Color color_x=PlanarMechanics.Types.Defaults.FrameColor
    "Color of x-arrow"
    annotation (HideResult = true, Dialog(colorSelector=true));
  parameter MB.Types.Color color_y=color_x "Color of y-arrow"
    annotation (HideResult = true, Dialog(colorSelector=true));
  parameter MB.Types.Color color_z=color_x "Color of z-arrow"
    annotation (HideResult = true, Dialog(colorSelector=true));

  parameter Boolean axisShowLabels=true "True, if labels shall be shown"
    annotation (HideResult=true, Dialog(group="Axes labels"));
  parameter SI.Length labelStart=1.05*axisLength
    annotation(Dialog(group="Axes labels", enable=axisShowLabels));
  parameter SI.Length scaledLabel=PlanarMechanics.Types.Defaults.FrameLabelHeightFraction*axisDiameter
    annotation(Dialog(group="Axes labels", enable=axisShowLabels));

protected
  Arrow x_arrow(
    R=R,
    r=r,
    r_tail={0,0,0},
    r_head=axisLength*{1,0,0},
    diameter=axisDiameter,
    color=color_x,
    specularCoefficient=0);
  MB.Visualizers.Internal.Lines x_label(
    R=R,
    r=r,
    r_lines={labelStart,0,0},
    lines=scaledLabel*{[0,0; 1,1],[0,1; 1,0]},
    diameter=axisDiameter,
    n_x={1,0,0},
    n_y={0,1,0},
    color=color_x,
    specularCoefficient=0) if axisShowLabels;
  Arrow y_arrow(
    R=R,
    r=r,
    r_tail={0,0,0},
    r_head=axisLength*{0,1,0},
    diameter=axisDiameter,
    color=color_y,
    specularCoefficient=0);
  MB.Visualizers.Internal.Lines y_label(
    R=R,
    r=r,
    r_lines={0,labelStart,0},
    lines=scaledLabel*{[0,0; 1,1.5],[0,1.5; 0.5,0.75]},
    diameter=axisDiameter,
    n_x={0,1,0},
    n_y={-1,0,0},
    color=color_y,
    specularCoefficient=0) if axisShowLabels;
  Arrow z_arrow(
    R=R,
    r=r,
    r_tail={0,0,0},
    r_head=axisLength*{0,0,1},
    diameter=axisDiameter,
    color=color_z,
    specularCoefficient=0);
  MB.Visualizers.Internal.Lines z_label(
    R=R,
    r=r,
    r_lines={0,0,labelStart},
    lines=scaledLabel*{[0,0; 1,0],[0,1; 1,1],[0,1; 1,0]},
    diameter=axisDiameter,
    n_x={0,0,1},
    n_y={0,1,0},
    color=color_z,
    specularCoefficient=0) if axisShowLabels;
  annotation (Documentation(info="<html>
<p>
<strong>Note</strong>: This element is intended to be used in
<a href=\"modelica://PlanarMechanics.PlanarWorld\">PlanarWorld</a> and its derivatives only!
To visualize a coordinate system in your model, the best solution is usually to use
the visualizer <a href=\"modelica://PlanarMechanics.Visualizers.Advanced.CoordinateSystem\">Advanced.CoordinateSystem</a>.
The only difference between this two visualizers is that the current one does
not utilizes <strong>outer planarWorld</strong>, whereas the other does.
</p>
<p>
This element enbles visualization of an <strong>orthogonal coordinate system</strong>
as shown in the following picture.
</p>

<div>
<img src=\"modelica://PlanarMechanics/Resources/Images/Visualizers/Advanced/CoordinateSystem.png\" ALT=\"model Visualizers.Advanced.CoordinateSystem\">
</div>

<p>
The variables <code>r</code>, <code>R</code> and <code>r_shape</code>
are declared as (time varying) <strong>input</strong> variables.
If the default equation is not appropriate, a corresponding
modifier equation has to be provided in the
model where a <strong>CoordinateSystem</strong> instance is used, e.g., in the form
</p>
<blockquote><pre>
PlanarMechanics.Visualizers.Advanced.CoordinateSystem coordinateSystem(r = {sin(time), 0, 0.3});
</pre></blockquote>

<p>
<strong>Color</strong> of each axis can be set individually using RGB color space given in the range 0 .. 255.
The predefined type <a href=\"modelica://PlanarMechanics.Types.Color\">Types.Color</a>
contains a menu definition of the colors used in the library
(will be replaced by a color editor).
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Text(
          extent={{-150,100},{150,60}},
          textColor={0,0,255},
          textString="%name"),
        Polygon(
          points={{-50,-90},{0,-72},{50,-90},{90,-70},{26,-16},{8,40},{-8,40},{-28,
              -16},{-90,-70},{-50,-90}},
          lineColor={255,255,255},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,-30},{0,40}},
          color={135,135,135},
          thickness=0.5),
        Line(
          points={{0,-30},{74,-66}},
          color={135,135,135},
          thickness=0.5),
        Line(
          points={{-70,-66},{0,-30}},
          thickness=0.5,
          color={135,135,135}),
        Text(
          extent={{-69,-54},{-20,-84}},
          textColor={135,135,135},
          textString="x"),
        Polygon(
          points={{-96,-80},{-64,-72},{-76,-58},{-96,-80}},
          lineColor={135,135,135},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{100,-82},{76,-56},{66,-72},{100,-82}},
          lineColor={135,135,135},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{25,-54},{74,-84}},
          textColor={135,135,135},
          textString="z"),
        Text(
          extent={{10,60},{61,30}},
          textColor={135,135,135},
          textString="y"),
        Polygon(
          points={{-14,22},{14,22},{0,62},{-14,22}},
          lineColor={135,135,135},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid)}));
end CoordinateSystem;
