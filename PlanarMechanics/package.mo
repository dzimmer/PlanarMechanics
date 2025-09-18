within ;
package PlanarMechanics "Library to model 2-dimensional, planar mechanical systems"
  extends Modelica.Icons.Package;
  import Modelica.Units.SI;
  import MB = Modelica.Mechanics.MultiBody;


  annotation (
    preferredView="info",
    version="2.0.0-dev",
    versionDate="2023-11-27",
    dateModified="2023-11-27 12:00:00Z",
    uses(
      Modelica(version="4.0.0")),
    conversion(
      from(
        version="1.3.0",
        script="modelica://PlanarMechanics/Resources/Scripts/Conversion/ConvertFromPlanarMechanics_1_3_0.mos"),
      from(
        version={"1.4.1","1.4.0"},
        to="1.5.0",
        script="modelica://PlanarMechanics/Resources/Scripts/Conversion/ConvertFromPlanarMechanics_1_4_1.mos"),
      from(
        version={"1.5.1","1.5.0"},
        script="modelica://PlanarMechanics/Resources/Scripts/Conversion/ConvertFromPlanarMechanics_1_5_0.mos"),
      from(
        version={"1.6.0"},
        script="modelica://PlanarMechanics/Resources/Scripts/Conversion/ConvertPlanarMechanics_1.6.0_to_2.0.0.mos")),
    Documentation(
      info="<html>
<p>
Library <strong>PlanarMechanics</strong> is a <strong>free</strong> Modelica package providing
2-dimensional mechanical components to model mechanical systems, such as
robots, mechanisms, vehicles, where
<a href=\"modelica://Modelica.Mechanics.MultiBody\">MultiBody</a> library is unnecessarily
complex.
</p>
<p>
In order to know how the library works, first have a look at:
</p>
<ul>
<li><a href=\"modelica://PlanarMechanics.UsersGuide\">UsersGuide</a>
    describes the principle ways to use the library.</li>
<li><a href=\"modelica://PlanarMechanics.Examples\">Examples</a>
    contains examples that demonstrate the usage of the library.</li>
</ul>


<h4>Licensed by DLR under the 3-Clause BSD License</h4>
<p>
Copyright &copy; 2010-2023, Deutsches Zentrum f&uuml;r Luft- und Raumfahrt (DLR)
</p>
<p>
<em>This Modelica package is <u>free</u> software and the use is completely
at <u>your own risk</u>; it can be redistributed and/or modified under
the terms of the 3-Clause BSD license. For license conditions (including
the disclaimer of warranty) visit
<a href=\"https://modelica.org/licenses/modelica-3-clause-bsd\">https://modelica.org/licenses/modelica-3-clause-bsd</a>.</em>
</p>
</html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}),
         graphics={
        Ellipse(
          extent={{-30,30},{-10,10}},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-70,-30},{-50,-50}},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{40,-30},{60,-50}},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-60,-40},{-20,20},{50,-40}})}));
end PlanarMechanics;
