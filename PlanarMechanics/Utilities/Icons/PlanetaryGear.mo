within PlanarMechanics.Utilities.Icons;
model PlanetaryGear "Icon for planetary gears"
  annotation (Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{80,-100}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,0,0}),
        Rectangle(
          extent={{-100,100},{68,90}},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,-90},{68,-100}},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{68,100},{80,-100}},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,38},{8,-38}},
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-60,88},{8,40}},
          fillColor={0,127,0},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-60,-40},{8,-88}},
          fillColor={0,127,0},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None),
        Rectangle(
          extent={{8,70},{24,60}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,0}),
        Rectangle(
          extent={{8,-60},{24,-70}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,0}),
        Rectangle(
          extent={{44,10},{100,-10}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,0}),
        Rectangle(
          extent={{24,82},{44,-82}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,0}),
        Rectangle(
          extent={{-100,10},{-60,-10}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,0,255}),
        Text(
          extent={{-140,140},{140,100}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(
      revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>",
      info="<html>
<p>
This partial class is intended to design a <em>default icon for a planetary gear models</em>.
</p>
</html>"));
end PlanetaryGear;
