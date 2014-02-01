within PlanarMechanics.Sources;
model RelativeForce
   extends PlanarMechanics.Interfaces.PartialTwoFlanges;

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB
    resolveInFrame=
  Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a
    "Frame in which output vector r_rel shall be resolved (1: world, 2: frame_a, 3: frame_b, 4: frame_resolve)";

  Modelica.Blocks.Interfaces.RealInput force[3] annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=0,
        origin={0,50})));

  Real R[2,2] "Rotation matrix";
  SI.Angle phi "rotation angle of the additional frame_c";

  Interfaces.Frame_resolve frame_resolve(fx = 0, fy = 0, t = 0, phi = phi) if resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve
    "Coordinate system in which vector is optionally resolved, if useExtraFrame is true "
                                                                                            annotation (
      Placement(transformation(extent={{0,-60},{20,-40}}), iconTransformation(
          extent={{-40,-40},{-20,-20}})));

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
  annotation (Icon(graphics={
        Polygon(
          points={{-100,10},{20,10},{20,41},{90,0},{20,-41},{20,-10},{-100,-10},
              {-100,10}},
          lineColor={0,127,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,-40},{100,-80}},
          textString="%name",
          lineColor={0,0,0})}),
              Diagram(graphics),
    Documentation(revisions="<html><p><img src=\"./Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p></html>",  info="<html>
<p>The <b>3</b> signals of the <b>force</b> connector contain force and torque. The first and second signal are interpreted as the x- and y-coordinates of a <b>force</b> and the third is torque, acting between two frame connectors to which frame_a and frame_b are attached respectively. Note that torque is a scalar quantity, which is exerted perpendicular to the x-y plane.</p>
<p>Parameter <code><b>resolveInFrame</b> defines in which frame the input force shall be resolved.</code></p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\"><tr>
<td><p align=\"center\"><h4>Types.ResolveInFrameB.</h4></p></td>
<td><p align=\"center\"><h4>Meaning</h4></p></td>
</tr>
<tr>
<td valign=\"top\"><p>world</p></td>
<td valign=\"top\"><p>Resolve input force in world frame (= default)</p></td>
</tr>
<tr>
<td valign=\"top\"><p>frame_a</p></td>
<td valign=\"top\"><p>Resolve input force in frame_a</p></td>
</tr>
<tr>
<td valign=\"top\"><p>frame_b</p></td>
<td valign=\"top\"><p>Resolve input force in frame_b</p></td>
</tr>
<tr>
<td valign=\"top\"><p>frame_resolve</p></td>
<td valign=\"top\"><p>Resolve input force in frame_resolve (frame_resolve must be connected)</p></td>
</tr>
</table>
<p><br/>If resolveInFrame = Types.ResolveInFrameAB.frame_resolve, the force coordinates shall be resolved in the frame, which is connected to <b>frame_resolve</b>.</p>
</html>"));
end RelativeForce;
