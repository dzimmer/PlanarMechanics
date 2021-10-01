within PlanarMechanics.UsersGuide.Tutorial;
class FirstExample "A first example"
  extends Modelica.Icons.Information;
  annotation (
    Documentation(
      revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010-2020 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>",
      info="<html>
<p>Here seveal steps will be listed to demonstrate how to build up, simulate and animate a <strong>simple pendulum</strong>, which consists of a fixed point, a planar world model, a revolute joint, a fixed translation and a body.</p>
<ul>
  <li><strong>Building up Modelica composition diagram</strong>.</li>
</ul>
<p>The diagram is showed as following.</p>
<div>
<img src=\"modelica://PlanarMechanics/Resources/Images/UsersGuide/Tutorial/FirstExample/FirstExample1.png\" alt=\"Modelica diagram\">
</div>
<p>where component <strong>Fixed</strong>, <strong>Body</strong>, <strong>FixedTranslation </strong>can be found in <strong>Parts</strong> package, component <strong>Revolute</strong> in <strong>Joints</strong>, <strong>PlanarWorld</strong> directly under PlanarMechanics.</p>
<p>Every model having components from PlanarMechanics library must include an instance of component PlanarWorld on the highest level. The reason is that PlanarWorld component defines the default gravity for the model, includes default settings of animation parameters of almost every components.</p>
<ul>
<li><h4>Setting up initial values and parameters.</h4></li>
</ul>
<p>In this step, we only need to double click the relevant component and write initial values and parameters in the blanks. Default gravity force in is {0,-9.81}. In this example, phi.start in revolute component is set to be 50&deg;, m and I in Body are respectively 1kg and 0.1kgm<sup>2</sup>; all other settings remain default.</p>
<ul>
<li><h4>Translating and simulating the simple pendulum model.</h4></li>
</ul>
<p>With the above settings, animation is as following:</p>
<div>
<img src=\"modelica://PlanarMechanics/Resources/Images/UsersGuide/Tutorial/FirstExample/FirstExample2.png\" alt=\"First example animation\">
</div>
</html>"));
end FirstExample;
