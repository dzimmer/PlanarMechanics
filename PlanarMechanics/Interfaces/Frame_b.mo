within PlanarMechanics.Interfaces;
connector Frame_b
  "Coordinate system (2-dim.) fixed to the component with one cut-force and cut-torque (light blue icon)"
  extends Frame;
  annotation (defaultComponentName="frame_b",
    Icon(
      coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        initialScale=0.16),
      graphics={
        Rectangle(
          extent={{-10,10},{10,-10}},
          lineColor={95,95,95},
          lineThickness=0.5),
        Rectangle(
          extent={{-34,100},{34,-100}},
          lineColor={95,95,95},
          fillColor={225,240,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Line(points={{-20,0},{20,0}}, color={135,197,255}),
        Line(points={{0,20},{0,-20}}, color={135,197,255})}),
    Diagram(
      coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        initialScale=0.16),
      graphics={
        Rectangle(
          extent={{-16,50},{16,-50}},
          lineColor={95,95,95},
          fillColor={225,240,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Line(points={{-12,0},{12,0}}, color={135,197,255}),
        Line(points={{0,12},{0,-12}}, color={135,197,255}),
        Text(
          extent={{-140,-50},{140,-88}},
          textColor={0,0,0},
          textString="%name")}),
    Documentation(revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>",  info="<html>
<p>
This frame connector lies at the origin of the coordinate system attached to it.
Cut-force and cut-torque act at the origin of the coordinate system and are resolved in the
<a href=\"modelica://PlanarMechanics.PlanarWorld\">PlanarWorld</a> frame. Normally, this
connector is fixed to a&nbsp;mechanical component.
It has a&nbsp;non-filled rectangular icon.
</p>
<p>
See also <a href=\"modelica://PlanarMechanics.Interfaces.Frame_a\">Frame_a</a> or
<a href=\"modelica://PlanarMechanics.Interfaces.Frame_resolve\">Frame_resolve</a> .
</p>
</html>
"));
end Frame_b;
