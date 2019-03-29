within PlanarMechanics.Parts;
model SpringDamper "Linear 2D translational spring damper model"
  extends BaseClasses.TwoConnectorShapes;
  extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPort(
    final T=293.15);

  parameter StateSelect stateSelect=StateSelect.default
    "Priority to use phi, w and a as states" annotation(HideResult=true,Dialog(tab="Advanced"));
  parameter SI.TranslationalSpringConstant c_x(final min=0, start=1)
    "Spring constant in x dir";
  parameter SI.TranslationalSpringConstant c_y(final min=0, start=1)
    "Spring constant in y dir";
  parameter SI.RotationalSpringConstant c_phi(final min=0, start=1.0e5)
    "Spring constant in phi dir";
  parameter SI.TranslationalDampingConstant d_x(final min=0, start=1)
    "Damping constant in x dir";
  parameter SI.TranslationalDampingConstant d_y(final min=0, start=1)
    "Damping constant in y dir";
  parameter SI.RotationalDampingConstant d_phi(final min=0, start=1)
    "Damping constant in phi dir";
  parameter SI.Position s_relx0=0 "Unstretched spring length";
  parameter SI.Position s_rely0=0 "Unstretched spring length";
  parameter SI.Angle phi_rel0=0 "Unstretched spring angle";

  SI.Velocity v_relx "Spring velocity";
  SI.Velocity v_rely "Spring velocity";
  SI.AngularVelocity w_rel(start=0) "Spring anglular velocity" annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Position s_relx(final stateSelect=stateSelect) "Spring length";
  SI.Position s_rely(final stateSelect=stateSelect) "Spring length";
  SI.Angle phi_rel(start=0, final stateSelect=stateSelect) "Spring angle" annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Force f_x "Force in x direction";
  SI.Force f_y "Force in y direction";
  SI.Torque tau "Torque between frames (= frame_b.f)";

  parameter SI.Position s_small = 1.E-10
    "Prevent zero-division if distance between frame_a and frame_b is zero" annotation (Dialog(
      tab="Advanced"));

  parameter Boolean enableAssert = true
    "Cause an assert when the distance between frame_a and frame_b < s_small" annotation (Dialog(
      tab="Advanced"));

  //Visualization
  parameter Integer numberOfWindings = 5 "Number of spring windings"
    annotation (Dialog(tab="Animation", group="Spring coil (if animation = true)", enable=animate));
  input SI.Length width = planarWorld.defaultJointWidth "Width of spring"
    annotation (Dialog(tab="Animation", group="Spring coil (if animation = true)", enable=animate));
  input SI.Length coilWidth = width/10 "Width of spring coil"
    annotation (Dialog(tab="Animation", group="Spring coil (if animation = true)", enable=animate));
  input Types.Color color = Types.Defaults.SpringColor "Color of spring"
    annotation (HideResult=true, Dialog(tab="Animation", group="Spring coil (if animation = true)", enable=animate, colorSelector=true));

  parameter SI.Length length_a = planarWorld.defaultForceLength
    "Length of cylinder at frame_a side"
    annotation (Dialog(tab="Animation", group="Damper cylinders (if animation = true)", enable=animate));
  input SI.Diameter diameter_a = planarWorld.defaultForceWidth
    "Diameter of cylinder at frame_a side"
    annotation (Dialog(tab="Animation", group="Damper cylinders (if animation = true)", enable=animate));
  input SI.Diameter diameter_b = 0.6*diameter_a
    "Diameter of cylinder at frame_b side"
    annotation (Dialog(tab="Animation", group="Damper cylinders (if animation = true)", enable=animate));
  input Types.Color color_a = {100,100,100} "Color of cylinder at frame_a side"
    annotation (HideResult=true, Dialog(tab="Animation", group="Damper cylinders (if animation = true)", enable=animate, colorSelector=true));
  input Types.Color color_b = {155,155,155} "Color of cylinder at frame_b side"
    annotation (HideResult=true, Dialog(tab="Animation", group="Damper cylinders (if animation = true)", enable=animate, colorSelector=true));

  SI.Length length
    "Distance between the origin of frame_a and the origin of frame_b";
  SI.Position r_rel_0[3]
    "Position vector (3D) from frame_a to frame_b resolved in multibody world frame";
  Real e_rel_0[3](each final unit="1")
    "Unit vector (3D) in direction from frame_a to frame_b, resolved in multibody world frame";

protected
  MB.Visualizers.Advanced.Shape shapeCoil(
    shapeType="spring",
    color=color,
    specularCoefficient=specularCoefficient,
    length=length,
    width=width,
    height=coilWidth*2,
    lengthDirection=e_rel_0,
    widthDirection= {0,1,0},
    extra=numberOfWindings,
    r=MB.Frames.resolve1(planarWorld.R,{frame_a.x,frame_a.y,zPosition})+planarWorld.r_0,
    R=planarWorld.R) if planarWorld.enableAnimation and animate;
  MB.Visualizers.Advanced.Shape cylinderDamper_a(
    shapeType="cylinder",
    color=color_a,
    specularCoefficient=specularCoefficient,
    length=noEvent(min(length_a, length)),
    width=diameter_a,
    height=diameter_a,
    lengthDirection={s_relx, s_rely, 0},
    widthDirection={0,1,0},
    r=MB.Frames.resolve1(planarWorld.R,{frame_a.x,frame_a.y,zPosition})+planarWorld.r_0,
    R=planarWorld.R) if planarWorld.enableAnimation and animate;
  MB.Visualizers.Advanced.Shape cylinderDamper_b(
    shapeType="cylinder",
    color=color_b,
    specularCoefficient=specularCoefficient,
    length=noEvent(max(length - length_a, 0)),
    width=diameter_b,
    height=diameter_b,
    lengthDirection={s_relx, s_rely, 0},
    widthDirection={0,1,0},
    r_shape=Modelica.Math.Vectors.normalize(r_rel_0) * noEvent(min(length_a, length)),
    r=MB.Frames.resolve1(planarWorld.R,{frame_a.x,frame_a.y,zPosition})+planarWorld.r_0,
    R=planarWorld.R) if planarWorld.enableAnimation and animate;

equation
  if enableAssert then
    assert(noEvent(length > s_small), "
 The distance between the origin of frame_a and the origin of frame_b
 of a Spring component became smaller as parameter s_small
 (= a small number, defined in the \"Advanced\" menu). The distance is
 set to s_small, although it is smaller, to avoid a division by zero
 when computing the direction of the line force. Possible reasons
 for this situation:
 - At initial time the distance may already be zero: Change the initial
   positions of the bodies connected by this element.
 - Hardware stops are not modeled or are modeled not stiff enough.
   Include stops, e.g., stiff springs, or increase the stiffness
   if already present.
 - Another error in your model may lead to unrealistically large forces
   and torques that would in reality destroy the stops.
 - The flange_b connector might be defined by a pre-defined motion,
   e.g., with Modelica.Mechanics.Translational.Position and the
   predefined flange_b.s is zero or negative.
",    level = AssertionLevel.warning);
  end if;

  r_rel_0 = {s_relx, s_rely, 0};
  length = Modelica.Math.Vectors.length(r_rel_0);
  e_rel_0 = r_rel_0/MB.Frames.Internal.maxWithoutEvent(length, s_small);

  s_relx = frame_b.x-frame_a.x;
  s_rely = frame_b.y-frame_a.y;
  v_relx = der(s_relx);
  v_rely = der(s_rely);
  w_rel = der(phi_rel);
  phi_rel = frame_b.phi - frame_a.phi;

  tau = c_phi*(phi_rel - phi_rel0) + d_phi*w_rel;
  frame_a.t = -tau;
  frame_b.t = tau;
  f_x = c_x*(s_relx - s_relx0) + d_x*v_relx;
  f_y = c_y*(s_rely - s_rely0) + d_y*v_rely;
  frame_a.fx = -f_x;
  frame_b.fx = f_x;
  frame_a.fy = -f_y;
  frame_b.fy = f_y;

  lossPower = d_x*v_relx*v_relx + d_y*v_rely*v_rely;
  annotation (
    Documentation(revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<b>Developed 2010-2019 at the DLR Institute of System Dynamics and Control</b>
</p>
</html>",  info="<html>
<p>A <i>linear translational spring-damper</i>. x- and y direction stiffness and damping can be parameterized.</p>
</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(
          points={{-80,40},{-58,40},{-43,10},{-13,70},{17,10},{47,70},{62,40},{80,40}}, color={0,0,0}),
        Line(points={{-70,-106},{-70,-41}}, color={128,128,128}),
        Line(points={{70,-106},{70,-41}}, color={128,128,128}),
        Line(points={{-70,-100},{70,-100}}, color={128,128,128}),
        Polygon(
          points={{60,-97},{70,-100},{60,-103},{60,-97}},
          lineColor={128,128,128},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-40,-96},{40,-76}},
          lineColor={128,128,128},
          textString="phi_rel"),
        Rectangle(
          extent={{-50,-10},{40,-70}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-50,-70},{54,-70}}),
        Line(points={{-50,-10},{54,-10}}),
        Line(points={{40,-40},{80,-40}}),
        Line(points={{-80,-40},{-50,-40}}),
        Line(points={{-80,40},{-80,-40}}),
        Line(points={{80,40},{80,-40}}),
        Line(points={{-96,0},{-80,0}}),
        Line(points={{96,0},{80,0}}),
        Text(
          extent={{-150,120},{150,80}},
          textString="%name",
          lineColor={0,0,255}),
        Line(
          visible=useHeatPort,
          points={{-100,-100},{-100,-60},{-40,-60},{-20,-40}},
          color={191,0,0},
          pattern=LinePattern.Dot)}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(
          points={{-80,32},{-58,32},{-43,2},{-13,62},{17,2},{47,62},{62,32},
              {80,32}},
          thickness=0.5),
        Line(points={{-68,32},{-68,97}}, color={128,128,128}),
        Line(points={{72,32},{72,97}}, color={128,128,128}),
        Line(points={{-68,92},{72,92}}, color={128,128,128}),
        Polygon(
          points={{62,95},{72,92},{62,89},{62,95}},
          lineColor={128,128,128},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-20,72},{20,97}},
          lineColor={0,0,255},
          textString="phi_rel"),
        Rectangle(
          extent={{-50,-20},{40,-80}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-50,-80},{68,-80}}),
        Line(points={{-50,-20},{68,-20}}),
        Line(points={{40,-50},{80,-50}}),
        Line(points={{-80,-50},{-50,-50}}),
        Line(points={{-80,32},{-80,-50}}),
        Line(points={{80,32},{80,-50}}),
        Line(points={{-100,0},{-80,0}}),
        Line(points={{100,0},{80,0}})}));
end SpringDamper;
