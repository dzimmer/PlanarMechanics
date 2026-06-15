within PlanarMechanics.Visualizers.Advanced;
model Wheel "Visualizing a wheel"
  import Modelica.Math.{sin,cos};

  input MB.Frames.Orientation R = MB.Frames.nullRotation()
    "Orientation object to rotate the world frame into the wheel frame" annotation(Dialog);
  input SI.Position r[3] = {0,0,0}
    "Position vector from origin of world frame to origin of wheel frame, resolved in world frame"
    annotation(Dialog);
  input SI.Angle psi = 0 "Angle of wheel rotation about its spin axis" annotation(Dialog);

  input SI.Length radius = 0.3 "Wheel radius" annotation(Dialog);
  input SI.Length rRim = 0.9*radius "Rim radius" annotation(Dialog);
  input SI.Length width = 0.6*radius "Wheel width" annotation(Dialog);
  input MB.Types.Color color = PlanarMechanics.Types.Defaults.WheelColor "Color of shape" annotation(Dialog(colorSelector=true));
  input MB.Types.SpecularCoefficient specularCoefficient = 0.7
    "Reflection of ambient light (= 0: light is completely absorbed)" annotation(Dialog);

protected
  final SI.Length wTread = 0.9*width "Width of tread";
  final SI.Length rTread = 1.02*radius "Length of tread";
  final SI.Angle psi45 = Modelica.Units.Conversions.from_deg(45) "Angle offset of tread";
  final SI.Length wRim = 1.04*width "Width of rim";
  final MB.Types.Color colorRim = {195,195,195} "Rim color";
public
  MB.Visualizers.Advanced.Shape cylinder(
    shapeType="cylinder",
    color=color,
    specularCoefficient=specularCoefficient,
    length=width,
    width=2*radius,
    height=2*radius,
    lengthDirection={0,1,0},
    widthDirection={cos(psi),0,-sin(psi)},
    r_shape=-width/2*cylinder.lengthDirection,
    r=r,
    R=R);
  MB.Visualizers.Advanced.Shape tread1(
    shapeType="box",
    color={195,195,195},
    specularCoefficient=specularCoefficient,
    length=wTread,
    width=2*rTread,
    height=radius/8,
    lengthDirection={0,1,0},
    widthDirection={cos(psi+psi45),0,-sin(psi+psi45)},
    r_shape=-wTread/2*tread1.lengthDirection,
    r=r,
    R=R);
  MB.Visualizers.Advanced.Shape tread2(
    shapeType="box",
    color={95,95,95},
    specularCoefficient=specularCoefficient,
    length=wTread,
    width=2*rTread,
    height=radius/8,
    lengthDirection={0,1,0},
    widthDirection={cos(psi-psi45),0,-sin(psi-psi45)},
    r_shape=-wTread/2*tread2.lengthDirection,
    r=r,
    R=R);
  MB.Visualizers.Advanced.Shape rim(
    shapeType="pipe",
    color=colorRim,
    specularCoefficient=specularCoefficient,
    length=wRim,
    width=2*rRim,
    height=2*rRim,
    extra=0.96,
    lengthDirection={0,1,0},
    widthDirection={cos(psi),0,-sin(psi)},
    r_shape=-wRim/2*rim.lengthDirection,
    r=r,
    R=R);
  MB.Visualizers.Advanced.Shape rimSpoke1(
    shapeType="box",
    color=colorRim,
    specularCoefficient=specularCoefficient,
    length=2*rRim,
    width=wRim,
    height=radius/4,
    lengthDirection={cos(psi),0,-sin(psi)},
    widthDirection={0,1,0},
    r_shape=-rRim*rimSpoke1.lengthDirection,
    r=r,
    R=R);
  MB.Visualizers.Advanced.Shape rimSpoke2(
    shapeType="box",
    color=colorRim,
    specularCoefficient=specularCoefficient,
    length=2*rRim,
    width=wRim,
    height=radius/4,
    lengthDirection={sin(psi),0,cos(psi)},
    widthDirection={0,1,0},
    r_shape=-rRim*rimSpoke2.lengthDirection,
    r=r,
    R=R);

  annotation (
    Icon(
      coordinateSystem(preserveAspectRatio=false),
      graphics={
        Text(
          extent={{-150,120},{150,80}},
          textString="%name",
          textColor={0,0,255}),
        Ellipse(
          extent={{-80,80},{80,-80}},
          lineColor={65,65,65},
          fillColor={65,65,65},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-6,60},{6,-60}},
          lineColor={195,195,195},
          fillColor={195,195,195},
          fillPattern=FillPattern.Solid,
          rotation=45),
        Rectangle(
          extent={{-6,60},{6,-60}},
          lineColor={195,195,195},
          fillColor={195,195,195},
          fillPattern=FillPattern.Solid,
          rotation=-45)}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
This shape provides a&nbsp;simple visualization of a&nbsp;wheel. The center of the wheel is
located by position vector&nbsp;<code>r</code>. Its orientation is given by the orientation
object&nbsp;<code>R</code>, whereby wheel&apos;s spin axis points in&nbsp;<var>y</var> direction
of&nbsp;<code>R</code> and its middle plane is in the <var>x</var>-<var>z</var> plane
of&nbsp;<code>R</code>. The wheel&apos;s rotation about its spin axis, i.e. about axis&nbsp;<var>y</var>
of&nbsp;<code>R</code>, can be realized directly by the input <code>psi</code>.
</p>

<div>
<img src=\"modelica://PlanarMechanics/Resources/Images/Visualizers/Advanced/Wheel.png\" ALT=\"model Visualizers.Advanced.Wheel\">
</div>

<p>
The dialog variables <code>R</code>, <code>r</code>, <code>psi</code>,
<code>radius</code>, <code>rRim</code>, <code>width</code>, <code>color</code>
and <code>specularCoefficient</code>
are declared as (time varying) <strong>input</strong> variables.
If the default equation is not appropriate, a&nbsp;corresponding modifier equation has to be
provided in the model where the shape instance is used.
</p>
<p>
Variable <strong>color</strong> is a&nbsp;RGB color space given in the range
0&nbsp;..&nbsp;255.
Predefined colors from
<a href=\"modelica://PlanarMechanics.Types.Defaults\">Types.Defaults</a>
are used throughout the library to get a&nbsp;coherent visualization.
</p>
</html>"));
end Wheel;
