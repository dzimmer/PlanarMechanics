within PlanarMechanics.Joints;
model Prismatic "A prismatic joint"
  extends PlanarMechanics.Interfaces.PartialTwoFrames;

  parameter Boolean useFlange=false
    "= true, if force flange enabled, otherwise implicitly grounded"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean animate = true "= true, if animation shall be enabled" annotation(Evaluate=true, HideResult=true);
  parameter StateSelect stateSelect=StateSelect.default
    "Priority to use s and v as states" annotation(HideResult=true,Dialog(tab="Advanced"));

  parameter SI.Position r[2] "Direction of the rod wrt. body system at phi=0";
  final parameter SI.Length l = sqrt(r*r) "Lengt of r";
  final parameter SI.Distance e[2]= r/l "Normalized r";

  Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a(f = f, s = s) if useFlange
   annotation (
      Placement(transformation(extent={{-10,-100},{10,-80}})));

  parameter SI.Length zPosition = planarWorld.defaultZPosition
    "Position z of the prismatic joint box" annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animate));
  parameter SI.Distance boxWidth=l/planarWorld.defaultWidthFraction
    "Width of prismatic joint box"
    annotation (Dialog(tab="Animation",
      group="if animation = true", enable=animate));
  input Types.Color boxColor=Types.Defaults.JointColor
    "Color of prismatic joint box"
    annotation (HideResult=true, Dialog(tab="Animation",
      group="if animation = true", enable=animate));
  input Modelica.Mechanics.MultiBody.Types.SpecularCoefficient
    specularCoefficient = planarWorld.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (HideResult=true, Dialog(tab="Animation",
      group="if animation = true", enable=animate));

  SI.Position s(final stateSelect = stateSelect, start = 0)
    "Elongation of the joint" annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Velocity v(final stateSelect = stateSelect, start = 0)
    "Velocity of elongation" annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Acceleration a(start = 0) "Acceleration of elongation" annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Force f "Force in direction of elongation";
  Real e0[2] "Direction of the prismatic rod resolved wrt. inertial frame";
  SI.Position r0[2]
    "Translation vector of the prismatic rod resolved wrt. inertial frame";
  Real R[2,2] "Rotation Matrix";

  //Visualization
  MB.Visualizers.Advanced.Shape box(
    shapeType="box",
    color=boxColor,
    specularCoefficient=specularCoefficient,
    length=s,
    width=boxWidth,
    height=boxWidth,
    lengthDirection={e0[1],e0[2],0},
    widthDirection={0,0,1},
    r_shape={0,0,0},
    r=MB.Frames.resolve1(planarWorld.R,{frame_a.x,frame_a.y,zPosition})+planarWorld.r_0,
    R=planarWorld.R) if planarWorld.enableAnimation and animate;

equation
  //resolve the rod w.r.t. inertial system
  R = {{cos(frame_a.phi), -sin(frame_a.phi)}, {sin(frame_a.phi),cos(frame_a.phi)}};
  e0 = R*e;
  r0 = e0*s;
  //differential equations
  v = der(s);
  a = der(v);
  //actuation force
  if not useFlange then
    f = 0;
  end if;
  //rigidly connect positions
  frame_a.x + r0[1] = frame_b.x;
  frame_a.y + r0[2] = frame_b.y;
  frame_a.phi = frame_b.phi;
  //balance forces including lever principle
  frame_a.fx + frame_b.fx = 0;
  frame_a.fy + frame_b.fy = 0;
  frame_a.t  + frame_b.t + r0*{frame_b.fy,-frame_b.fx} = 0;
  {frame_a.fx,frame_a.fy}*e0 = f;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),
                   graphics={
        Rectangle(
          extent={{-100,40},{-20,-40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={175,175,175}),
        Rectangle(
          extent={{-20,-20},{100,20}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={175,175,175}),
        Line(
          visible=useFlange,
          points={{0,-90},{0,-20}}),
        Text(
          extent={{-140,-22},{-104,-47}},
          lineColor={128,128,128},
          textString="a"),
        Text(
          extent={{104,-22},{140,-47}},
          lineColor={128,128,128},
          textString="b"),
        Text(
          extent={{-150,100},{150,60}},
          textString="%name",
          lineColor={0,0,255}),
        Text(
          extent={{-100,-50},{100,-80}},
          lineColor={0,0,0},
          textString="r=%r")}),
    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p></html>",  info="<html>
<p>Direction of the Joint is determined by <b>r[2]</b>, which is a vector pointing from <b>frame_a</b> to <b>frame_b</b>. </p>
<p>By setting <b>useFlange</b> as true, the flange for a 1-dim. translational input will be activated. In the &quot;Initialization&quot; block, elongation of the joint <b>s</b>, velocity of elongation <b>v</b> as well as acceleration of elongation <b>a</b> can be initialized.</p>
<p>It can be defined via parameter (in &quot;advanced&quot; tab) <b>stateSelect</b> that the relative distance &quot;s&quot; and its derivative shall be definitely used as states by setting stateSelect=StateSelect.always. </p>
<p>In &quot;Animation&quot; group, animation parameters for this model can be set, where <b>zPosition</b> represents the model&apos;s position along the z axis in 3D animation. Some of the values can be preset by an outer PlanarWorld model.</p>
</html>"));
end Prismatic;
