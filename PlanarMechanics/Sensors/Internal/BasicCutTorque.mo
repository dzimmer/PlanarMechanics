within PlanarMechanics.Sensors.Internal;
model BasicCutTorque
  "Measure cut torque vector (frame_resolve must be connected)"

  import SI = Modelica.SIunits;
  import Modelica.Mechanics.MultiBody.Types.ResolveInFrameA;
  import Modelica.Mechanics.MultiBody.Frames;

  extends Internal.PartialCutTorqueBaseSensor;

  Modelica.Blocks.Interfaces.RealOutput torque(final quantity="Torque", final unit=
        "N.m") "Cut torque resolved in frame defined by resolveInFrame"
       annotation (Placement(transformation(
        origin={-80,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));

  parameter Boolean positiveSign=true
    "= true, if torque with positive sign is returned (= frame_a.t), otherwise with negative sign (= frame_b.t)";

protected
  parameter Integer csign=if positiveSign then +1 else -1;
equation
  torque = frame_a.t*csign;

  annotation (
     Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Text(
          extent={{-190,-70},{-74,-96}},
          textString="torque"), Line(points={{-80,-100},{-80,0}}, color={0,
              0,127})}),
    Documentation(revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<b>Developed 2010-2019 at the DLR Institute of System Dynamics and Control</b>
</p>
</html>",  info="<HTML>

</HTML>"));
end BasicCutTorque;
