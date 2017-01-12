within PlanarMechanics.Interfaces;
connector Frame "General connector for planar mechanical components"
  SI.Position x "x-position";
  SI.Position y "y-position";
  SI.Angle phi "Angle (counter-clockwise)";
  flow SI.Force fx "Force in x-direction, resolved in planarWorld frame";
  flow SI.Force fy "Force in y-direction, resolved in planarWorld frame";
  flow SI.Torque t "Torque (clockwise)";
  annotation (Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p></html>",  info="<html>
<p>Frame is a connector, which lies at the origin of the coordinate system attached to it. Cut-force and cut_torque act at the origin of the coordinate system and are resolved in planarWorld frame. Normally, this connector is fixed to a mechanical component. But this model is never used directly in a system. It is only for usage of inheritance.</p>
</html>"));
end Frame;
