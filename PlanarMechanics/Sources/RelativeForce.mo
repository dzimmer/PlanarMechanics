within PlanarMechanics.Sources;
model RelativeForce "Input signal acting as force and torque on two frames"
  extends PlanarMechanics.Interfaces.PartialTwoFrames;

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB resolveInFrame=
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a
    "Frame in which output vector r_rel shall be resolved (1: world, 2: frame_a, 3: frame_b, 4: frame_resolve)";
  parameter Boolean animation=true "= true, if animation shall be enabled";

  parameter Real N_to_m(unit="N/m") = planarWorld.defaultN_to_m
    "Force arrow scaling (length = force/N_to_m)"
    annotation (Dialog(tab="Animation",group="If animation = true", enable=animation));
  parameter Real Nm_to_m(unit="N.m/m") = planarWorld.defaultNm_to_m
    "Torque arrow scaling (length = torque/Nm_to_m)"
    annotation (Dialog(tab="Animation",group="If animation = true", enable=animation));

  parameter SI.Length zPosition = planarWorld.defaultZPosition
    "Position z of cylinder representing the fixed translation"
    annotation (Dialog(tab="Animation",group="If animation = true", enable=animation));
  input MB.Types.Color color= PlanarMechanics.Types.Defaults.ForceColor
    "Color of arrow"
    annotation (HideResult=true, Dialog(tab="Animation",group="If animation = true",colorSelector=true,  enable=animation));
  input MB.Types.SpecularCoefficient specularCoefficient = planarWorld.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (HideResult=true, Dialog(tab="Animation",group="If animation = true",enable=animation));

  Modelica.Blocks.Interfaces.RealInput force[3]
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={-60,-120}, rotation=90)));

  Real R[2,2] "Rotation matrix";
  SI.Angle phi "Rotation angle of the additional frame_c";

  Interfaces.Frame_resolve frame_resolve(fx = 0, fy = 0, t = 0, phi = phi) if resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve
    "Coordinate system in which vector is optionally resolved, if useExtraFrame is true"
    annotation (
      Placement(transformation(extent={{-16,-16},{16,16}},
        rotation=90,
        origin={40,-100})));

protected
  SI.Position f_in_m[3]={force[1],force[2],0}/N_to_m "Force mapped from N to m for animation";
  SI.Position t_in_m[3]={0,0,force[3]}/Nm_to_m "Torque mapped from N.m to m for animation";
  MB.Frames.Orientation R_0 = MB.Frames.absoluteRotation(planarWorld.R,MB.Frames.planarRotation({0, 0, 1},phi,der(phi)));
  SI.Position rvisobj[3] = MB.Frames.resolve1(planarWorld.R,{frame_b.x,frame_b.y,zPosition}) + planarWorld.r_0;

  MB.Visualizers.Advanced.Vector arrowForce(
    coordinates=f_in_m,
    color=color,
    specularCoefficient=specularCoefficient,
    r=rvisobj,
    quantity=Modelica.Mechanics.MultiBody.Types.VectorQuantity.Force,
    headAtOrigin=true,
    R=R_0) if planarWorld.enableAnimation and animation;
  MB.Visualizers.Advanced.Vector arrowTorque(
    coordinates=t_in_m,
    color=color,
    specularCoefficient=specularCoefficient,
    r=rvisobj,
    quantity=Modelica.Mechanics.MultiBody.Types.VectorQuantity.Torque,
    headAtOrigin=true,
    R=planarWorld.R) if planarWorld.enableAnimation and animation;

equation
  if resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a then
    phi = frame_a.phi;
    //R = {{cos(frame_a.phi), -sin(frame_a.phi)}, {sin(frame_a.phi),cos(frame_a.phi)}};
  elseif resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_b then
    phi = frame_b.phi;
    //R = {{cos(frame_b.phi), -sin(frame_b.phi)}, {sin(frame_b.phi),cos(frame_b.phi)}};
    //R = {{cos(frame_resolve.phi), -sin(frame_resolve.phi)}, {sin(frame_resolve.phi),cos(frame_resolve.phi)}};
  elseif resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.world then
    phi = 0;
  end if;
    R = {{cos(phi), -sin(phi)}, {sin(phi),cos(phi)}};
    {frame_b.fx, frame_b.fy} + R * {force[1], force[2]} = {0, 0};
    frame_b.t + force[3] = 0;

    frame_a.fx + frame_b.fx = 0;
    frame_a.fy + frame_b.fy = 0;
    frame_a.t + frame_b.t = 0;

  annotation (
    Icon(
      coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Line(
          points={{30,0},{30,-100}},
          color={95,95,95},
          pattern=LinePattern.Dot),
        Line(
          points={{-60,-100},{30,-100}},
          color={95,95,95},
          pattern=LinePattern.Dot),
        Polygon(
          points={{14,10},{44,10},{44,40},{94,0},{44,-40},{44,-10},{14,-10},{14,10}},
          lineColor={0,127,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-14,10},{-44,10},{-44,40},{-94,0},{-44,-40},{-44,-10},{-14,-10},{-14,10}},
          lineColor={0,127,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,110},{150,70}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-108,-24},{-72,-49}},
          textColor={128,128,128},
          textString="a"),
        Text(
          extent={{72,-24},{108,-49}},
          textColor={128,128,128},
          textString="b")}),
    Documentation(
      info="<html>
<p>
The <strong>3</strong> signals of the <strong>force</strong> connector contain force and torque.
The first and second signal are interpreted as the x- and y-coordinates of
a&nbsp;<strong>force</strong> and the third is torque, acting between two frame connectors
to which <code>frame_a</code> and <code>frame_b</code> are attached respectively.
Note that torque is a&nbsp;scalar quantity, which is exerted perpendicular
to the x-y plane.
</p>
<p>
Parameter <code><strong>resolveInFrame</strong></code> defines in which frame the input
force shall be resolved.
</p>

<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\">
<tr>
<th>Types.ResolveInFrameB.</th>
<th>Meaning</th>
</tr>
<tr>
<td valign=\"top\">world</td>
<td valign=\"top\">Resolve input force in world frame (= default)</td>
</tr>
<tr>
<td valign=\"top\">frame_a</td>
<td valign=\"top\">Resolve input force in frame_a</td>
</tr>
<tr>
<td valign=\"top\">frame_b</td>
<td valign=\"top\">Resolve input force in frame_b</td>
</tr>
<tr>
<td valign=\"top\">frame_resolve</td>
<td valign=\"top\">Resolve input force in frame_resolve (frame_resolve must be connected)</td>
</tr>
</table>

<p>
If resolveInFrame&nbsp;=&nbsp;Types.ResolveInFrameAB.frame_resolve,
the force coordinates shall be resolved in the frame, which is
connected to <strong>frame_resolve</strong>.
</p>
</html>",
      revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>"));
end RelativeForce;
