within PlanarMechanics.GearComponents.Examples.Utilities.Interfaces;
partial model PlanetaryGearInterface
 extends PlanarMechanics.Utilities.Icons.PlanetaryGear;
 extends Modelica.Thermal.HeatTransfer.Interfaces.PartialConditionalHeatPort;

  Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_Ring
    "Flange of shaft"
    annotation (Placement(transformation(extent={{-110,50},{-90,70}},rotation=0),
        iconTransformation(extent={{-110,50},{-90,70}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_Sun
    "Flange of shaft"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
                                                                     rotation=0),
        iconTransformation(extent={{-110,-10},{-90,10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_Carrier
                                                             annotation (
      Placement(transformation(extent={{90,-10},{110,10}}),iconTransformation(
          extent={{90,-10},{110,10}})));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics), Icon(coordinateSystem(preserveAspectRatio=
            false, extent={{-100,-100},{100,100}}), graphics),
    Documentation(revisions="<html>
<p><img src=\"modelica://PlanarMechanicmodelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p>
</html>"));
end PlanetaryGearInterface;
