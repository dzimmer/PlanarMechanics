within PlanarMechanics.Interfaces;
model ZeroPosition
  "Set zero position vector and orientation object of frame_resolve"
  extends Modelica.Blocks.Icons.Block;

  Interfaces.Frame_resolve frame_resolve
    annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));
equation
  frame_resolve.x = 0;
  frame_resolve.y = 0;
  frame_resolve.phi = 0;

  annotation (
    Icon(
      coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
      graphics={
        Text(
          extent={{-74,24},{80,-20}},
          textString="r = 0")}),
    Documentation(
      info="<html>
<p>
Set absolute position vector of <code>frame_resolve</code> to a zero
vector and its orientation object to a null rotation
</p>
</html>"));
end ZeroPosition;
