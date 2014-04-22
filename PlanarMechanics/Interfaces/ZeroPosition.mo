within PlanarMechanics.Interfaces;
model ZeroPosition
  "Set absolute position vector of frame_resolve to a zero vector and the orientation object to a null rotation"
   extends Modelica.Blocks.Interfaces.BlockIcon;
  Interfaces.Frame_resolve frame_resolve
    annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));
equation
  frame_resolve.x = 0;
  frame_resolve.y = 0;
  frame_resolve.phi = 0;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
          extent={{-74,24},{80,-20}},
          lineColor={0,0,0},
          textString="r = 0")}));
end ZeroPosition;
