within PlanarMechanics.Joints;
model Prismatic "A prismatic joint"

  Interfaces.Frame_a frame_a annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
            iconTransformation(extent={{-120,-20},{-80,20}})));
  Interfaces.Frame_b frame_b annotation (Placement(transformation(extent={{90,-10},
            {110,10}}), iconTransformation(extent={{80,-20},{120,20}})));

  outer PlanarWorld planarWorld "planar world model";
  parameter Boolean useFlange=false
    "= true, if force flange enabled, otherwise implicitly grounded"
      annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));
  parameter StateSelect stateSelect=StateSelect.default
    "Priority to use acceleration as states" annotation(HideResult=true,Dialog(tab="Advanced"));

  parameter SI.Position r[2] "direction of the rod wrt. body system at phi=0";
  final parameter SI.Length l = sqrt(r*r) "lengt of r";
  final parameter SI.Distance e[2]= r/l "normalized r";
  SI.Position s(final stateSelect = stateSelect, start = 0)
    "Elongation of the joint";
  Real e0[2] "direction of the prismatic rod resolved wrt.inertial frame";
  SI.Position r0[2]
    "translation vector of the prismatic rod resolved wrt.inertial frame";
  Real R[2,2] "Rotation Matrix";
  SI.Velocity v(final stateSelect = stateSelect, start = 0)
    "velocity of elongation";
  SI.Acceleration a(start = 0) "acceleration of elongation"                          annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Force f "force in direction of elongation";

  Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a(f = f, s = s) if useFlange
   annotation (
      Placement(transformation(extent={{-8,80},{12,100}}), iconTransformation(
          extent={{-10,80},{10,100}})));

  parameter Boolean animate = true "= true, if animation shall be enabled"
                                           annotation(Dialog(group="Animation"));

  parameter SI.Length zPosition = planarWorld.defaultZPosition
    "z position of the prismatic joint box" annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animate));
  parameter SI.Distance boxWidth=l/planarWorld.defaultWidthFraction
    "Width of prismatic joint box"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input Types.Color boxColor=Types.Defaults.JointColor
    "Color of prismatic joint box"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input Modelica.Mechanics.MultiBody.Types.SpecularCoefficient
    specularCoefficient = planarWorld.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animate));
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
    r={frame_a.x,frame_a.y,zPosition},
    R=MB.Frames.nullRotation()) if planarWorld.enableAnimation and animate;

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
  annotation (Icon(graphics={
        Text(
          extent={{-100,-60},{100,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={85,170,255},
          textString="%name"),
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
          points={{0,80},{0,20}},
          color={0,0,0},
          smooth=Smooth.None)}),Diagram(graphics),
    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p></html>",  info="<html>
<p>Direction of the Joint is determined by <b>r[2]</b>, which is a vector pointing from <b>frame_a</b> to <b>frame_b</b>. </p>
<p>By setting <b>useFlange</b> as true, the flange for a force input will be activated. In the &QUOT;Initialization&QUOT; block, elongation of the joint <b>s</b>, velocity of elongation <b>v</b> as well as acceleration of elongation <b>a</b> can be initialized.</p>
<p>It can be defined via parameter (in &QUOT;advanced&QUOT; tab) <b>stateSelect</b> that the relative distance &QUOT;s&QUOT; and its derivative shall be definitely used as states by setting stateSelect=StateSelect.always. </p>
<p>In &QUOT;Animation&QUOT; Tab, animation parameters for this model can be set, where <b>zPosition</b> represents the model&apos;s position along the z axis in 3D animation. Some of the values can be preset by an outer PlanarWorld model.</p>
</html>"));
end Prismatic;
