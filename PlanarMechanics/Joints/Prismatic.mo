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
  final parameter SI.Length l = Modelica.Math.Vectors.length(r) "Length of r";
  final parameter Real e[2](each final unit="1") = Modelica.Math.Vectors.normalizeWithAssert(r)
    "Unit vector in direction of r";

  Modelica.Mechanics.Translational.Interfaces.Flange_a axis(
    f=f,
    s=s) if useFlange
    "1-dim. translational flange that drives the joint"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));

  Modelica.Mechanics.Translational.Interfaces.Flange_b support if useFlange
    "1-dim. translational flange of the drive support (assumed to be fixed in the world frame, NOT in the joint)"
    annotation (Placement(transformation(extent={{-70,-110},{-50,-90}})));

  parameter SI.Length zPosition = planarWorld.defaultZPosition
    "Position z of the prismatic joint box" annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animate));
  parameter SI.Distance boxWidth=l/planarWorld.defaultWidthFraction
    "Width of prismatic joint box"
    annotation (Dialog(tab="Animation",
      group="if animation = true", enable=animate));
  input MB.Types.Color boxColor=Types.Defaults.JointColor
    "Color of prismatic joint box"
    annotation (HideResult=true, Dialog(tab="Animation",
      group="if animation = true", enable=animate, colorSelector=true));
  input MB.Types.SpecularCoefficient specularCoefficient = planarWorld.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (HideResult=true, Dialog(tab="Animation",
      group="if animation = true", enable=animate));

  SI.Position s(final stateSelect = stateSelect, start = 0)
    "Elongation of the joint" annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Velocity v(final stateSelect = stateSelect, start = 0)
    "Velocity of elongation" annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Acceleration a(start = 0) "Acceleration of elongation" annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Force f "Force in direction of elongation";
  Real e0[2] "Unit vector in direction of r resolved w.r.t. inertial frame";
  SI.Position r0[2]
    "Translation vector of the prismatic rod resolved w.r.t. inertial frame";
  PlanarMechanics.Transformations.Internal.TransformationMatrix R=
    PlanarMechanics.Transformations.RbyAngle(frame_a.phi) "Rotation matrix";

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
    r_shape={frame_a.x,frame_a.y,zPosition},
    r=planarWorld.r_0,
    R=planarWorld.R) if planarWorld.enableAnimation and animate;

protected
  Modelica.Mechanics.Translational.Components.Fixed fixed
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-60,-80})));

equation
  //resolve the rod w.r.t. inertial system
  e0 = PlanarMechanics.Transformations.resolve2in1(frame_a.phi, e);
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

  connect(fixed.flange,support)  annotation (Line(
      points={{-60,-80},{-60,-100}},
      color={0,127,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),
                   graphics={
        Rectangle(
          extent={{-100,40},{-20,-40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={175,175,175}),
        Rectangle(
          extent={{-20,-20},{100,20}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={175,175,175}),
        Line(
          visible=useFlange,
          points={{0,-90},{0,-20}},
          color={0,127,0}),
        Text(
          extent={{-140,-22},{-104,-47}},
          textColor={128,128,128},
          textString="a"),
        Text(
          extent={{104,-22},{140,-47}},
          textColor={128,128,128},
          textString="b"),
        Text(
          extent={{-150,100},{150,60}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-100,-50},{100,-80}},
          textColor={0,0,0},
          textString="r=%r"),
        Line(
          visible=useFlange,
          points={{-92,-100},{-30,-100}}),
        Line(
          visible=useFlange,
          points={{-30,-80},{-50,-100}}),
        Line(
          visible=useFlange,
          points={{-50,-80},{-70,-100}}),
        Line(
          visible=useFlange,
          points={{-70,-80},{-90,-100}})}),
    Documentation(
      revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>",
      info="<html>
<p>
Direction of the prismatic joint is determined by <code>r[2]</code>,
which is a&nbsp;vector pointing from <code>frame_a</code> to
<code>frame_b</code>.
</p>
<p>
Optionally, two additional one-dimensional mechanical flanges (flange
<code>flange_a</code> represents the driving flange and flange
<code>support</code> represents the bearing) can be enabled via
parameter <code>useFlange</code>. The enabled <code>flange_a</code>
flange can be driven with elements of the
<a href=\"modelica://Modelica.Mechanics.Translational\">Modelica.Mechanics.Translational</a>
library.
</p>
<p>
In the &quot;Initialization&quot; block, elongation&nbsp;<code>s</code>
of the joint, velocity of elongation&nbsp;<code>v</code> as well as
acceleration of elongation&nbsp;<code>a</code> can be initialized.
</p>
<p>
It can be defined via parameter (in &quot;Advanced&quot; tab)
<code>stateSelect</code> that the relative distance&nbsp;<code>s</code>
and its derivative shall be definitely used as states by setting
<code>stateSelect&nbsp;= StateSelect.always</code>.
</p>
<p>
In &quot;Animation&quot; group, animation parameters for this model can be set,
where <code>zPosition</code> represents the model&apos;s position along
the&nbsp;<var>z</var> axis in 3D animation. Some of the values can be preset
by an outer <a href=\"modelica://PlanarMechanics.PlanarWorld\">PlanarWorld</a>
model.
</p>
</html>"));
end Prismatic;
