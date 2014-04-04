within PlanarMechanics.Types;
type SpecularCoefficient = Modelica.Icons.TypeReal(min=0)
  "Reflection of ambient light (= 0: light is completely absorbed)"
     annotation (
       choices(choice=0 "\"0.0 (dull)\"",choice=0.7 "\"0.7 (medium)\"", choice=1
      "\"1.0 (glossy)\""),
  Documentation(info="<html>
<p>
Type <b>SpecularCoefficient</b> defines the reflection of
ambient light on shape surfaces. If value = 0, the light
is completely absorbed. Often, 0.7 is a reasonable value.
It might be that from some viewing directions, a body is no
longer visible, if the SpecularCoefficient value is too high.
In the following image, the different values of SpecularCoefficient
are shown for a cylinder:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/SpecularCoefficient.png\" />
</p>
</html>"));
