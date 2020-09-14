within PlanarMechanics.Sensors.Internal;
partial model PartialCutTorqueSensor
  "Base model to measure the cut force and/or torque between two frames, defined by components"

  extends Modelica.Icons.RotationalSensor;
  Interfaces.Frame_a frame_a "Coordinate system a" annotation (Placement(
        transformation(extent={{-116,-16},{-84,16}})));
  Interfaces.Frame_b frame_b "Coordinate system b" annotation (Placement(
        transformation(extent={{84,-16},{116,16}})));
//   Interfaces.Frame_resolve frame_resolve if
//          resolveInFrame==Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve
//     "Output vectors are optionally resolved in this frame (cut-force/-torque are set to zero)"
//     annotation (Placement(transformation(
//         origin={80,-100},
//         extent={{-16,-16},{16,16}},
//         rotation=270)));
//
//   parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameA
//     resolveInFrame=
//   Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a
//     "Frame in which output vector(s) is/are resolved (1: world, 2: frame_a, 3: frame_resolve)";

protected
  outer PlanarWorld planarWorld;
equation
  assert(cardinality(frame_a) > 0,
    "Connector frame_a of cut-force/-torque sensor object is not connected");
  assert(cardinality(frame_b) > 0,
    "Connector frame_b of cut-force/-torque sensor object is not connected");

  annotation (
    Documentation(revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<b>Developed 2010-2020 at the DLR Institute of System Dynamics and Control</b>
</p>
</html>",
      info="<html>
<p>
This is a base class for 3-dim. mechanical components with two frames
and one output port in order to measure the cut-force and/or
cut-torque acting between the two frames and
to provide the measured signals as output for further processing
with the blocks of package Modelica.Blocks.
</p>
</html>"), Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-70,0},{-101,0}}),
        Line(points={{70,0},{100,0}}),
        Text(
          extent={{-118,55},{-82,30}},
          lineColor={128,128,128},
          textString="a"),
        Text(
          extent={{83,55},{119,30}},
          lineColor={128,128,128},
          textString="b"),
        Text(
          extent={{-150,120},{150,80}},
          textString="%name",
          lineColor={0,0,255})}));
end PartialCutTorqueSensor;
