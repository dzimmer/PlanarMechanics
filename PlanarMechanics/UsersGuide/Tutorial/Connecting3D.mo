within PlanarMechanics.UsersGuide.Tutorial;
class Connecting3D "Connecting planar models to the 3-dimensional world"
  extends Modelica.Icons.Information;
  annotation (
    Documentation(
      revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/>
<b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b>
</p>
</html>",
      info="<html>
<p>
It is possible to connect the planar (2D) and the three-dimensional (3D) worlds in a&nbsp;limited
manner. The connection is particularly enabled by the adaptor
<a href=\"modelica://PlanarMechanics.Interfaces.PlanarTo3D\">PlanarTo3D</a> and
settings in the <a href=\"modelica://PlanarMechanics.PlanarWorldIn3D\">PlanarWorldIn3D</a>.
There are several <a href=\"modelica://PlanarMechanics.Examples.PlanarTo3D\">examples</a>
available that demonstrate how to use the adaptor in this context.
</p>

<h4>Key limitations and considerations</h4>
<ul>
  <li>
    All 2D components reference a&nbsp;single instance of the 2D world.
    Therefore, it is not possible to combine two or more 2D worlds within the 3D world.
  </li>
  <li>
    In the 2D world, there are neither forces perpendicular to the 2D plane nor torques
    about axes in the 2D plane. Therefore, such forces or torques cannot be transferred between
    the 2D and 3D worlds, which is a&nbsp;critical consideration for force balance in user models.
    If such forces are required, they must be implemented directly in the 3D world in another way.
  </li>
  <li>
    The <code>PlanarTo3D</code> adaptor is essential for integrating planar and 3D systems,
    enabling the use of the simpler planar mechanics library while still benefiting from
    3D visualization and analysis.
  </li>
</ul>

<h4>How to properly use the planar-to-multibody adaptor</h4>
<p>
When connecting 2D and 3D mechanics, two main situations can occur.
Typically, the 3D system acts as the &quot;leading&quot; mechanism, meaning it is connected to or
otherwise related to the 3D world frame. In this case, a&nbsp;kinematic tree for the 3D mechanism
is established, and one or more 2D mechanisms are connected at the ends of kinematic branches.
Alternatively, the planar world may act as the leading mechanism, driving the 3D system.
</p>
<p>
For both cases, the planar-to-multibody adaptor
<a href=\"modelica://PlanarMechanics.Interfaces.PlanarTo3D\">PlanarTo3D</a>
can be used to connect the two worlds. In the first case &ndash; considered the typical usage
&ndash; the adaptor works without trouble.
</p>
<p>
In the second case, where the 2D system is leading, a&nbsp;<em>root</em> of the 3D kinematic tree
must be established within the PlanarTo3D adaptor. For more details on connections and rooting,
refer e.g. to
<a href=\"https://specification.modelica.org/maint/3.7/connectors-and-connections.html#connection-graphs-and-their-operators\">Modelica Specification</a>.
Depending on the modeled system, a&nbsp;Modelica tool may automatically handle this, as the
<code>frameMultiBody</code> connector of the adaptor is generally treated as a&nbsp;&quot;potential
root&quot;.
However, the chances are high that this automatic procedure will fail and the simulation of the
system will generate false results.
</p>
<p>
To properly resolve this situation, the <code>rootMBS</code> parameter of the PlanarTo3D adaptor 
should be explicitly set to <em>true</em>. This forces the <code>frameMultiBody</code> connector 
to be treated as a&nbsp;root in the subsequent multibody kinematic tree.
The example 
<a href=\"modelica://PlanarMechanics.Examples.PlanarTo3D.PendulumLongRoot\">PendulumLongRoot</a>
demonstrates the correct usage of this parameter.
</p>
</html>"));
end Connecting3D;
