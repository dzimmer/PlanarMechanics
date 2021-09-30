within PlanarMechanics.Joints;
model DryFrictionBasedRolling
  "A joint representing a wheel with slip-based rolling (dry friction law) on the x-axis"

  extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPort(
    final T=293.15);

  Interfaces.Frame_a frame_a
    annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));
  outer PlanarWorld planarWorld "Planar world model";

  parameter StateSelect stateSelect=StateSelect.default
    "Priority to use phi, w and a as states" annotation(HideResult=true,Dialog(tab="Advanced"));
  parameter SI.Length R = 1.0 "Radius of the wheel";
  parameter SI.Velocity vAdhesion "Adhesion velocity";
  parameter SI.Velocity vSlide "Sliding velocity";
  parameter Real mu_A "Friction coefficient at adhesion";
  parameter Real mu_S "Friction coefficient at sliding";

  parameter Boolean animate = true "Enable animation"
                                                     annotation(Dialog(group="Animation"));
  SI.Position x(stateSelect=stateSelect,start = 0) "Horizontal position" annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Angle phi(stateSelect=stateSelect,start = 0) "Angular position" annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.AngularVelocity w(stateSelect=stateSelect,start = 0) "Angular velocity" annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.AngularAcceleration z(start = 0) "Angular acceleration"
                           annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Velocity vx(stateSelect=stateSelect,start = 0) "Velocity in x-direction" annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Force N "Normal force";
  SI.Velocity v_slip "Slip velocity";
  //Visualization
  MB.Visualizers.Advanced.Shape cylinder(
    shapeType="cylinder",
    color={255,0,0},
    specularCoefficient=0.5,
    length=0.06,
    width=2*R,
    height=2*R,
    lengthDirection={0,0,1},
    widthDirection={1,0,0},
    r_shape={0,0,-0.03},
    r=MB.Frames.resolve1(planarWorld.R,{frame_a.x,frame_a.y,0})+planarWorld.r_0,
    R=planarWorld.R)  if planarWorld.enableAnimation and animate;
  MB.Visualizers.Advanced.Shape rim1(
    shapeType="cylinder",
    color={195,195,195},
    specularCoefficient=0.5,
    length=R*2,
    width=0.1,
    height=0.1,
    lengthDirection={1,0,0},
    widthDirection={0,0,1},
    r_shape={-R,0,0},
    r=MB.Frames.resolve1(planarWorld.R,{frame_a.x,frame_a.y,0})+planarWorld.r_0,
    R=MB.Frames.absoluteRotation(planarWorld.R,MB.Frames.planarRotation({0,0,1},phi,0)))
      if planarWorld.enableAnimation and animate;
  MB.Visualizers.Advanced.Shape rim2(
    shapeType="cylinder",
    color={195,195,195},
    specularCoefficient=0.5,
    length=R*2,
    width=0.1,
    height=0.1,
    lengthDirection={1,0,0},
    widthDirection={0,0,1},
    r_shape={-R,0,0},
    r=MB.Frames.resolve1(planarWorld.R,{frame_a.x,frame_a.y,0})+planarWorld.r_0,
    R=MB.Frames.absoluteRotation(planarWorld.R,MB.Frames.planarRotation({0,0,1},phi-Modelica.Constants.pi/2,0)))
       if planarWorld.enableAnimation and animate;
initial equation
  //Initialization of Position and Velocity
equation
  frame_a.x = x;
  phi = frame_a.phi;
  //Differential Equations
  w = der(phi);
  z = der(w);
  vx = der(frame_a.x);
  //holonomic constraint
  frame_a.y = R;
  //dry-friction law
  v_slip = vx + w*R;
  N = -frame_a.fy;
  frame_a.fx =N*noEvent(Utilities.Functions.limitByStriple(
    vAdhesion,
    vSlide,
    mu_A,
    mu_S,
    v_slip));
  //balance forces
  frame_a.fx*R = frame_a.t;
  lossPower = frame_a.fx*v_slip;
  annotation (Icon(graphics={
        Ellipse(
          extent={{-80,80},{80,-80}},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-70,70},{70,-70}},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,0},{-100,0}},
          color={0,0,255}),
        Ellipse(
          extent={{-20,20},{20,-20}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Text(
          extent={{-150,120},{150,80}},
          textString="%name",
          textColor={0,0,255}),
        Line(
          visible=useHeatPort,
          points={{-100,-100},{-100,-80},{0,-80}},
          color={191,0,0},
          pattern=LinePattern.Dot),
        Text(
          extent={{-150,-90},{150,-120}},
          textColor={0,0,0},
          textString="R=%R")}),
    Documentation(
      revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<b>Developed 2010-2020 at the DLR Institute of System Dynamics and Control</b>
</p>
</html>",
      info="<html>
<p>Model SlipBasedRolling contains only one connector frame_a lying at the center of the wheel, where slip occurs between the wheel and ground and force caused by that is also taken into account.</p>
<p>The ground is hereby represented by the x-axis.</p>
</html>"));
end DryFrictionBasedRolling;
