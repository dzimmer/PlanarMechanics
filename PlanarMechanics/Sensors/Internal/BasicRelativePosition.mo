within PlanarMechanics.Sensors.Internal;
model BasicRelativePosition
  "Measure relative position vector (same as Sensors.RelativePosition, but frame_resolve is not conditional and must be connected)"
  import Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB;
  extends Sensors.Internal.PartialRelativeBaseSensor;
  Modelica.Blocks.Interfaces.RealOutput r_rel[3](each final quantity="Position", each final
            unit = "m")
    "Relative position vector frame_b.r_0 - frame_a.r_0 resolved in frame defined by resolveInFrame"
    annotation (Placement(transformation(
        origin={0,-110},
        extent={{-10,-10},{10,10}},
        rotation=270)));

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB
    resolveInFrame=
  Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a
    "Frame in which output vector r_rel is resolved (1: world, 2: frame_a, 3: frame_b, 4: frame_resolve)";

equation
   if resolveInFrame == ResolveInFrameAB.frame_a then
      r_rel = transpose({{cos(frame_a.phi), -sin(frame_a.phi), 0}, {sin(frame_a.phi),cos(frame_a.phi), 0}, {0,0,1}}) * {frame_b.x - frame_a.x, frame_b.y - frame_a.y, frame_b.phi - frame_a.phi};
   elseif resolveInFrame == ResolveInFrameAB.frame_b then
      r_rel = transpose({{cos(frame_b.phi), -sin(frame_b.phi), 0}, {sin(frame_b.phi),cos(frame_b.phi), 0}, {0,0,1}}) * {frame_b.x - frame_a.x, frame_b.y - frame_a.y, frame_b.phi - frame_a.phi};
   elseif resolveInFrame == ResolveInFrameAB.world then
      r_rel = {frame_b.x - frame_a.x, frame_b.y - frame_a.y, frame_b.phi - frame_a.phi};
   elseif resolveInFrame == ResolveInFrameAB.frame_resolve then
      r_rel = transpose({{cos(frame_resolve.phi), -sin(frame_resolve.phi), 0}, {sin(frame_resolve.phi),cos(frame_resolve.phi),0}, {0,0,1}}) * {frame_b.x - frame_a.x, frame_b.y - frame_a.y, frame_b.phi - frame_a.phi};
      //r_rel = Frames.resolve2(frame_resolve.R, frame_b.r_0 - frame_a.r_0);
   else
      assert(false, "Wrong value for parameter resolveInFrame");
      r_rel = zeros(3);
   end if;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}},
        grid={1,1}), graphics={Text(
          extent={{12,-76},{96,-106}},
          lineColor={0,0,0},
          textString="r_rel"), Text(
          extent={{-127,95},{134,143}},
          textString="%name",
          lineColor={0,0,255})}));
end BasicRelativePosition;
