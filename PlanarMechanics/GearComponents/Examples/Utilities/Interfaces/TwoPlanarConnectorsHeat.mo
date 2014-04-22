within PlanarMechanics.GearComponents.Examples.Utilities.Interfaces;
partial model TwoPlanarConnectorsHeat "Planar gear connectors and HeatPort"
  extends
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;

public
  PlanarMechanics.Interfaces.Frame_a frame_a
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-120,-20},{-80,20}})));
  PlanarMechanics.Interfaces.Frame_b frame_b
    annotation (Placement(transformation(extent={{90,-10},{110,10}}),
        iconTransformation(extent={{80,-20},{120,20}})));
  annotation (
    Documentation(info="<html>
<p>The gear interface partial model is a model that has all the interfaces of each planar gear connection. Each planar gear model should be extended from this base level model.</p>
</html>", revisions="<html>
<p><img src=\"modelica://PlanarMechanicmodelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p>
</html>"));
end TwoPlanarConnectorsHeat;
