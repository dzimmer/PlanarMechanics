within PlanarMechanics.Joints;
model Revolute "A revolute joint"
  extends PlanarMechanics.Interfaces.PartialTwoFrames;

  parameter Boolean useFlange=false
    "= true, if force flange enabled, otherwise implicitly grounded"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean animate = true "= true, if animation shall be enabled" annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter StateSelect stateSelect=StateSelect.default
    "Priority to use phi and w as states" annotation(HideResult=true,Dialog(tab="Advanced"));

  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a(phi = phi, tau = t) if useFlange annotation (
      Placement(transformation(extent={{-10,-110},{10,-90}})));

  Modelica.Mechanics.Rotational.Interfaces.Flange_b support if useFlange
    "1-dim. rotational flange of the drive support (assumed to be fixed in the world frame, NOT in the joint)"
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=180,
        origin={-60,-100})));

  parameter SI.Length zPosition = planarWorld.defaultZPosition
    "Position z of cylinder representing the joint axis" annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animate));
  parameter SI.Distance cylinderLength=planarWorld.defaultJointLength
    "Length of cylinder representing the joint axis"
    annotation (Dialog(tab="Animation",
      group="if animation = true", enable=animate));
  parameter SI.Distance cylinderDiameter=planarWorld.defaultJointWidth
    "Diameter of cylinder representing the joint axis"
    annotation (Dialog(tab="Animation",
      group="if animation = true", enable=animate));
  input PlanarMechanics.Types.Color cylinderColor=Types.Defaults.JointColor
    "Color of cylinder representing the joint axis"
    annotation (HideResult=true, Dialog(colorSelector=true,tab="Animation",
      group="if animation = true", enable=animate));
  input PlanarMechanics.Types.SpecularCoefficient
    specularCoefficient = planarWorld.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (HideResult=true, Dialog(tab="Animation",
      group="if animation = true", enable=animate));
  parameter Boolean extraLine=false
    "Enable black line in the cylinder to show the joint rotation"
    annotation (HideResult = true,
      Dialog(tab="Animation",
      group="if animation = true",enable=animate),choices(checkBox=true));

  SI.Angle phi(final stateSelect = stateSelect, start = 0) "Angular position"
    annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.AngularVelocity w(final stateSelect = stateSelect, start = 0)
    "Angular velocity"
    annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.AngularAcceleration z(start = 0) "Angular acceleration" annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Torque t "Torque";

  // The following is defined in order to omit if-statements in visualization block (cylinder)
protected
  final Modelica.Mechanics.MultiBody.Types.ShapeExtra extra=if extraLine then 1 else 0
    "Extra parameter to visualize black line in visualized cylinder" annotation (HideResult = true);

  //Visualization
public
  MB.Visualizers.Advanced.Shape cylinder(
    shapeType="cylinder",
    color=cylinderColor,
    specularCoefficient=specularCoefficient,
    length=cylinderLength,
    width=cylinderDiameter,
    height=cylinderDiameter,
    lengthDirection={0,0,1},
    widthDirection={1,0,0},
    r_shape={0,0,-cylinderLength/2},
    r=MB.Frames.resolve1(planarWorld.R,{frame_a.x,frame_a.y,zPosition})+planarWorld.r_0,
    R=MB.Frames.absoluteRotation(planarWorld.R,MB.Frames.planarRotation({0,0,1}, phi, w)),
    extra=extra) if planarWorld.enableAnimation and animate;

protected
  Modelica.Mechanics.Rotational.Components.Fixed fixed
    "support flange is fixed to ground"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-60,-80})));

equation
  //Differential Equations
  w = der(phi);
  z = der(w);
  //actutation torque
  if not useFlange then
    t = 0;
  end if;
  //rigidly connect positions
  frame_a.x = frame_b.x;
  frame_a.y = frame_b.y;
  frame_a.phi + phi = frame_b.phi;
  //balance forces
  frame_a.fx + frame_b.fx = 0;
  frame_a.fy + frame_b.fy = 0;
  frame_a.t + frame_b.t = 0;
  frame_a.t = t;
  connect(fixed.flange,support)  annotation (Line(
      points={{-60,-80},{-60,-100}},
      color={0,0,0},
      smooth=Smooth.None));
  annotation (Icon(graphics={
        Text(
          extent={{-150,100},{150,60}},
          textString="%name",
          lineColor={0,0,255}),
        Rectangle(
          extent={{-20,20},{20,-20}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={175,175,175},
          lineColor={0,0,0}),
        Rectangle(
          extent={{-100,60},{-20,-62}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={175,175,175},
          lineColor={0,0,0}),
        Rectangle(
          extent={{20,60},{100,-60}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={175,175,175},
          lineColor={0,0,0}),
        Line(
          visible=useFlange,
          points={{0,-100},{0,-20}}),
        Text(
          extent={{-140,-22},{-104,-47}},
          lineColor={128,128,128},
          textString="a"),
        Text(
          extent={{104,-22},{140,-47}},
          lineColor={128,128,128},
          textString="b"),
        Line(
          visible=useFlange,
          points={{-30,-80},{-50,-100}},
          color={0,0,0}),
        Line(
          visible=useFlange,
          points={{-50,-80},{-70,-100}},
          color={0,0,0}),
        Line(
          visible=useFlange,
          points={{-70,-80},{-90,-100}},
          color={0,0,0}),
        Line(
          visible=useFlange,
          points={{-92,-100},{-30,-100}},
          color={0,0,0}),
        Rectangle(extent={{-100,60},{-20,-62}}, lineColor={0,0,0}),
        Rectangle(extent={{20,62},{100,-60}}, lineColor={0,0,0})}),
    Documentation(
      revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p></html>",
      info="<html>
<p>Joint where frame_b rotates around axis n which is fixed in frame_a. The two frames coincide when the rotation angle &quot;phi = 0&quot;.</p>
<p>By setting <b>useFlange</b> as true, the flange for a 1-dim. rotational input will be activated. In the &quot;Initialization&quot; block, angular position <b>phi</b>, angular velocity <b>w</b> as well as angular acceleration <b>z</b> can be initialized.</p>
<p>It can be defined via parameter (in &quot;advanced&quot; tab) <b>stateSelect</b> that the relative distance &quot;s&quot; and its derivative shall be definitely used as states by setting stateSelect=StateSelect.always. </p>
<p>In &quot;Animation&quot; group, animation parameters for this model can be set, where <b>zPosition</b> represents the model&apos;s position along the z axis in 3D animation. Some of the values can be preset by an outer PlanarWorld model.</p>
</html>"));
end Revolute;
