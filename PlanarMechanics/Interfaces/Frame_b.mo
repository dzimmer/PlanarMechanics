within PlanarMechanics.Interfaces;
connector Frame_b
  "Coordinate system (2-dim.) fixed to the component with one cut-force and cut-torque (blue icon)"
  extends Frame;
  annotation (Icon(graphics={
        Rectangle(
          extent={{-40,100},{40,-100}},
          lineColor={95,95,95},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Line(
          points={{-18,0},{22,0}},
          color={95,95,95}),
        Line(
          points={{0,20},{0,-20}},
          color={95,95,95})}), Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p></html>",  info="<html>
<p>Frame_b is a connector, which lies at the origin of the coordinate system attached to it. Cut-force and cut_torque act at the origin of the coordinate system. Normally, this connector is fixed to a mechanical component. The same as <a href=\"modelica://PlanarMechanics.Interfaces.Frame_a\">Frame_a</a>.</p>
</html>"));
end Frame_b;
