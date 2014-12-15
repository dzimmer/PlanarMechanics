within PlanarMechanics.Joints;
model IdealRolling "A joint representing a wheel ideally rolling on the x-axis"

  Interfaces.Frame_a frame_a
    annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));

  outer PlanarWorld planarWorld "Planar world model";

  parameter SI.Length R = 1.0 "Radius of the wheel";
  parameter StateSelect stateSelect=StateSelect.default
    "Priority to use phi, w and a as states" annotation(HideResult=true,Dialog(tab="Advanced"));
  //parameter SI.Angle phi_start = 0;
  //parameter SI.AngularVelocity w_start = 0;
  parameter Boolean animate = true "Enable animation" annotation(Dialog(group="Animation"));
  SI.Position x(stateSelect=stateSelect, start = 0) "Horizontal position" annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Angle phi(stateSelect=stateSelect,start = 0) "Angular position" annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.AngularVelocity w(stateSelect=stateSelect,start = 0) "Angular velocity" annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.AngularAcceleration z(start = 0) "Angular acceleration" annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Velocity vx(start = 0) "Velocity in x-direction" annotation(Dialog(group="Initialization", showStartAttribute=true));
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

equation
  //Differential Equations
  x = frame_a.x;
  phi = frame_a.phi;
  w = der(phi);
  z = der(w);
  vx = der(frame_a.x);
  //holonomic constraint
  frame_a.y = R;
  //non-holonomic constraint
  vx = -w*R;
  //balance forces
  frame_a.fx*R = frame_a.t;

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
        Line(points={{0,0},{-100,0}}, color={0,0,255}),
        Ellipse(
          extent={{-20,20},{20,-20}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Text(
          extent={{-150,120},{150,80}},
          textString="%name",
          lineColor={0,0,255})}),
      Documentation(
        revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p></html>",
        info="<html>
<p>Model IdealRolling contains only one connector frame_a lying at the center of the wheel, where it is assumed that no slip occurs between the wheel and ground.</p>
<p>The ground is hereby represented by the x-axis.</p>
</html>"));
end IdealRolling;
