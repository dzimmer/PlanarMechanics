within PlanarMechanics.Sources;
model WorldForce
  "External force and torque acting at frame_b, defined by 3 input signals and resolved in world frame"

  outer PlanarWorld planarWorld "Planar world model";

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameB
    resolveInFrame = Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_b
    "Frame in which output vector r_rel shall be resolved (1: world, 2: frame_b, 3: frame_resolve)";
  parameter Boolean animation=true "= true, if animation shall be enabled";

   parameter Real N_to_m(unit="N/m") = planarWorld.defaultN_to_m
    "Force arrow scaling (length = force/N_to_m)"
    annotation (Dialog(tab="Animation",group="If animation = true", enable=animation));
  parameter Real Nm_to_m(unit="N.m/m") = planarWorld.defaultNm_to_m
    "Torque arrow scaling (length = torque/Nm_to_m)"
    annotation (Dialog(tab="Animation",group="If animation = true", enable=animation));

  input SI.Diameter diameter = planarWorld.defaultArrowDiameter
    "Diameter of force arrow" annotation (Dialog(tab="Animation",group="If animation = true", enable=animation));
  parameter SI.Length zPosition = planarWorld.defaultZPosition
    "Position z of cylinder representing the fixed translation" annotation (Dialog(
      tab="Animation",group="If animation = true", enable=animation));
  input Types.Color color= PlanarMechanics.Types.Defaults.ForceColor
    "Color of arrow"
    annotation (HideResult=true, Dialog(tab="Animation",group="If animation = true",colorSelector=true,  enable=animation));
  input Types.SpecularCoefficient specularCoefficient = planarWorld.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (HideResult=true, Dialog(tab="Animation",group="If animation = true",enable=animation));

  Interfaces.Frame_b frame_b
    "Coordinate system fixed to the component with one cut-force and cut-torque"
    annotation (Placement(transformation(extent={{84,-16},{116,16}})));

  Modelica.Blocks.Interfaces.RealInput force[3]
    "x-, y-coordinates of force and torque resolved in world frame"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

  Interfaces.Frame_resolve frame_resolve(fx = 0, fy = 0, t = 0, phi = phi) if resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_resolve
    "Coordinate system in which vector is optionally resolved, if useExtraFrame is true"
    annotation (
      Placement(transformation(extent={{-16,-16},{16,16}},rotation=90,origin={0,-40})));

  Real R[2,2] "Rotation matrix";
  SI.Angle phi "Rotation angle of the additional frame_c";

protected
  SI.Position f_in_m[3]={force[1],force[2],0}/N_to_m
    "Force mapped from N to m for animation";
  SI.Position t_in_m[3]={0,0,force[3]}/Nm_to_m
    "Torque mapped from Nm to m for animation";

  PlanarMechanics.Visualizers.Advanced.Arrow arrow(
    diameter=diameter,
    color=color,
    specularCoefficient=specularCoefficient,
    R=MB.Frames.absoluteRotation(planarWorld.R,MB.Frames.planarRotation({0, 0, 1},phi,der(phi))),
    r=MB.Frames.resolve1(planarWorld.R,{frame_b.x,frame_b.y,zPosition})+planarWorld.r_0,
    r_tail=-f_in_m,
    r_head=f_in_m) if planarWorld.enableAnimation and animation;

 PlanarMechanics.Visualizers.Advanced.DoubleArrow doubleArrow(
    diameter=diameter,
    color=color,
    specularCoefficient=specularCoefficient,
    R=MB.Frames.absoluteRotation(planarWorld.R,MB.Frames.planarRotation({0, 1, 0},Modelica.Constants.pi,0)),
    r=MB.Frames.resolve1(planarWorld.R,{frame_b.x,frame_b.y,zPosition})+planarWorld.r_0,
    r_tail=t_in_m,
    r_head=-t_in_m) if planarWorld.enableAnimation and animation;
equation
  if resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_b then
    phi = frame_b.phi;
  elseif resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.world then
    phi = 0;
  end if;

  R = {{cos(phi), -sin(phi)}, {sin(phi),cos(phi)}};
  {frame_b.fx,frame_b.fy} + R*{force[1], force[2]} = {0, 0};
  frame_b.t +  force[3]= 0;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                   graphics={
        Polygon(
          points={{-100,10},{20,10},{20,41},{90,0},{20,-41},{20,-10},{-100,-10},
              {-100,10}},
          lineColor={0,127,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,80},{150,40}},
          fillPattern=FillPattern.Sphere,
          textString="%name",
          lineColor={0,0,255})}),   Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p></html>",  info="<html>
<p>The <b>3</b> signals of the <b>force</b> connector contain force and torque. The first and second signal are interpreted as the x- and y-coordinates of a <b>force</b> and the third is torque, acting at the frame connector to which <b>frame_b</b> of this component is attached. Note that torque is a scalar quantity, which is exerted perpendicular to the x-y plane.</p>
<p>An example of this model is given in the following figure:</p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/WorldForce.png\"/></p>
<p>The parameter ResolveinFrame defines in which frame the input force shall be resolved.</p>
</html>"));
end WorldForce;
