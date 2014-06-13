within PlanarMechanics.Utilities.Conversions;
function fromFrameAtoFrameB
  extends Modelica.SIunits.Icons.Conversion;
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

end fromFrameAtoFrameB;
