within PlanarMechanics.Joints;
model DryFrictionBasedRolling
  "A joint representing a wheel with slip-based rolling (dry friction law) on the x-axis"

  Interfaces.Frame_a frame_a
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-120,-20},{-80,20}})));
  outer PlanarWorld planarWorld "planar world model";

  parameter StateSelect stateSelect=StateSelect.default
    "Priority to use phi, w and a as states" annotation(HideResult=true,Dialog(tab="Advanced"));
  parameter SI.Length R = 1.0 "Radius of the wheel";
  parameter SI.Velocity vAdhesion "adhesion velocity";
  parameter SI.Velocity vSlide "sliding velocity";
  parameter Real mu_A "friction coefficient at adhesion";
  parameter Real mu_S "friction coefficient at sliding";
  parameter Boolean initialize = false "Initialize Position and Velocity";

  parameter Boolean animate = true "enable Animation"
                                                     annotation(Dialog(group="Animation"));
  SI.Position x(stateSelect=stateSelect,start = 0) "Horizontal position" annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Angle phi(stateSelect=stateSelect,start = 0) "Angular position" annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.AngularVelocity w(stateSelect=stateSelect,start = 0) "Angular velocity" annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.AngularAcceleration z(start = 0) "Angular acceleration"
                           annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Velocity vx(stateSelect=stateSelect,start = 0) "Velocity in x-direction" annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Force N "normal force";
  SI.Velocity v_slip "slip velocity";
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
    r={frame_a.x,frame_a.y,0},
    R=MB.Frames.nullRotation()) if  planarWorld.enableAnimation and animate;
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
    r={frame_a.x,frame_a.y,0},
    R=MB.Frames.planarRotation({0,0,1},phi,0)) if  planarWorld.enableAnimation and animate;
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
    r={frame_a.x,frame_a.y,0},
    R=MB.Frames.planarRotation({0,0,1},phi-Modelica.Constants.pi/2,0)) if  planarWorld.enableAnimation and animate;
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
  frame_a.fx = N*noEvent(Utilities.TripleS_Func(vAdhesion,vSlide,mu_A,mu_S,v_slip));
  //balance forces
  frame_a.fx*R = frame_a.t;
  annotation (Icon(graphics={
        Text(
          extent={{-100,-80},{100,-120}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={85,170,255},
          textString="%name"),
        Ellipse(
          extent={{-80,80},{80,-80}},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Ellipse(
          extent={{-70,70},{70,-70}},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Ellipse(
          extent={{-20,20},{20,-20}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Line(
          points={{-20,0},{-92,0}},
          color={0,0,255},
          smooth=Smooth.None)}),      Diagram(graphics),
    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p></html>",  info="<html>
<p>Model SlipBasedRolling contains only one connector frame_a lying at the center of the wheel, where slip occurs between the wheel and ground and force caused by that is also taken into account.</p>
<p>The ground is hereby represented by the x-axis.</p>
</html>"));
end DryFrictionBasedRolling;
