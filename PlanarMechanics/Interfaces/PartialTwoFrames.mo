within PlanarMechanics.Interfaces;
partial model PartialTwoFrames "Partial model with two frames"

  Frame_a frame_a
    "Coordinate system fixed to the component with one cut-force and cut-torque"
    annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));
  Frame_b frame_b
    "Coordinate system fixed to the component with one cut-force and cut-torque"
    annotation (Placement(transformation(extent={{84,-16},{116,16}})));

protected
  outer PlanarMechanics.PlanarWorld planarWorld "Planar world model";

equation
  assert(cardinality(frame_a) > 0,
    "Connector frame_a of " + getInstanceName() + " is not connected");
  assert(cardinality(frame_b) > 0,
    "Connector frame_b of " + getInstanceName() + " is not connected");

  annotation (Documentation(revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<b>Developed 2010-2019 at the DLR Institute of System Dynamics and Control</b>
</p>
</html>",  info="<html>
<p>This is a partial model with two planar frames. It can be inherited to build up models with 2 planar flanges.</p>
<!--
This partial model provides two planar frame connectors, access to the world
object and an assert to check that both frame connectors are connected.
Therefore, inherit from this partial model if the two frame connectors are
needed and if the two frame connectors should be connected for a correct model.
-->
</html>"));
end PartialTwoFrames;
