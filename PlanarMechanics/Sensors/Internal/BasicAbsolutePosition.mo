within PlanarMechanics.Sensors.Internal;
model BasicAbsolutePosition
  "Measure absolute position and orientation (same as Sensors.AbsolutePosition, but frame_resolve is not conditional and must be connected)"
  import Modelica.Mechanics.MultiBody.Types.ResolveInFrameA;
  extends Sensors.Internal.PartialAbsoluteBaseSensor;

  Modelica.Blocks.Interfaces.RealOutput r[3](
    final quantity = {"Position", "Position", "Angle"},
    final unit = {"m", "m", "rad"})
    "Vector of absolute measurements on position level, resolved in frame defined by resolveInFrame"
    annotation (Placement(transformation(
        origin={110,0},
        extent={{-10,-10},{10,10}})));

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameA resolveInFrame=
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a
    "Frame in which output vector r is resolved (1: world, 2: frame_a, 3: frame_resolve)";

protected
  Modelica.Units.SI.Angle phi_ref "Reference angle";
  Real r_0[3] "Vector of absolute position and orientation, resolved in world frame";
equation
  if resolveInFrame == ResolveInFrameA.world then
    phi_ref = 0;
  elseif resolveInFrame == ResolveInFrameA.frame_a then
    phi_ref = frame_a.phi;
  elseif resolveInFrame == ResolveInFrameA.frame_resolve then
    phi_ref = frame_resolve.phi;
  else
    assert(false, "Wrong value for parameter resolveInFrame");
    phi_ref = 0;
  end if;

  r_0 = {frame_a.x, frame_a.y, frame_a.phi};
  r = transpose({{cos(phi_ref), -sin(phi_ref), 0}, {sin(phi_ref),cos(phi_ref), 0}, {0, 0, 1}}) * r_0 - {0,0,phi_ref};

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}, grid={2,2}),
      graphics={
        Text(
          extent={{61,47},{145,17}},
          textString="r"),
        Text(
          extent={{-150,120},{150,80}},
          textString="%name",
          textColor={0,0,255})}));
end BasicAbsolutePosition;
