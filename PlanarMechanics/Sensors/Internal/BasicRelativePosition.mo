within PlanarMechanics.Sensors.Internal;
model BasicRelativePosition
  "Measure relative position and orientation (same as Sensors.RelativePosition, but frame_resolve is not conditional and must be connected)"
  import Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB;
  extends Sensors.Internal.PartialRelativeBaseSensor;

  Modelica.Blocks.Interfaces.RealOutput r_rel[3](
    final quantity = {"Position", "Position", "Angle"},
    final unit = {"m", "m", "rad"})
    "Vector of relative measurements from frame_a to frame_b on position level, resolved in frame defined by resolveInFrame"
    annotation (Placement(transformation(
        origin={0,-110},
        extent={{-10,-10},{10,10}},
        rotation=270)));

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB resolveInFrame=
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a
    "Frame in which output vector r_rel is resolved (1: world, 2: frame_a, 3: frame_b, 4: frame_resolve)";

protected
  Modelica.Units.SI.Angle phi_ref "Reference angle";
  Real r_rel_0[3] "Vector of relative position and orientation, resolved in world frame";
equation
  if resolveInFrame == ResolveInFrameAB.world then
    phi_ref = 0;
  elseif resolveInFrame == ResolveInFrameAB.frame_a then
    phi_ref = frame_a.phi;
  elseif resolveInFrame == ResolveInFrameAB.frame_b then
    phi_ref = frame_b.phi;
  elseif resolveInFrame == ResolveInFrameAB.frame_resolve then
    phi_ref = frame_resolve.phi;
    //r_rel = Frames.resolve2(frame_resolve.R, frame_b.r_0 - frame_a.r_0);
  else
    assert(false, "Wrong value for parameter resolveInFrame");
    phi_ref = 0;
  end if;

  r_rel_0[3] = {frame_b.x - frame_a.x, frame_b.y - frame_a.y, frame_b.phi - frame_a.phi};
  r_rel = transpose({{cos(phi_ref), -sin(phi_ref), 0}, {sin(phi_ref),cos(phi_ref), 0}, {0,0,1}}) * r_rel_0;

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}, grid={2,2}),
      graphics={
        Text(
          extent={{12,-76},{96,-106}},
          textString="r_rel"),
        Text(
          extent={{-150,140},{150,100}},
          textString="%name",
          textColor={0,0,255})}));
end BasicRelativePosition;
