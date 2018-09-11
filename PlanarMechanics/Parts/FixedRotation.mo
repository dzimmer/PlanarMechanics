within PlanarMechanics.Parts;
model FixedRotation "A fixed translation between two components (rigid rod)"
  extends PlanarMechanics.Interfaces.PartialTwoFrames;

  parameter SI.Angle alpha "Fixed rotation angle";
  parameter Boolean animate = true "= true, if animation shall be enabled"
    annotation(Dialog(group="Animation"));
  parameter SI.Length zPosition = planarWorld.defaultZPosition
    "Position z of cylinder representing the fixed rotation" annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animate));
  parameter SI.Length cylinderLength=planarWorld.defaultJointLength
    "Length of cylinder representing the fixed rotation"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animate));
  parameter SI.Length cylinderDiameter=planarWorld.defaultJointWidth
    "Diameter of cylinder representing the fixed rotation"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animate));
  input PlanarMechanics.Types.Color color=Types.Defaults.RodColor
    "Color of cylinder representing the fixed rotation"
    annotation (HideResult = true, Dialog(colorSelector=true,tab="Animation", group="if animation = true", enable=animate));
  input PlanarMechanics.Types.SpecularCoefficient
    specularCoefficient = planarWorld.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (HideResult = true, Dialog(tab="Animation", group="if animation = true", enable=animate));
  //Visualization
  MB.Visualizers.Advanced.Shape cylinder(
    shapeType="cylinder",
    color=color,
    specularCoefficient=specularCoefficient,
    length=cylinderLength,
    width=cylinderDiameter,
    height=cylinderDiameter,
    lengthDirection={0,0,1},
    widthDirection={1,0,0},
    r_shape={0,0,-0.05},
    r=MB.Frames.resolve1(planarWorld.R,{frame_a.x,frame_a.y,zPosition})+planarWorld.r_0,
    R=planarWorld.R) if planarWorld.enableAnimation and animate;
equation
  frame_a.x = frame_b.x;
  frame_a.y = frame_b.y;
  frame_a.phi + alpha = frame_b.phi;
  frame_a.fx + frame_b.fx = 0;
  frame_a.fy + frame_b.fy = 0;
  frame_a.t + frame_b.t = 0;
  annotation (Icon(graphics={
        Polygon(
          points={{96,-8},{96,12},{0,-30},{-96,12},{-96,-6},{0,-50},{96,-8}},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-20,-20},{20,-60}},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-10,-30},{10,-50}},
          lineColor={255,255,255},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Text(
          extent={{-150,80},{150,40}},
          textString="%name",
          lineColor={0,0,255}),
        Text(
          extent={{-108,-24},{-72,-49}},
          lineColor={128,128,128},
          textString="a"),
        Text(
          extent={{72,-24},{108,-49}},
          lineColor={128,128,128},
          textString="b")}),       Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2018 at the DLR Institute of System Dynamics and Control</b></p></html>",  info="<html>
<p>This component assures a static angle difference <b>alpha</b> between two frame connectors, to which <b>frame_a</b> and <b>frame_b</b> are connected.</p>
</html>"));
end FixedRotation;
