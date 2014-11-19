within PlanarMechanics.Parts;
model FixedTranslation "A fixed translation between two components (rigid rod)"
  extends PlanarMechanics.Interfaces.PartialTwoFrames;

  parameter SI.Length r[2] = {1,0}
    "Fixed x,y-length of the rod resolved w.r.t to body frame_a at phi = 0";
  final parameter SI.Length l = sqrt(r*r) "Length of vector r";
  SI.Position r0[2] "Length of the rod resolved w.r.t to inertal frame";
  Real R[2,2] "Rotation matrix";
  parameter Boolean animate = true "= true, if animation shall be enabled"
                                           annotation(Dialog(group="Animation"));
  parameter SI.Length zPosition = planarWorld.defaultZPosition
    "Position z of cylinder representing the fixed translation" annotation (Dialog(
      tab="Animation", group="if animation = true", enable=animate));
  parameter SI.Distance width=l/planarWorld.defaultWidthFraction
    "Width of shape"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input Modelica.Mechanics.MultiBody.Types.SpecularCoefficient
    specularCoefficient = planarWorld.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (HideResult = true, Dialog(tab="Animation", group="if animation = true", enable=animation));
  //Visualization
  MB.Visualizers.Advanced.Shape cylinder(
    shapeType="cylinder",
    color={128,128,128},
    specularCoefficient=specularCoefficient,
    length=l,
    width=width,
    height=width,
    lengthDirection={r0[1]/l,r0[2]/l,0},
    widthDirection={0,0,1},
    r_shape={0,0,0},
    r={frame_a.x,frame_a.y,zPosition},
    R=MB.Frames.nullRotation()) if planarWorld.enableAnimation and animate;
equation
  //resolve the rod w.r.t inertial system
//  sx0 = cos(frame_a.phi)*sx + sin(frame_a.phi)*sy;
//  sy0 = -sin(frame_a.phi)*sx + cos(frame_a.phi)*sy;
  R = {{cos(frame_a.phi), -sin(frame_a.phi)}, {sin(frame_a.phi),cos(frame_a.phi)}};
  r0 = R*r;
  //rigidly connect positions
  frame_a.x + r0[1] = frame_b.x;
  frame_a.y + r0[2] = frame_b.y;
  frame_a.phi = frame_b.phi;
  //balance forces including lever principle
  frame_a.fx + frame_b.fx = 0;
  frame_a.fy + frame_b.fy = 0;
//  frame_a.t + frame_b.t - sx0*frame_b.fy + sy0*frame_b.fx = 0;
  frame_a.t  + frame_b.t + r0*{frame_b.fy,-frame_b.fx} = 0;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),
      graphics={
        Rectangle(
          extent={{-100,6},{100,-6}},
          fillPattern=FillPattern.Solid,
          fillColor={175,175,175}),
        Text(
          extent={{-108,-24},{-72,-49}},
          lineColor={128,128,128},
          textString="a"),
        Text(
          extent={{72,-24},{108,-49}},
          lineColor={128,128,128},
          textString="b"),
        Text(
          extent={{-150,80},{150,40}},
          textString="%name",
          lineColor={0,0,255}),
        Text(
          extent={{-100,-50},{100,-80}},
          lineColor={0,0,0},
          textString="r=%r")}),          Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p></html>",  info="<html>
<p>This component assures a static position difference <b>r</b> between two frame connectors, to which <b>frame_a</b> and <b>frame_b</b> are connected.</p>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics));
end FixedTranslation;
