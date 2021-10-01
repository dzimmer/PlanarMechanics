within PlanarMechanics.VehicleComponents;
model DifferentialGear "Simple Model of a differential gear"

  Modelica.Mechanics.Rotational.Components.IdealPlanetary idealPlanetary(
      ratio=-2)  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-52})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_left
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_right
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  connect(flange_b,idealPlanetary. ring) annotation (Line(
      points={{0,-100},{0,-62},{0,-62}}));
  connect(idealPlanetary.carrier, flange_right) annotation (Line(
      points={{4,-42},{4,0},{100,0}}));
  connect(idealPlanetary.sun, flange_left) annotation (Line(
      points={{0,-42},{0,-42},{0,0},{-100,0}}));
  annotation (Icon(graphics={
        Rectangle(
          extent={{-60,50},{40,-50}},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-48,40},{40,-40}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{40,-60},{60,-80},{60,80},{40,60},{40,-60}},
          pattern=LinePattern.None,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{20,-60},{40,-80},{-40,-80},{-20,-60},{20,-60}},
          pattern=LinePattern.None,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{14,10},{34,-10},{-34,-10},{-14,10},{14,10}},
          pattern=LinePattern.None,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          origin={-30,0},
          rotation=270),
        Polygon(
          points={{14,10},{34,-10},{-32,-10},{-12,10},{14,10}},
          pattern=LinePattern.None,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          origin={-4,-26},
          rotation=360),
        Polygon(
          points={{16,10},{36,-10},{-32,-10},{-12,10},{16,10}},
          pattern=LinePattern.None,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          origin={24,-2},
          rotation=90),
        Rectangle(
          extent={{-100,10},{-40,-10}},
          pattern=LinePattern.None,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{34,10},{102,-10}},
          pattern=LinePattern.None,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-10,-100},{10,-80}},
          pattern=LinePattern.None,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-16,-36},{10,-40}},
          pattern=LinePattern.None,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,120},{150,80}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(info="<html>
<p>The differential gear is a 1D-rotational component. It is a variant of a planetary gear and can be used to distribute the torque equally among the wheels on one axis.</p>
</html>",
      revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<b>Developed 2010-2020 at the DLR Institute of System Dynamics and Control</b>
</p>
</html>"));
end DifferentialGear;
