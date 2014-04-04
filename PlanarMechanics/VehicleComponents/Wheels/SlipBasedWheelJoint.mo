within PlanarMechanics.VehicleComponents.Wheels;
model SlipBasedWheelJoint

  Interfaces.Frame_a frame_a annotation (Placement(transformation(extent={{-48,0},
            {-28,20}}), iconTransformation(extent={{-68,-20},{-28,20}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a annotation (
      Placement(transformation(extent={{90,-8},{110,12}}), iconTransformation(
          extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput dynamicLoad(unit="N") annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,100}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,100})));
  outer PlanarWorld planarWorld "planar world model";
  parameter StateSelect stateSelect=StateSelect.default
    "Priority to use acceleration as states" annotation(HideResult=true,Dialog(tab="Advanced"));
  parameter SI.Length radius "radius of the wheel";
  parameter SI.Length r[2] "driving direction of the wheel at angle phi = 0";
  parameter SI.Force N "base normal load";
  parameter SI.Velocity vAdhesion_min "minimum adhesion velocity";
  parameter SI.Velocity vSlide_min "minimum sliding velocity";
  parameter Real sAdhesion "adhesion slippage";
  parameter Real sSlide "sliding slippage";
  parameter Real mu_A "friction coefficient at adhesion";
  parameter Real mu_S "friction coefficient at sliding";
  final parameter SI.Length l = sqrt(r*r);
  final parameter Real e[2] =  r/l "normalized direction";
  Real e0[2] "normalized direction w.r.t inertial system";
  Real R[2,2] "Rotation Matrix";
  SI.Angle phi_roll(stateSelect=stateSelect, start=0) "roll angle of the wheel"
                                                                                 annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.AngularVelocity w_roll(final stateSelect=stateSelect, start=0)
    "roll velocity of wheel" annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Velocity v[2] "velocity";
  SI.Velocity v_lat(start=0) "driving in lateral direction"
                                   annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Velocity v_long( start=0) "velocity in longitudinal direction"
                                         annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Velocity v_slip_long(start=0) "slip velocity in longitudinal direction"
                                              annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Velocity v_slip_lat(start=0) "slip velocity in lateral direction"
                                         annotation(Dialog(group="Initialization", showStartAttribute=true));
  SI.Velocity v_slip "slip velocity";
  SI.Force f "longitudinal force";
  SI.Force f_lat "longitudinal force";
  SI.Force f_long "longitudinal force";
  SI.Force fN "base normal load";
  SI.Velocity vAdhesion "adhesion velocity";
  SI.Velocity vSlide "sliding velocity";
  parameter Boolean animate = true "= true, if animation shall be enabled"
                                           annotation(Dialog(group="Animation"));
  parameter SI.Length zPosition = planarWorld.defaultZPosition
    "z position of the body" annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animate));
  parameter SI.Length diameter = 0.1 "diameter of the rims"
                           annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animate));
  parameter SI.Length width = diameter * 0.6 "width of the wheel"
                         annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animate));
  input Modelica.Mechanics.MultiBody.Types.SpecularCoefficient
    specularCoefficient = planarWorld.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animate));

  MB.Visualizers.Advanced.Shape cylinder(
    shapeType="cylinder",
    color={63,63,63},
    specularCoefficient=specularCoefficient,
    length=width,
    width=radius*2,
    height=radius*2,
    lengthDirection={-e0[2],e0[1],0},
    widthDirection={0,0,1},
    r_shape=-0.03*{-e0[2],e0[1],0},
    r={frame_a.x,frame_a.y,zPosition},
    R=MB.Frames.nullRotation()) if planarWorld.enableAnimation and animate;
  MB.Visualizers.Advanced.Shape rim1(
    shapeType="cylinder",
    color={195,195,195},
    specularCoefficient=specularCoefficient,
    length=radius*2,
    width=diameter,
    height=diameter,
    lengthDirection={0,0,1},
    widthDirection={1,0,0},
    r_shape={0,0,-radius},
    r={frame_a.x,frame_a.y,zPosition},
    R=MB.Frames.planarRotation({-e0[2],e0[1],0},flange_a.phi,0)) if planarWorld.enableAnimation and animate;
  MB.Visualizers.Advanced.Shape rim2(
    shapeType="cylinder",
    color={195,195,195},
    specularCoefficient=specularCoefficient,
    length=radius*2,
    width=diameter,
    height=diameter,
    lengthDirection={0,0,1},
    widthDirection={1,0,0},
    r_shape={0,0,-radius},
    r={frame_a.x,frame_a.y,zPosition},
    R=MB.Frames.planarRotation({-e0[2],e0[1],0},flange_a.phi+Modelica.Constants.pi/2,0)) if planarWorld.enableAnimation and animate;
equation
  R = {{cos(frame_a.phi), -sin(frame_a.phi)}, {sin(frame_a.phi),cos(frame_a.phi)}};
  e0 = R*e;
  v = der({frame_a.x,frame_a.y});
  phi_roll = flange_a.phi;
  w_roll = der(phi_roll);
  v_long = v*e0;
  v_lat = -v[1]*e0[2] + v[2]*e0[1];
  v_slip_lat = v_lat - 0;
  v_slip_long = v_long - radius*w_roll;
  v_slip = sqrt(v_slip_long^2 + v_slip_lat^2)+0.0001;
  -f_long*radius = flange_a.tau;
  frame_a.t = 0;
  vAdhesion = noEvent(max(sAdhesion*abs(radius*w_roll),vAdhesion_min));
  vSlide = noEvent(max(sSlide*abs(radius*w_roll),vSlide_min));
  fN = max(0, N+dynamicLoad);
  f = fN*noEvent(Utilities.TripleS_Func(vAdhesion,vSlide,mu_A,mu_S,v_slip));
  f_long =f*v_slip_long/v_slip;
  f_lat  =f*v_slip_lat/v_slip;
  f_long = {frame_a.fx, frame_a.fy}*e0;
  f_lat = {frame_a.fy, -frame_a.fx}*e0;
  annotation (Icon(graphics={
        Rectangle(
          extent={{-40,100},{40,-100}},
          lineColor={95,95,95},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={231,231,231}),
        Line(
          points={{-40,30},{40,30}},
          color={95,95,95},
          smooth=Smooth.None),
        Line(
          points={{-40,-30},{40,-30}},
          color={95,95,95},
          smooth=Smooth.None),
        Line(
          points={{-40,60},{40,60}},
          color={95,95,95},
          smooth=Smooth.None),
        Line(
          points={{-40,80},{40,80}},
          color={95,95,95},
          smooth=Smooth.None),
        Line(
          points={{-40,90},{40,90}},
          color={95,95,95},
          smooth=Smooth.None),
        Line(
          points={{-40,100},{40,100}},
          color={95,95,95},
          smooth=Smooth.None),
        Line(
          points={{-40,-80},{40,-80}},
          color={95,95,95},
          smooth=Smooth.None),
        Line(
          points={{-40,-90},{40,-90}},
          color={95,95,95},
          smooth=Smooth.None),
        Line(
          points={{-40,-100},{40,-100}},
          color={95,95,95},
          smooth=Smooth.None),
        Line(
          points={{-40,-60},{40,-60}},
          color={95,95,95},
          smooth=Smooth.None),
        Rectangle(
          extent={{100,10},{40,-10}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={231,231,231}),
        Text(
          extent={{-100,-100},{100,-140}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={85,170,255},
          textString="%name")}),      Diagram(graphics),
    Documentation(info="<html>
<p><h4><font color=\"#008000\">Slip-Friction based wheel joint</font></h4></p>
<p>The ideal wheel joint models the behavior of a wheel rolling on a x,y-plane whose contact patch has slip-dependent friction characteristics. This is an approximation for wheels with a rim and a rupper tire. </p>
<p>The force depends with friction characteristics on the <b>slip</b> . The <b>slip</b> is split into two components:</p>
<p><ul>
<li>lateral slip: the lateral velocity divided by the rolling velocity.</li>
<li>longitudinal slip: the longitduinal slip velocity divided by the rollign velocity.</li>
</ul></p>
<p><br/>For low rolling velocity this definitions become ill-conditioned. Hence a dry-friction model is used for low rolling velocities.</p>
<p>The radius of the wheel can be specified by the parameter <b>radius</b>. The driving direction (for phi=0) can be specified by the parameter <b>r</b>. The normal load is set by <b>N</b>.</p>
<p>The wheel contains a 2D connector <b>frame_a</b> for the steering on the plane. The rolling motion of the wheel can be actuated by the 1D  connector <b>flange_a</b>. </p>
<p>In addition there is an input for a dynamic component of the normal load.</p>
<p>For examples of usage see the local Examples package.</p>
</html>", revisions="<html>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p>
</html>"));
end SlipBasedWheelJoint;
