within ;
package PlanarMechanics "A planar mechanical library for didactical purposes"
import SI = Modelica.SIunits;
import MB = Modelica.Mechanics.MultiBody;


extends Modelica.Icons.Package;


  annotation (
  preferredView="info",
  version="1.2.0",
  versionDate="2014-01-30",
  uses(Modelica(version="3.2")), Documentation( revisions=
        "<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p></html>",
          info="<html>
<p>Library <b>PlanarMechanics</b> is a <b>free</b> Modelica package providing 2-dimentional mechanical components to model mechanical systems, such as robots, mechanisms, vehicles, where MultiBody library is unneccesarily complex.</p>
<p>In order to know how the library works, first have a look at:</p>
<p><ul>
<li><a href=\"modelica://PlanarMechanics.UsersGuide\">PlanarMechanics.UsersGuide</a> describes the principle ways to use the library.</li>
<li><a href=\"modelica://PlanarMechanics.Examples\">PlanarMechanics.Examples</a> contains examples that demonstrate the usage of the library.</li>
</ul></p>
<p><h4>Licensed by DLR e.V under the Modelica License 2</h4></p>
<p>Copyright &copy; 2010-2014, Deutsches Zentrum fuer Luft- und Raumfahrt e.V. </p>
<p><i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"http://www.modelica.org/licenses/ModelicaLicense2\">http://www.modelica.org/licenses/ModelicaLicense2</a>.</i> </p>
</html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}),
         graphics={
        Ellipse(
          extent={{-46,10},{-26,-8}},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-74,-42},{-54,-60}},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{18,-34},{38,-52}},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-64,-50},{-36,0},{24,-42}},
          color={0,0,0},
          smooth=Smooth.None)}),
  Diagram(coordinateSystem(extent={{-100,-100},{100,100}})));
end PlanarMechanics;
