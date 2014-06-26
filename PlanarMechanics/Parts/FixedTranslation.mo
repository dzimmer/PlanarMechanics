within PlanarMechanics.Parts;
model FixedTranslation "A fixed translation between two components (rigid rod)"

  Interfaces.Frame_a frame_a
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-120,-20},{-80,20}})));
  Interfaces.Frame_b frame_b annotation (Placement(transformation(extent={{90,-10},
            {110,10}}), iconTransformation(extent={{80,-20},{120,20}})));
  outer PlanarWorld planarWorld "planar world model";
  parameter SI.Length r[2] = {1,0}
    "length of the rod resolved w.r.t to body frame at phi = 0";
  final parameter SI.Length l = sqrt(r*r);
  SI.Position r0[2] "length of the rod resolved w.r.t to inertal frame";
  Real R[2,2] "Rotation matrix";
  parameter Boolean animate = true "= true, if animation shall be enabled"
                                           annotation(Dialog(group="Animation"));
  parameter SI.Length zPosition = planarWorld.defaultZPosition
    "z position of cylinder representing the fixed translation" annotation (Dialog(
      tab="Animation", group="if animation = true", enable=animate));
  parameter SI.Distance width=l/planarWorld.defaultWidthFraction
    "Width of shape"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input Modelica.Mechanics.MultiBody.Types.SpecularCoefficient
    specularCoefficient = planarWorld.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
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
  annotation (Icon(graphics={
        Text(
          extent={{-100,-40},{100,-80}},
          fillPattern=FillPattern.Sphere,
          fillColor={85,170,255},
          textString="%name"), Rectangle(
          extent={{-92,6},{92,-6}},
          fillPattern=FillPattern.Solid,
          fillColor={175,175,175})}),    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p></html>",  info="<html>
<p>This component assures a static position difference <b>r</b> between two frame connectors, to which <b>frame_a</b> and <b>frame_b</b> are connected.</p>
</html>"));
end FixedTranslation;
