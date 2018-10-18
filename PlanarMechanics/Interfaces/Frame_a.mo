within PlanarMechanics.Interfaces;
connector Frame_a
  "Coordinate system (2-dim.) fixed to the component with one cut-force and cut-torque (blue icon)"
  extends Frame;
  annotation (defaultComponentName="frame_a",
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
          fillColor={70,163,255},
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
          fillColor={70,163,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Line(points={{-12,0},{12,0}}, color={135,197,255}),
        Line(points={{0,12},{0,-12}}, color={135,197,255}),
                                      Text(
          extent={{-140,-50},{140,-88}},
          lineColor={0,0,0},
          textString="%name")}),
    Documentation(revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<b>Developed 2010-2018 at the DLR Institute of System Dynamics and Control</b>
</p>
</html>",  info="<html>
<p>Frame_a is a connector, which lies at the origin of the coordinate system attached to it. Cut-force and cut_torque act at the origin of the coordinate system and are resolved in planarWorld frame. Normally, this connector is fixed to a mechanical component. The same as <a href=\"modelica://PlanarMechanics.Interfaces.Frame_b\">Frame_b</a>.</p>
</html>"));
end Frame_a;
