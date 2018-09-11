within PlanarMechanics.UsersGuide.Tutorial;
class Connecting3D "Connecting planar models to the 3-dimensional world"
  extends Modelica.Icons.Information;
  annotation (Documentation(revisions=
          "<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p></html>",
                                                                                                    info="<html>
<p>
It is possible to connect the planar and the 3-dimensional worlds in a limited manner.
The connection is particularly enabled by the adaptor
<a href=\"modelica://PlanarMechanics.Interfaces.PlanarTo3D\">Interfaces.PlanarTo3D</a> and
settings in the  <a href=\"modelica://PlanarMechanics.PlanarWorldIn3D\">PlanarWorldIn3D</a>.
There are defined some examples on how to use the adaptor in that context.
It should be kept in mind that the 2D/3D connection has some limitations. In particular:
</p>
<ul>
<li>
All the 2D components reference just one instance of the 2D world.
Therefore, no combinations of two of more 2D worlds is possible in 3D world.
</li>
<li>
In the 2D world, there exist neither force perpendicular to the 2D plane
nor torques around 2D plane axes.
Therefore, no such forces can be transferred between the 2D/3D worlds.
</li>
</ul>
</html>"));
end Connecting3D;
