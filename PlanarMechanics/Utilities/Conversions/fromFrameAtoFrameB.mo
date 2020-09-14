within PlanarMechanics.Utilities.Conversions;
function fromFrameAtoFrameB "Convert from frameA to frameB"
  extends Modelica.Units.Icons.Conversion;
  input Modelica.Mechanics.MultiBody.Types.ResolveInFrameA FrameA;
  output Modelica.Mechanics.MultiBody.Types.ResolveInFrameB FrameB;

 // Integer temp;
algorithm

  if FrameA == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world then
    FrameB := Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.world;
  elseif FrameA == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a then
    FrameB := Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_b;
  else
    FrameB := Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_resolve;
  end if;

  annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
          extent={{-20,100},{-102,56}},
          lineColor={0,0,0},
          textString="A"),     Text(
          extent={{100,-56},{0,-102}},
          lineColor={0,0,0},
          textString="B")}));
end fromFrameAtoFrameB;
