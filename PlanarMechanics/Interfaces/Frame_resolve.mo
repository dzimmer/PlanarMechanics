within PlanarMechanics.Interfaces;
connector Frame_resolve "Coordinate system fixed to the component used to express in which
coordinate system a vector is resolved (non-filled rectangular icon)"
  extends Frame;

  annotation (defaultComponentName="frame_resolve",
    Icon(
      coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        initialScale=0.16),
      graphics={
        Rectangle(
          extent={{-10,10},{10,-10}},
          lineColor={95,95,95},
          pattern=LinePattern.Dot),
        Rectangle(
          extent={{-34,100},{34,-100}},
          lineColor={95,95,95},
          pattern=LinePattern.Dot,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-20,0},{20,0}}, color={135,197,255}),
        Line(points={{0,20},{0,-20}}, color={135,197,255})}),
    Diagram(
      coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        initialScale=0.16),
      graphics={
        Text(
          extent={{-140,-50},{140,-88}},
          textString="%name"),
        Rectangle(
          extent={{-14,50},{14,-52}},
          lineColor={95,95,95},
          pattern=LinePattern.Dot,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-12,0},{12,0}}, color={135,197,255}),
        Line(points={{0,12},{0,-12}}, color={135,197,255})}),
    Documentation(revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<b>Developed 2010-2019 at the DLR Institute of System Dynamics and Control</b>
</p>
</html>",  info="<html>
<p>
Basic definition of a coordinate system that is fixed to a mechanical
component. In the origin of the coordinate system the cut-force
and the cut-torque is acting. This coordinate system is used to
express in which coordinate system a vector is resolved.
A component that uses a Frame_resolve connector has to set the
cut-force and cut-torque of this frame to zero. When connecting
from a Frame_resolve connector to another frame connector,
by default the connecting line has line style \"dotted\".
This component has a non-filled rectangular icon.
</p>
</html>"));
end Frame_resolve;
