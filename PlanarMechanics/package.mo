within ;
package PlanarMechanics "Library to model 2-dimensional, planar mechanical systems"
  extends Modelica.Icons.Package;
  import SI = Modelica.SIunits;
  import MB = Modelica.Mechanics.MultiBody;


  annotation (
    preferredView="info",
    version="1.4.1",
    versionBuild=1,
    versionDate="2019-03-29",
    dateModified = "2019-03-29 12:00:00Z",
    uses(
      Modelica(version="3.2.3")),
    conversion(
      noneFromVersion="1.4.0",
      from(version="1.3.0", script="modelica://PlanarMechanics/Resources/Scripts/Dymola/convertFromPlanarMechanics1_3_0.mos")),
    Documentation(
      info="<html>
<p>
Library <b>PlanarMechanics</b> is a <b>free</b> Modelica package providing
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


<h4>Licensed by DLR e.V. under the 3-Clause BSD License</h4>
<p>
Copyright &copy; 2010-2019, Deutsches Zentrum fuer Luft- und Raumfahrt e.V.
</p>
<p>
<em>This Modelica package is <u>free</u> software and the use is completely
at <u>your own risk</u>; it can be redistributed and/or modified under
the terms of the 3-Clause BSD license. For license conditions (including
the disclaimer of warranty) visit
<a href=\"https://modelica.org/licenses/modelica-3-clause-bsd\">https://modelica.org/licenses/modelica-3-clause-bsd</a>.</em>
</p>
</html>",
      revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<b>Developed 2010-2019 at the DLR Institute of System Dynamics and Control</b>
</p>
</html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}),
         graphics={
        Ellipse(
          extent={{-46,10},{-26,-10}},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-74,-40},{-54,-60}},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{18,-34},{38,-54}},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-64,-50},{-36,0},{24,-42}})}));
end PlanarMechanics;
