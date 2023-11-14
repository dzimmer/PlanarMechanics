within PlanarMechanics.Interfaces;
connector Frame "General connector for planar mechanical components"
  SI.Position x "Frame position in x-direction of planar world frame";
  SI.Position y "Frame position in y-direction of planar world frame";
  SI.Angle phi "Frame angle relative to planar world frame (positive counter-clockwise)";
  flow SI.Force fx "Force in x-direction of planar world frame";
  flow SI.Force fy "Force in y-direction of planar world frame";
  flow SI.Torque t "Torque in phi-direction (positive counter-clockwise)";
  annotation (Documentation(revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>",  info="<html>
<p>
Frame is a&nbsp;connector which lies at the origin of the coordinate system attached to it.
Cut-force and cut-torque act at the origin of the coordinate system and are resolved in the
<a href=\"modelica://PlanarMechanics.PlanarWorld\">PlanarWorld</a> frame. Normally, this
connector is fixed to a&nbsp;mechanical component. But it is never used directly in
a&nbsp;system - use either of inherited frames instead, e.g.
<a href=\"modelica://PlanarMechanics.Interfaces.Frame_a\">Frame_a</a>.
</p>
</html>"));
end Frame;
