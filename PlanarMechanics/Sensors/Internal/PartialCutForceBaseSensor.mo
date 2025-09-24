within PlanarMechanics.Sensors.Internal;
partial model PartialCutForceBaseSensor
  "Base model to measure the cut force and/or torque between two frames, defined by equations (frame_resolve must be connected exactly once)"

  extends Modelica.Icons.RoundSensor;
  Interfaces.Frame_a frame_a "Coordinate system a" annotation (Placement(
        transformation(extent={{-116,-16},{-84,16}})),
      mustBeConnected="Connector frame_a should be connected");
  Interfaces.Frame_b frame_b "Coordinate system b" annotation (Placement(
        transformation(extent={{84,-16},{116,16}})),
      mustBeConnected="Connector frame_b should be connected");
  Interfaces.Frame_resolve frame_resolve
    "Output vector is optionally resolved in this frame (cut-force/-torque are set to zero)"
    annotation (Placement(transformation(
        origin={80,-100},
        extent={{-16,-16},{16,16}},
        rotation=270)),
      mustBeConnected="Connector frame_resolve should be connected",
      mayOnlyConnectOnce="Connector frame_resolve must be connected exactly once");

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameA resolveInFrame=
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a
    "Frame in which output vector is resolved (1: world, 2: frame_a, 3: frame_resolve)";

protected
  outer PlanarWorld planarWorld;
equation
  // frame_a and frame_b are identical
  {frame_a.x, frame_a.y} = {frame_b.x, frame_b.y};
  frame_a.phi = frame_b.phi;

  // force and torque balance
  zeros(2) = {frame_a.fx, frame_a.fy} + {frame_b.fx, frame_b.fy};
  0 = frame_a.t + frame_b.t;
  frame_resolve.fx = 0;
  frame_resolve.fy = 0;
  frame_resolve.t = 0;
  annotation (
    Documentation(revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>",  info="<html>
<p>
This is a base class for 3-dim. mechanical components with two frames
and one output port in order to measure the cut-force and/or
cut-torque acting between the two frames and
to provide the measured signals as output for further processing
with the blocks of package Modelica.Blocks.
</p>
</html>"), Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-70,0},{-101,0}}),
        Line(points={{70,0},{100,0}}),
        Text(
          extent={{-118,55},{-82,30}},
          textColor={128,128,128},
          textString="a"),
        Text(
          extent={{83,55},{119,30}},
          textColor={128,128,128},
          textString="b"),
        Text(
          extent={{70,-66},{201,-91}},
          textColor={95,95,95},
          textString="resolve"),
        Line(
          points={{80,0},{80,-100}},
          color={95,95,95},
          pattern=LinePattern.Dot),
        Text(
          extent={{-150,120},{150,80}},
          textString="%name",
          textColor={0,0,255})}));
end PartialCutForceBaseSensor;
