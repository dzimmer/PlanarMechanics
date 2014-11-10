within PlanarMechanics.GearComponents.Examples.Utilities.Interfaces;
partial model TwoPlanarConnectorsHeat "Planar gear connectors and HeatPort"
  extends PlanarMechanics.Interfaces.PartialTwoFlanges;
  extends
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;

  annotation (
    Documentation(info="<html>
<p>The gear interface partial model is a model that has all the interfaces of each planar gear connection. Each planar gear model should be extended from this base level model.</p>
</html>", revisions="<html>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p>
</html>"));
end TwoPlanarConnectorsHeat;
