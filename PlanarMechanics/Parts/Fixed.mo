within PlanarMechanics.Parts;
model Fixed "FixedPosition"

  Interfaces.Frame_a frame_a
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-120,-20},{-80,20}})));
  parameter SI.Position r[2] = {0,0} "fixed x,y-position";
  parameter SI.Angle phi = 0 "fixed angle";
equation
  {frame_a.x,frame_a.y} = r;
  frame_a.phi = phi;
  annotation (Icon(graphics={
        Text(
          extent={{-100,-80},{100,-120}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={85,170,255},
          textString="%name"),
        Line(
          points={{-92,0},{0,0}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{0,80},{0,-80}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{0,40},{80,0}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{0,80},{80,40}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{0,0},{80,-40}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{0,-40},{80,-80}},
          color={0,0,0},
          smooth=Smooth.None)}), Diagram(graphics),
    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p></html>",  info="<html>
<p>This component defines the x, y-position and angle of the frame connectors, to which this component is attached to.</p>
</html>"));
end Fixed;
