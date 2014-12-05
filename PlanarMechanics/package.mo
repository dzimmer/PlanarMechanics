within ;
package PlanarMechanics "A planar mechanical library for didactical purposes"
  extends Modelica.Icons.Package;
  import SI = Modelica.SIunits;
  import MB = Modelica.Mechanics.MultiBody;


  annotation (
    preferredView="info",
    version="1.4.0 Development Version",
    versionDate="2014-11-11",
    uses(Modelica(version="3.2.1")),
    conversion(
      from(version="1.3.0", script="modelica://PlanarMechanics/Resources/Scripts/Dymola/convertFromPlanarMechanics1_3_0.mos")),
    Documentation(
      revisions=
        "<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p></html>",
      info="<html>
<p>Library <b>PlanarMechanics</b> is a <b>free</b> Modelica package providing 2-dimensional mechanical components to model mechanical systems, such as robots, mechanisms, vehicles, where MultiBody library is unneccesarily complex.</p>
<p>In order to know how the library works, first have a look at:</p>
<ul>
<li><a href=\"modelica://PlanarMechanics.UsersGuide\">PlanarMechanics.UsersGuide</a> describes the principle ways to use the library.</li>
<li><a href=\"modelica://PlanarMechanics.Examples\">PlanarMechanics.Examples</a> contains examples that demonstrate the usage of the library.</li>
</ul>
<h4>Licensed by DLR e.V. under the Modelica License 2</h4>
<p>Copyright &copy; 2010-2014, Deutsches Zentrum fuer Luft- und Raumfahrt e.V.</p>
<p><i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"http://www.modelica.org/licenses/ModelicaLicense2\">http://www.modelica.org/licenses/ModelicaLicense2</a>.</i></p>
</html>"),
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(visible = true, lineColor = {0, 95, 127}, fillColor = {45, 161, 204}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}, radius = 25), Polygon(visible = true, origin = {-44.011, -9.193}, lineColor = {179, 179, 179}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Sphere, points = {{-35.989, -40.807}, {8.028, 54.436}, {32.105, 44.118}, {-4.143, -57.747}}), Polygon(visible = true, origin = {29.647, 47.559}, lineColor = {179, 179, 179}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Sphere, points = {{-37.584, 14.354}, {38.616, 7.739}, {38.616, -11.046}, {-39.647, -11.046}}), Ellipse(visible = true, origin = {75, 45}, lineColor = {160, 160, 164}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-17, -17}, {17, 17}}), Ellipse(visible = true, origin = {-20, 50}, lineColor = {160, 160, 164}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-22, -22}, {22, 22}}), Ellipse(visible = true, origin = {-63.922, -58.175}, lineColor = {160, 160, 164}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-27, -27}, {27, 27}}), Ellipse(visible = true, origin = {-64.006, -58.283}, lineColor = {160, 160, 164}, fillColor = {160, 160, 164}, fillPattern = FillPattern.Solid, extent = {{-11, -11}, {11, 11}}), Ellipse(visible = true, origin = {-20, 50}, lineColor = {160, 160, 164}, fillColor = {160, 160, 164}, fillPattern = FillPattern.Solid, extent = {{-11, -11}, {11, 11}}), Ellipse(visible = true, origin = {75.039, 45.03}, lineColor = {160, 160, 164}, fillColor = {160, 160, 164}, fillPattern = FillPattern.Solid, extent = {{-8, -8}, {8, 8}})}));
end PlanarMechanics;
