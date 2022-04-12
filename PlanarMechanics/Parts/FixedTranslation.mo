within PlanarMechanics.Parts;
model FixedTranslation "A fixed translation between two components (rigid rod)"
  extends PlanarMechanics.Interfaces.PartialTwoFrames;

  parameter SI.Length r[2] = {1,0}
    "Fixed x,y-length of the rod resolved w.r.t to body frame_a at phi = 0";
  final parameter SI.Length l = Modelica.Math.Vectors.length(r)
    "Length of vector r";
  SI.Position r0[2] "Length of the rod resolved w.r.t to inertal frame";
  PlanarMechanics.Transformations.Internal.TransformationMatrix R=
    PlanarMechanics.Transformations.RbyAngle(frame_a.phi) "Rotation matrix from world frame to frame_a";

  parameter Boolean animate = true "= true, if animation shall be enabled"
    annotation(Dialog(group="Animation"));
  parameter SI.Length zPosition = planarWorld.defaultZPosition
    "Position z of cylinder representing the fixed translation" annotation (Dialog(
      tab="Animation", group="if animation = true", enable=animate));
  parameter SI.Distance width=l/planarWorld.defaultWidthFraction
    "Width of shape"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animate));
  input MB.Types.Color color=Types.Defaults.RodColor
    "Color of shape" annotation (HideResult = true, Dialog(
      colorSelector=true,
      tab="Animation",
      group="if animation = true",
      enable=animate));
  input MB.Types.SpecularCoefficient
    specularCoefficient = planarWorld.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (HideResult = true, Dialog(tab="Animation", group="if animation = true", enable=animate));
  //Visualization
  MB.Visualizers.Advanced.Shape cylinder(
    shapeType="cylinder",
    color=color,
    specularCoefficient=specularCoefficient,
    length=l,
    width=width,
    height=width,
    lengthDirection={r0[1]/l,r0[2]/l,0},
    widthDirection={0,0,1},
    r_shape={0,0,0},
    r=MB.Frames.resolve1(planarWorld.R,{frame_a.x,frame_a.y,zPosition})+planarWorld.r_0,
    R=planarWorld.R) if planarWorld.enableAnimation and animate;
equation
  //resolve the rod w.r.t inertial system
//  sx0 = cos(frame_a.phi)*sx + sin(frame_a.phi)*sy;
//  sy0 = -sin(frame_a.phi)*sx + cos(frame_a.phi)*sy;
  r0 = PlanarMechanics.Transformations.resolve2in1(frame_a.phi, r);
  //rigidly connect positions
  frame_a.x + r0[1] = frame_b.x;
  frame_a.y + r0[2] = frame_b.y;
  frame_a.phi = frame_b.phi;
  //balance forces including lever principle
  frame_a.fx + frame_b.fx = 0;
  frame_a.fy + frame_b.fy = 0;
//  frame_a.t + frame_b.t - sx0*frame_b.fy + sy0*frame_b.fx = 0;
  frame_a.t + frame_b.t + r0*{frame_b.fy,-frame_b.fx} = 0;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),
      graphics={
        Rectangle(
          extent={{-100,6},{100,-6}},
          fillPattern=FillPattern.Solid,
          fillColor={175,175,175}),
        Text(
          extent={{-108,-24},{-72,-49}},
          textColor={128,128,128},
          textString="a"),
        Text(
          extent={{72,-24},{108,-49}},
          textColor={128,128,128},
          textString="b"),
        Text(
          extent={{-150,80},{150,40}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-100,-50},{100,-80}},
          textColor={0,0,0},
          textString="r=%r")}),
    Documentation(revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>",  info="<html>
<p>
This component assures a&nbsp;static position difference <strong>r</strong> between two
frame connectors, to which <strong>frame_a</strong> and <strong>frame_b</strong>
are connected.
</p>
</html>"));
end FixedTranslation;
