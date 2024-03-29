within PlanarMechanics.UsersGuide.Tutorial;
class OverView "Overview of PlanarMechanics library"
  extends Modelica.Icons.Information;
  annotation (
    Documentation(
      revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>",
      info="<html>
<p>
Library <strong>PlanarMechanics</strong> is a&nbsp;<strong>free</strong>
Modelica package providing 2-dimensional mechanical components to
model <strong>mechanical systems</strong>, such as robots, mechanisms,
vehicles, where MultiBody library is too complex to use.
The main features of the library are:
</p>
<ul>
  <li> Much more <strong>compact</strong> than MultiBody library, which means fewer
       parameters to be set, shorter time to build up a model-based system, in the
       meanwhile containing important information as much as possible.</li>
  <li> A <strong>PlanarWorld</strong> model could be used to set up almost all global
       parameters, such as visualization of global coordinate system, animation parameters
       of joints, parts, sources etc., and gravity definition as well as its animation.
       Note that, in most cases the animation parameters set in PlanarWorld model can be
       also overwritten in individual model.</li>
  <li> <strong>Built-in animation properties</strong> of all components, such as joints,
       forces, bodies, sensors. It enables an easy visual check of the constructed model.
       What&#39;s more, in all models animation can be disabled respectively, while in
       the PlanarWorld model animations of all models are able to be switched off.</li>
</ul>
</html>"));
end OverView;
