within PlanarMechanics.UsersGuide.Tutorial;
class FirstExample "A first example"
  extends Modelica.Icons.Information;
  annotation (Documentation(revisions="<html><p><img src=\"./Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p></html>",  info="<html>
<p>Here seveal steps will be listed to demonstrate how to build up, simulate and animate a <b>simple pendulum</b>, which consists of a fixed point, a planar wolld model, a revolute joint, a fixed translation and a body.</p>
<p><ul>
<li><b>Building up Modelica composition diagram</b>.</li>
</ul></p>
<p>The diagram is showed as following.</p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/FirstExample1.png\"/></p>
<p>where component <b>Fixed</b>, <b>Body</b>, <b>FixedTranslation </b>can be found in <b>Parts</b> package, component <b>Revolute</b> in <b>Joints</b>, <b>PlanarWorld</b> directly under PlanarMechanics. </p>
<p>Every model having components from PlanarMechanics library must include an instance of component PlanarWorld on the highest level. The reason is that PlanarWorld component defines the default gravity for the model, includes default settings of animation parameters of almost every components.</p>
<p><ul>
<li><h4>Setting up initial values and parameters.</h4></li>
</ul></p>
<p>In this step, we only need to double click the relevant component and write initial values and parameters in the blanks. Default gravity force in is {0,-9.81}. In this example, phi.start in revolute component is set to be 50m and I in Body are respectively 1 and 0.1; all other settings remain default.</p>
<p><ul>
<li><h4>Translating and simulating the simple pendulum model.</h4></li>
</ul></p>
<p>With the above settings, animation is as following:</p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/FirstExample2.png\"/></p>
</html>"));
end FirstExample;
