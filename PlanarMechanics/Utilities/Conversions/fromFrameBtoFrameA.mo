within PlanarMechanics.Utilities.Conversions;
function fromFrameBtoFrameA "Convert from frameB to frameA"
  extends Modelica.Units.Icons.Conversion;
  input Modelica.Mechanics.MultiBody.Types.ResolveInFrameB FrameB;
  output Modelica.Mechanics.MultiBody.Types.ResolveInFrameA FrameA;

 // Integer temp;
algorithm

  if FrameB == Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.world then
    FrameA := Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world;
  elseif FrameB == Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_b then
    FrameA := Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a;
  else
    FrameA := Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve;
  end if;

  annotation (Inline=true,
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
      graphics={
        Text(
          extent={{-20,100},{-102,56}},
          textColor={0,0,0},
          textString="B"),
        Text(
          extent={{100,-56},{0,-102}},
          textColor={0,0,0},
          textString="A")}));
end fromFrameBtoFrameA;
