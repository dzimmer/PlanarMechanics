within PlanarMechanics.Sensors.Internal;
model BasicAbsolutePosition
  "Measure absolute position vector (same as Sensors.AbsolutePosition, but frame_resolve is not conditional and must be connected)"
  import Modelica.Mechanics.MultiBody.Types.ResolveInFrameA;
  extends Sensors.Internal.PartialAbsoluteBaseSensor;

  Modelica.Blocks.Interfaces.RealOutput r[3](each final quantity="Position", each final unit = "m")
    "Absolute position vector frame_a.r_0 resolved in frame defined by resolveInFrame"
    annotation (Placement(transformation(
        origin={110,0},
        extent={{-10,-10},{10,10}},
        rotation=0)));

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameA
    resolveInFrame=
  Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a
    "Frame in which output vector r is resolved (1: world, 2: frame_a, 3: frame_resolve)";

equation
   if resolveInFrame == ResolveInFrameA.world then
      r = {frame_a.x, frame_a.y, frame_a.phi};
   elseif resolveInFrame == ResolveInFrameA.frame_a then
      r = transpose({{cos(frame_a.phi), -sin(frame_a.phi), 0}, {sin(frame_a.phi),cos(frame_a.phi), 0}, {0, 0, 1}}) * {frame_a.x, frame_a.y, frame_a.phi} - {0,0,frame_a.phi};

   elseif resolveInFrame == ResolveInFrameA.frame_resolve then
      r = transpose({{cos(frame_resolve.phi), -sin(frame_resolve.phi), 0}, {sin(frame_resolve.phi),cos(frame_resolve.phi), 0}, {0,0,1}}) * {frame_a.x, frame_a.y, frame_a.phi} - {0,0,frame_resolve.phi};
   else
      assert(false, "Wrong value for parameter resolveInFrame");
      r = zeros(3);
   end if;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}},
        grid={1,1}), graphics={Text(
          extent={{61,47},{145,17}},
          lineColor={0,0,0},
          textString="r"), Text(
          extent={{-127,75},{134,123}},
          textString="%name",
          lineColor={0,0,255})}),Diagram(coordinateSystem(
          preserveAspectRatio=true,  extent={{-100,-100},{100,100}},
        grid={1,1}),
        graphics));
end BasicAbsolutePosition;
