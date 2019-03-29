within PlanarMechanics.Interfaces;
partial model PartialTwoFramesAndHeat
  "Partial model with two frames and HeatPort"
  extends PlanarMechanics.Interfaces.PartialTwoFrames;
  extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;

  annotation (
    Documentation(info="<html>
<p>The gear interface partial model is a model that has all the interfaces of each planar gear connection. Each planar gear model should be extended from this base level model.</p>
</html>", revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<b>Developed 2010-2019 at the DLR Institute of System Dynamics and Control</b>
</p>
</html>"));
end PartialTwoFramesAndHeat;
