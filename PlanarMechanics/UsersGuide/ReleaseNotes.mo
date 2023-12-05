within PlanarMechanics.UsersGuide;
class ReleaseNotes "Release notes"
  extends Modelica.Icons.ReleaseNotes;

  annotation (
   Documentation(
      info="<html>
<h4>Version 2.0.0, 2024-mm-dd</h4>
<p>
This version requires the <strong>Modelica&nbsp;4.0.0</strong> Library.
It is <strong>not</strong> backwards compatible to previous library versions.
</p>

<p>New components:</p>
<ul>
  <li>
    ...
  </li>
</ul>

<p>Deleted components (conversion script provided):</p>
<ul>
  <li>
    PlanarMechanics.Types.<strong>SpecularCoefficient</strong>: use
    <a href=\"modelica://Modelica.Mechanics.MultiBody.Types.SpecularCoefficient\">Modelica.Mechanics.MultiBody.Types.SpecularCoefficient</a>
    instead.
  </li>
  <li>
    PlanarMechanics.Types.<strong>Color</strong>: use
    <a href=\"modelica://Modelica.Mechanics.MultiBody.Types.Color\">Modelica.Mechanics.MultiBody.Types.Color</a>
    instead.
  </li>
  <li>
    PlanarMechanics.Utilities.Functions.<strong>atan3b</strong>: use
    <a href=\"modelica://Modelica.Math.atan3\">Modelica.Math.atan3</a>
    instead. Note, there were defined also corresponding derivation functions
    &quot;atan3b_der&quot; and &quot;atan3b_dder&quot;. Since they both
    were just usable within atan3b, they are deleted completely without
    a&nbsp;conversion.
  </li>
</ul>

<p>Deleted parameters:</p>
<ul>
  <li>
    <a href=\"modelica://PlanarMechanics.Sources.RelativeForce\">Sources.RelativeForce</a>:
    diameter
  </li>
  <li>
    <a href=\"modelica://PlanarMechanics.Sources.WorldForce\">Sources.WorldForce</a>:
    diameter
  </li>
  <li>
    <a href=\"modelica://PlanarMechanics.Sources.QuadraticSpeedDependentForce\">Sources.QuadraticSpeedDependentForce</a>:
    diameter
  </li>
  <li>
    <a href=\"modelica://PlanarMechanics.Sensors.CutForce\">Sensors.CutForce</a>:
    forceDiameter
  </li>
  <li>
    <a href=\"modelica://PlanarMechanics.Sensors.CutForceAndTorque\">Sensors.CutForceAndTorque</a>:
    forceDiameter, torqueDiameter
  </li>
  <li>
    <a href=\"modelica://PlanarMechanics.Sensors.CutTorque\">Sensors.CutTorque</a>:
    torqueDiameter
  </li>
</ul>

<p>Improvements:</p>
<ul>
  <li>
    <a href=\"modelica://PlanarMechanics.Sources.QuadraticSpeedDependentForce\">QuadraticSpeedDependentForce</a>:
    fix false type of parameter <code>resolveInFrame</code>. The type
    <a href=\"modelica://Modelica.Mechanics.MultiBody.Types.ResolveInFrameB\">Modelica.Mechanics.MultiBody.Types.ResolveInFrameB</a>
    is used instead of 
    <a href=\"modelica://Modelica.Mechanics.MultiBody.Types.ResolveInFrameA\">Modelica.Mechanics.MultiBody.Types.ResolveInFrameA</a>.
    A&nbsp;conversion scripts exists which converts definitions like
    <blockquote><pre>
PlanarMechanics.Sources.QuadraticSpeedDependentForce force(
  resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a);
    </pre></blockquote>
    into
    <blockquote><pre>
PlanarMechanics.Sources.QuadraticSpeedDependentForce force(
  resolveInFrame=
    <font style=\"font-family: Courier New; color: #ff0000;\">if      Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a ==
            Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a then
              Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_b</font>
    else if Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a) ==
            Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world then
              Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.world
    else
              Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_resolve);
    </pre></blockquote>
    which is formally correct but unreadable. In the code above, the obviously intended
    conversion result is highlighted red. It can be reduced by the user itself to
    <blockquote><pre>
PlanarMechanics.Sources.QuadraticSpeedDependentForce force(
  resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_b);
    </pre></blockquote>
  </li>
</ul>


<h4>Version 1.6.0, 2023-09-12</h4>
<p>
This version requires the <strong>Modelica&nbsp;4.0.0</strong> Library.
It is backwards compatible to previous library versions.
</p>

<p>New components:</p>
<ul>
  <li>
    VehicleComponents: <a href=\"modelica://PlanarMechanics.VehicleComponents.AirResistanceLongitudinal\">Air drag model</a>
    for vehicles.
  </li>
</ul>

<p>Improvements in this version:</p>
<ul>
  <li>
    <a href=\"modelica://PlanarMechanics.Sources.QuadraticSpeedDependentForce\">QuadraticSpeedDependentForce</a>:
    delete redundant equations when <code>resolveInFrame&nbsp;= frame_resolve</code>.
  </li>
  <li>
    Types <a href=\"modelica://PlanarMechanics.Types.Color\">Color</a>
    and <a href=\"modelica://PlanarMechanics.Types.SpecularCoefficient\">SpecularCoefficient</a>
    are obsolete and will be deleted in the next major library release.
    Corresponding types from
    <a href=\"modelica://Modelica.Mechanics.MultiBody.Types\">Modelica.Mechanics.MultiBody.Types</a>
    are used instead.
  </li>
  <li>
    <a href=\"modelica://PlanarMechanics.Sensors\">Sensors</a> and
    <a href=\"modelica://PlanarMechanics.Sources\">Sources</a>:
    use <a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Vector\">Modelica.Mechanics.MultiBody.Visualizers.Advanced.Vector</a>
    for visualization of vector quantities (force, torque, etc.).
  </li>
  <li>
    <a href=\"modelica://PlanarMechanics.Examples.WheelBasedCraneCrab\">Examples.WheelBasedCraneCrab</a>:
    fix typo in the example name (previously WheelBasedCranCrab).
  </li>
  <li>
    VehicleComponents: add
    <a href=\"modelica://PlanarMechanics.VehicleComponents.Wheels.BaseClasses\">Wheels.BaseClasses</a>
    to collect common wheel&apos;s elements.
  </li>
</ul>


<h4>Version 1.5.1, 2021-11-30</h4>
<p>
This version requires the <strong>Modelica&nbsp;4.0.0</strong> Library.
It is backwards compatible to previous library versions.
</p>

<p>Improvements in this version:</p>
<ul>
  <li> Fix false unit of unit vector <var>e</var> in
       <a href=\"modelica://PlanarMechanics.Joints.Prismatic\">Joints.Prismatic</a>.
  </li>
  <li> <a href=\"modelica://PlanarMechanics.GearComponents.RigidNoLossInternal\">GearComponents.RigidNoLossInternal</a>
       and
       <a href=\"modelica://PlanarMechanics.GearComponents.RigidNoLossExternal\">GearComponents.RigidNoLossExternal</a>:
       Use the 3D relation of a&nbsp;circular motion
       (<var>v</var>&nbsp;= <var>&omega;</var> <code>x</code> <var>r</var>)
       to calculate <code>w_gear</code> directly and in continuous matter.
  </li>
  <li> Fix underdetermined initialization of example
       <a href=\"modelica://PlanarMechanics.GearComponents.Examples.PlanetaryGear\">GearComponents.Examples.PlanetaryGear</a>.
  </li>
  <li> Improve documentation.
  </li>
</ul>


<h4>Version 1.5.0, 2020-10-02</h4>
<p>
This version requires the <strong>Modelica&nbsp;4.0.0</strong> Library.
It is backwards compatible to previous library versions.
</p>

<p>Improvements in this version:</p>
<ul>
  <li> <a href=\"modelica://PlanarMechanics.Sensors\">Sensors</a>: add quantity and
       unit to outputs where missing.</li>
</ul>


<h4>Version 1.4.1, 2019-03-29</h4>
<p>
This version requires the <strong>Modelica&nbsp;3.2.3</strong> Library.
It is backwards compatible to previous library versions.
</p>

<ul>
  <li> The license has been changed to BSD 3-clause, visit:
       <a href=\"https://modelica.org/licenses/modelica-3-clause-bsd\">https://modelica.org/licenses/modelica-3-clause-bsd</a>.</li>
</ul>

<p>Improvements in this version:</p>
<ul>
  <li> PNG files moved to folders which exactly represent the package structure
       (see also <a href=\"modelica://Modelica.UsersGuide.Conventions.Documentation.Format.Figures\">Modelica.UsersGuide.Conventions.Documentation.Format.Figures</a>).</li>
  <li> Documentation of some classes.</li>
  <li> Improved icons of some classes.</li>
</ul>

<!--
<p>New features</p>
<ul>
<li>...</li>
</ul>
-->

<h4>Version 1.4.0, 2017-01-12</h4>
<p>
Various improvements and bug fixes of components and documentation.
</p>


<h4>Version 1.3.0, 2014-06-13</h4>
<p>
Various improvements and bug fixes of components and documentation.
</p>


<h4>Version 1.2.0, 2014-06-02</h4>
<p>
First official release of the PlanarMechanics library.
</p>
</html>"));
end ReleaseNotes;
